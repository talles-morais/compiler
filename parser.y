%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>

  extern int yylex();
  extern int yyparse();
  extern void yyerror(const char *);
%}


%token ID
%token STRING
%token NUMBER

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

%type exp
%type assign
%type logic

%%
assign:
  ID ASSIGN exp
  ;

exp:
  ID
  | NUMBER
  | STRING
  | OPENP exp CLOSEP
  | exp SUM exp
  | exp SUB exp
  | exp MULT exp
  | exp DIV exp
  | SUB exp %prec UMINUS
  ;

logic:
  exp
  | logic EQ logic
  | logic NEQ logic
  | logic GRT logic
  | logic GRTEQ logic
  | logic LESS logic
  | logic LESSEQ logic
  | logic AND logic
  | logic OR logic
  | NOT logic
  ;


%%

void yyerror(const char *s) {
  extern int yylineno;
  extern char *yytext;

  printf("Error on line %2d, in %s", yytext);
}