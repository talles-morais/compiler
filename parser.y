%{
  #include <iostream>
  #include <string>
  #include <unordered_map>
  #define YYERROR_VERBOSE

  using std::string;
  using std::unordered_map;
  using std::cout;

  extern int yylex();
  extern int yyparse();
  extern void yyerror(const char *);

  unordered_map<string, double> num_variables;
  unordered_map<string, string> str_variables;
%}

%union { 
  double num;
  char *str;
  int logic;
}

%token <str> ID
%token <str> STRING
%token <num> NUMBER

%token ASSIGN
%token TYPE_NB
%token TYPE_STR
%token BGN
%token END

%token PRINT

%token IF
%token ELSE
%token ELIF

%token FOR
%token WHILE

%token EQ
%token NEQ
%token GRT
%token GRTEQ
%token LESS
%token LESSEQ

%token AND
%token OR
%token NOT

%token SUM
%token SUB
%token MULT
%token DIV
%token MOD

%token COMM
%token OPENP
%token CLOSEP
%token SEMIC

%left SUM SUB
%left MULT DIV
%nonassoc UMINUS
%nonassoc EQ NEQ GRT GRTEQ LESS LESSEQ

%type <num> exp
%type <logic> program
%type <logic> cond
%type <logic> statement

%%

program:
  /* empty */
  | program statement 
  | program  /* blank line */
  ;

statement:
  command
  | exp
  | cond
  | for_loop
  ;

command:
  cond
  | PRINT exp SEMIC
  | PRINT STRING SEMIC
  | ID ASSIGN exp { num_variables[$1] = $3; } SEMIC
  | ID ASSIGN STRING { str_variables[$1] = $3; } SEMIC
  | TYPE_NB ID ASSIGN exp { num_variables[$2] = $4; } SEMIC
  | TYPE_STR ID ASSIGN STRING { str_variables[$2] = $4; } SEMIC
  ;

exp:
  exp SUM exp          { $$ = $1 + $3; }
  | exp SUB exp             { $$ = $1 - $3;}
  | exp MULT exp            { $$ = $1 * $3; }
  | exp DIV exp             { $$ = $1 / $3; }
  | SUB exp %prec UMINUS  { $$ = -$2; }
  | OPENP exp CLOSEP      { $$ = $2; }
  | exp EQ exp        { $$ = $1 == $3; }
  | exp NEQ exp       { $$ = $1 != $3; }
  | exp GRT exp       { $$ = $1 > $3; }
  | exp GRTEQ exp     { $$ = $1 >= $3; }
  | exp LESS exp      { $$ = $1 < $3; }
  | exp LESSEQ exp    { $$ = $1 <= $3; }
  | exp AND exp       { $$ = $1 && $3; }
  | exp OR exp        { $$ = $1 || $3; }
  | NOT exp             { $$ = !$2; }
  | NUMBER                { $$ = $1; }
  | ID                 {
    if (num_variables.find($1) != num_variables.end()) {
      $$ = num_variables[$1];
    } else {
      cout << "Undefined variable: " << $1 << "\n";
    }
    }
  ;

cond:
  IF OPENP exp CLOSEP BGN statement END 
  | IF OPENP exp CLOSEP BGN statement END else_part 
  ;

else_part:
  ELSE BGN statement END
  | ELIF OPENP exp CLOSEP BGN statement END else_part
  ;

for_loop:
  FOR OPENP ID ASSIGN exp SEMIC exp SEMIC command CLOSEP BGN statement END
  ;

%%

void yyerror(const char * s) {
	extern int yylineno;    
	extern char * yytext;   
	
  cout << "Error (" << s << "): symbol \"" << yytext << "\" (line " << yylineno << ")\n";
}
