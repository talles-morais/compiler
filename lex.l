%{
#include <iostream>
#include <string>
#include "parser.tab.h"

%}

%option noyywrap
%option yylineno

/* Regular expression definitions */
d [0-9]
w [a-zA-Z_]
number [+-]?{d}+(\.{d}+(e[+-]?{d}+)?)?
string \"[^\"]*\"
id {w}({w}|{d})*

/* Rule definitions */
%%
"=" {
  return ASSIGN;
}
"print" {
  return PRINT;
}
"if" {
  return IF;
}
"else" {
  return ELSE;
}
"elif" {
  return ELIF;
}
">" {
  return GRT;
}
"=>" {
  return GRTEQ;
}
"<" {
  return LESS;
}
"=<" {
  return LESSEQ;
}
"==" {
  return EQ;
}
"=~" {
  return NEQ;
}
"and" {
  return AND;
}
"or" {
  return OR;
}
"not" {
  return NOT;
}
"+" {
  return SUM;
}
"-" {
  return SUB;
}
"*" {
  return MULT;
}
"/" {
  return DIV;
}
"%" {
  return MOD;
}
"#" {
  return COMM;
}
"(" {
  return OPENP;
}
")" {
  return CLOSEP;
}
";" {
  return SEMIC;
}

"\r\n"|"\n" {
  return ENDL;
}

{number} {
  yylval.num = atof(yytext); 
  return NUMBER;
}

{string} { 
  yylval.str = strdup(yytext); 
  return STRING;
}
{id} {
  yylval.str = strdup(yytext); 
  return ID;
}

[ \t]+ { }
.	{ return yytext[0]; }

%%

int main() {
  yyparse();
  yylex();
  return 0;
}
