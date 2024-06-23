%{
  #include <iostream>
  #include <string>
  #include <unordered_map>

  using std::string;
  using std::unordered_map;

  extern int yylex();
  extern int yyparse();
  extern void yyerror(const char *);
  void execute_command(double value);

  unordered_map<string, double> variables;
%}

%union { 
  double num;
  char *str;
}

%token <str> ID
%token <str> STRING
%token <num> NUMBER

%token ASSIGN
%token ENDL

%token PRINT

%token IF
%token ELSE
%token ELIF

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

%type <num> exp
%type <num> logic
%type <num> command
%type <num> statement

%%

program:
  /* vazio */
  | program statement SEMIC ENDL { execute_command($2); }
  | program SEMIC ENDL { /* linha em branco */ }
  ;

statement:
  command
  | exp
  ;

command:
  PRINT exp { printf("%f\n", $2); }
  | ID ASSIGN exp { variables[$1] = $3; }
  ;

exp:
  exp SUM exp          { $$ = $1 + $3; printf("\n%f\n", $$); }
  | exp SUB exp             { $$ = $1 - $3; printf("\n%f\n", $$);}
  | exp MULT exp            { $$ = $1 * $3; }
  | exp DIV exp             { $$ = $1 / $3; }
  | SUB exp %prec UMINUS  { $$ = -$2; }
  | OPENP exp CLOSEP      { $$ = $2; }
  | NUMBER                { $$ = $1; }
  | ID                { $$ = variables[$1]; }
  ;

logic:
    exp                   { $$ = $1; }
  | logic EQ logic        { $$ = $1 == $3; }
  | logic NEQ logic       { $$ = $1 != $3; }
  | logic GRT logic       { $$ = $1 > $3; }
  | logic GRTEQ logic     { $$ = $1 >= $3; }
  | logic LESS logic      { $$ = $1 < $3; }
  | logic LESSEQ logic    { $$ = $1 <= $3; }
  | logic AND logic       { $$ = $1 && $3; }
  | logic OR logic        { $$ = $1 || $3; }
  | NOT logic             { $$ = !$2; }
  ;

%%

void execute_command(double value) {
    // Aqui você decide o que fazer com o valor recebido
    // Pode ser armazenar em variáveis, imprimir na tela, etc.
    printf("\n%f\n", value);
}

void yyerror(const char *s) {
  fprintf(stderr, "Error: %s\n", s);
}