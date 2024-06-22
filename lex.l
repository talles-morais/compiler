%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
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
  printf("\n{%2d} <assign, %s, %s>",yylineno, "ASSIGN", yytext);
  printf("%s", yytext);
  return ASSIGN;
}
"print" {
  printf("\n{%2d} <print, %s, %s>",yylineno, "PRINT", yytext);
  printf("%s", yytext);
  return PRINT;
}
"if" {
  printf("\n{%2d} <IF, %s, %s>",yylineno, "IF", yytext);
  printf("%s", yytext);
  return IF;
}
"else" {
  printf("\n{%2d} <ELSE, %s, %s>",yylineno, "ELSE", yytext);
  printf("%s", yytext);
  return ELSE;
}
"elif" {
  printf("\n{%2d} <ELIF, %s, %s>",yylineno, "ELIF", yytext);
  printf("%s", yytext);
  return ELIF;
}
">" {
  printf("\n{%2d} <GRT, %s, %s>",yylineno, "GRT", yytext);
  printf("%s", yytext);
  return GRT;
}
"=>" {
  printf("\n{%2d} <GRTEQ, %s, %s>",yylineno, "GRTEQ", yytext);
  printf("%s", yytext);
  return GRTEQ;
}
"<" {
  printf("\n{%2d} <LESS, %s, %s>",yylineno, "LESS", yytext);
  printf("%s", yytext);
  return LESS;
}
"=<" {
  printf("\n{%2d} <LESSEQ, %s, %s>",yylineno, "LESSEQ", yytext);
  printf("%s", yytext);
  return LESSEQ;
}
"==" {
  printf("\n{%2d} <EQ, %s, %s>",yylineno, "EQ", yytext);
  printf("%s", yytext);
  return EQ;
}
"=~" {
  printf("\n{%2d} <NEQ, %s, %s>",yylineno, "NEQ", yytext);
  printf("%s", yytext);
  return NEQ;
}
"and" {
  printf("\n{%2d} <AND, %s, %s>",yylineno, "AND", yytext);
  printf("%s", yytext);
  return AND;
}
"or" {
  printf("\n{%2d} <OR, %s, %s>",yylineno, "OR", yytext);
  printf("%s", yytext);
  return OR;
}
"not" {
  printf("\n{%2d} <NOT, %s, %s>",yylineno, "NOT", yytext);
  printf("%s", yytext);
  return NOT;
}
"+" {
  printf("\n{%2d} <SUM, %s, %s>",yylineno, "SUM", yytext);
  printf("%s", yytext);
  return SUM;
}
"-" {
  printf("\n{%2d} <SUB, %s, %s>",yylineno, "SUB", yytext);
  printf("%s", yytext);
  return SUB;
}
"*" {
  printf("\n{%2d} <MULT, %s, %s>",yylineno, "MULT", yytext);
  printf("%s", yytext);
  return MULT;
}
"/" {
  printf("\n{%2d} <DIV, %s, %s>",yylineno, "DIV", yytext);
  printf("%s", yytext);
  return DIV;
}
"%" {
  printf("\n{%2d} <MOD, %s, %s>",yylineno, "MOD", yytext);
  printf("%s", yytext);
  return MOD;
}
"#" {
  printf("\n{%2d} <COMM, %s, %s>",yylineno, "COMM", yytext);
  printf("%s", yytext);
  return COMM;
}
"(" {
  printf("\n{%2d} <OPENP, %s, %s>",yylineno, "OPENP", yytext);
  printf("%s", yytext);
  return OPENP;
}
")" {
  printf("\n{%2d} <CLOSEP, %s, %s>",yylineno, "CLOSEP", yytext);
  printf("%s", yytext);
  return CLOSEP;
}
";" {
  printf("\n{%2d} <SEMIC, %s, %s>",yylineno, "SEMIC", yytext);
  printf("%s", yytext);
  return SEMIC;
}

\n {
  printf("\n{%2d} <ENDL, %s, %s>",yylineno, "ENDL", yytext);
  printf("%s", yytext);
  return ENDL;
}

{number} {
  yylval.num = atof(yytext); 
  printf("\n{%2d} <number, %s, %s>",yylineno, "NUMBER", yytext);
  printf("%s", yytext);
  return NUMBER;
}

{string} { 
  yylval.str = strdup(yytext); 
  printf("\n{%2d} <string, %s, %s>",yylineno, "STRING", yytext);
  printf("%s", yytext);
  return STRING;
}
{id} {
  yylval.str = strdup(yytext); 
  printf("\n{%2d} <id, %s, %s>",yylineno, "ID", yytext);
  printf("%s", yytext);
  return ID;
}

[ \t]+ { }
.|\n		{ return yytext[0]; }

%%

int main() {
  yyparse();
  yylex();
  return 0;
}
