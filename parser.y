%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>

  extern int yylex();
  extern int yyparse();
  extern void yyerror(const char *);
%}

%union { 
  double num;
  char *str;
}

%token ID
%token <str> STRING
%token <num> NUMBER

%token ASSIGN

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
%type <num> stmt
%type <num> logic

%%
program:
  stmt_list
  | exp
  ;

stmt_list:
  stmt_list stmt
  | stmt
  ;

stmt:
  assign
  | PRINT exp  { printf("Print: %f\n", $2); }
  ;

assign:
  ID ASSIGN exp  { printf("Assigned: %f\n", $3); }
  ;

exp: 
    OPENP exp CLOSEP      { $$ = $2; }
  | exp SUM exp           { $$ = $1 + $3; }
  | exp SUB exp           { $$ = $1 - $3; }
  | exp MULT exp          { $$ = $1 * $3; }
  | exp DIV exp           { $$ = $1 / $3; }
  | SUB exp %prec UMINUS  { $$ = -$2; }
  | NUMBER                { $$ = $1; }
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

void yyerror(const char *s) {
  fprintf(stderr, "Error: %s\n", s);
}