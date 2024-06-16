%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);

%}

%union {
  float floatval;
  char *strval;
}

%token <floatval> NUMBER
%token <strval> STRING
%token PLUS MINUS MULTIPLY DIVIDE

%type <floatval> expr

%%

input:
    /* empty */
    | input line
    ;

line:
    expr '\n' { /* successfully parsed a line */ }
    ;

expr: expr PLUS expr { $$ = $1 + $3; printf("Result: %f\n", $$); }
    | expr MINUS expr { $$ = $1 - $3; printf("Result: %f\n", $$); }
    | expr MULTIPLY expr { $$ = $1 * $3; printf("Result: %f\n", $$); }
    | expr DIVIDE expr { $$ = $1 / $3; printf("Result: %f\n", $$); }
    | NUMBER { $$ = $1; }
    | STRING { printf("String: %s\n", $1); free($1); $$ = 0; }
    ;

%%

void yyerror(const char *s) {
  fprintf(stderr, "Error: %s\n", s);
}

int main() {
  return yyparse();
}
