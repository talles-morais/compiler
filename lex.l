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
}
"print" {
  printf("\n{%2d} <print, %s, %s>",yylineno, "PRINT", yytext);
  printf("%s", yytext);
}
"if" {
  printf("\n{%2d} <IF, %s, %s>",yylineno, "IF", yytext);
  printf("%s", yytext);
}
"else" {
  printf("\n{%2d} <ELSE, %s, %s>",yylineno, "ELSE", yytext);
  printf("%s", yytext);
}
"elif" {
  printf("\n{%2d} <ELIF, %s, %s>",yylineno, "ELIF", yytext);
  printf("%s", yytext);
}
">" {
  printf("\n{%2d} <GRT, %s, %s>",yylineno, "GRT", yytext);
  printf("%s", yytext);
}
"=>" {
  printf("\n{%2d} <GRTEQ, %s, %s>",yylineno, "GRTEQ", yytext);
  printf("%s", yytext);
}
"<" {
  printf("\n{%2d} <LESS, %s, %s>",yylineno, "LESS", yytext);
  printf("%s", yytext);
}
"=<" {
  printf("\n{%2d} <LESSEQ, %s, %s>",yylineno, "LESSEQ", yytext);
  printf("%s", yytext);
}
"==" {
  printf("\n{%2d} <EQ, %s, %s>",yylineno, "EQ", yytext);
  printf("%s", yytext);
}
"=~" {
  printf("\n{%2d} <NEQ, %s, %s>",yylineno, "NEQ", yytext);
  printf("%s", yytext);
}
"and" {
  printf("\n{%2d} <AND, %s, %s>",yylineno, "AND", yytext);
  printf("%s", yytext);
}
"or" {
  printf("\n{%2d} <OR, %s, %s>",yylineno, "OR", yytext);
  printf("%s", yytext);
}
"not" {
  printf("\n{%2d} <NOT, %s, %s>",yylineno, "NOT", yytext);
  printf("%s", yytext);
}
"+" {
  printf("\n{%2d} <SUM, %s, %s>",yylineno, "SUM", yytext);
  printf("%s", yytext);
}
"-" {
  printf("\n{%2d} <SUB, %s, %s>",yylineno, "SUB", yytext);
  printf("%s", yytext);
}
"*" {
  printf("\n{%2d} <MULT, %s, %s>",yylineno, "MULT", yytext);
  printf("%s", yytext);
}
"/" {
  printf("\n{%2d} <DIV, %s, %s>",yylineno, "DIV", yytext);
  printf("%s", yytext);
}
"%" {
  printf("\n{%2d} <MOD, %s, %s>",yylineno, "MOD", yytext);
  printf("%s", yytext);
}
"#" {
  printf("\n{%2d} <COMM, %s, %s>",yylineno, "COMM", yytext);
  printf("%s", yytext);
}
"(" {
  printf("\n{%2d} <OPENP, %s, %s>",yylineno, "OPENP", yytext);
  printf("%s", yytext);
}
")" {
  printf("\n{%2d} <CLOSEP, %s, %s>",yylineno, "CLOSEP", yytext);
  printf("%s", yytext);
}
";" {
  printf("\n{%2d} <SEMIC, %s, %s>",yylineno, "SEMIC", yytext);
  printf("%s", yytext);
}

{number} { 
  printf("\n{%2d} <number, %s, %s>",yylineno, "NUMBER", yytext);
  printf("%s", yytext);
}
{string} { 
  printf("\n{%2d} <string, %s, %s>",yylineno, "STRING", yytext);
  printf("%s", yytext);
}
{id} {
  printf("\n{%2d} <id, %s, %s>",yylineno, "ID", yytext);
  printf("%s", yytext);
}


[ \t]+ { }
. { }
%%


int main() {
  yyparse();
  yylex();
  return 0;
}
