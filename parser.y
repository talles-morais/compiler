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
  | program statement 
  | program  
  ;

statement:
  command
  | exp
  | cond
  | loop
  ;

command:
  cond
  | PRINT exp SEMIC
  | PRINT STRING SEMIC
  | ID ASSIGN exp SEMIC
  | ID ASSIGN STRING SEMIC
  | TYPE_NB ID ASSIGN exp SEMIC
  | TYPE_STR ID ASSIGN STRING SEMIC
  ;

exp:
  | exp SUM exp        
  | exp SUB exp           
  | exp MULT exp          
  | exp DIV exp           
  | SUB exp %prec UMINUS
  | OPENP exp CLOSEP    
  | exp EQ exp      
  | exp NEQ exp     
  | exp GRT exp     
  | exp GRTEQ exp   
  | exp LESS exp     
  | exp LESSEQ exp  
  | exp AND exp     
  | exp OR exp      
  | NOT exp           
  | NUMBER              
  | ID
  ;

cond:
  IF OPENP exp CLOSEP BGN program END 
  | IF OPENP exp CLOSEP BGN program END else_part 
  ;

else_part:
  ELSE BGN program END
  | ELIF OPENP exp CLOSEP BGN program END else_part
  ;


loop:
    WHILE OPENP exp CLOSEP BGN program END 
    | FOR OPENP ID ASSIGN exp SEMIC exp SEMIC ID ASSIGN exp CLOSEP BGN program END 
    ;

%%

void yyerror(const char * s) {
	extern int yylineno;    
	extern char * yytext;   
	
  cout << "Error (" << s << "): symbol \"" << yytext << "\" (line " << yylineno << ")\n";
}
