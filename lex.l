%{
#include <iostream>
#include <string>
#include "parser.tab.h"

FILE *saida;
FILE *cpp;

%}

%option noyywrap
%option yylineno


d [0-9]
w [a-zA-Z_]
number [+-]?{d}+(\.{d}+(e[+-]?{d}+)?)?
string \"[^\"]*\"
id {w}({w}|{d})*

%%

"begin" {
  fprintf(saida, "\n{%2d} <BEGIN, %s, %s>",yylineno, "BEGIN", yytext);
  fprintf(cpp, "{");
  return BGN;
}

"end" {
  fprintf(saida, "\n{%2d} <END, %s, %s>",yylineno, "END", yytext);
  fprintf(cpp, "}");
  return END;
}
"=" {
  fprintf(saida, "\n{%2d} <ASSIGN, %s, %s>",yylineno, "ASSIGN", yytext);
  fprintf(cpp, "=");
  return ASSIGN;
}
"print" {
  fprintf(saida, "\n{%2d} <PRINT, %s, %s>",yylineno, "PRINT", yytext);
  fprintf(cpp, "cout <<");
  return PRINT;
}
"if" {
  fprintf(saida, "\n{%2d} <IF, %s, %s>",yylineno, "IF", yytext);
  fprintf(cpp, "if");
  return IF;
}
"else" {
  fprintf(saida, "\n{%2d} <ELSE, %s, %s>",yylineno, "ELSE", yytext);
  fprintf(cpp, "else");
  return ELSE;
}
"elif" {
  fprintf(saida, "\n{%2d} <ELIF, %s, %s>",yylineno, "ELIF", yytext);
  fprintf(cpp, "else if");
  return ELIF;
}
">" {
  fprintf(saida, "\n{%2d} <GRT, %s, %s>",yylineno, "GRT", yytext);
  fprintf(cpp, ">");
  return GRT;
}
"=>" {
  fprintf(saida, "\n{%2d} <GRTEQ, %s, %s>",yylineno, "GRTEQ", yytext);
  fprintf(cpp, ">=");
  return GRTEQ;
}
"<" {
  fprintf(saida, "\n{%2d} <LESS, %s, %s>",yylineno, "LESS", yytext);
  fprintf(cpp, "<");
  return LESS;
}
"=<" {
  fprintf(saida, "\n{%2d} <LESSEQ, %s, %s>",yylineno, "LESSEQ", yytext);
  fprintf(cpp, "<=");
  return LESSEQ;
}
"==" {
  fprintf(saida, "\n{%2d} <EQ, %s, %s>",yylineno, "EQ", yytext);
  fprintf(cpp, "==");
  return EQ;
}
"=~" {
  fprintf(saida, "\n{%2d} <NEQ, %s, %s>",yylineno, "NEQ", yytext);
  fprintf(cpp, "!=");
  return NEQ;
}
"and" {
  fprintf(saida, "\n{%2d} <AND, %s, %s>",yylineno, "AND", yytext);
  fprintf(cpp, "&&");
  return AND;
}
"or" {
  fprintf(saida, "\n{%2d} <OR, %s, %s>",yylineno, "OR", yytext);
  fprintf(cpp, "||");
  return OR;
}
"not" {
  fprintf(saida, "\n{%2d} <NOT, %s, %s>",yylineno, "NOT", yytext);
  fprintf(cpp, "!");
  return NOT;
}
"+" {
  fprintf(saida, "\n{%2d} <SUM, %s, %s>",yylineno, "SUM", yytext);
  fprintf(cpp, "+");
  return SUM;
}
"-" {
  fprintf(saida, "\n{%2d} <SUB, %s, %s>",yylineno, "SUB", yytext);
  fprintf(cpp, "-");
  return SUB;
}
"*" {
  fprintf(saida, "\n{%2d} <MULT, %s, %s>",yylineno, "MULT", yytext);
  fprintf(cpp, "*");
  return MULT;
}
"/" {
  fprintf(saida, "\n{%2d} <DIV, %s, %s>",yylineno, "DIV", yytext);
  fprintf(cpp, "/");
  return DIV;
}
"%" {
  fprintf(saida, "\n{%2d} <MOD, %s, %s>",yylineno, "MOD", yytext);
  fprintf(cpp, "%%");
  return MOD;
}
"#" {
  fprintf(saida, "\n{%2d} <COMMENT, %s, %s>",yylineno, "COMMENT", yytext);
  fprintf(cpp, "//");
  return COMM;
}
"(" {
  fprintf(saida, "\n{%2d} <OPENP, %s, %s>",yylineno, "OPENP", yytext);
  fprintf(cpp, "(");
  return OPENP;
}
")" {
  fprintf(saida, "\n{%2d} <CLOSEP, %s, %s>",yylineno, "CLOSEP", yytext);
  fprintf(cpp, ")");
  return CLOSEP;
}
";" {
  fprintf(saida, "\n{%2d} <SEMIC, %s, %s>",yylineno, "SEMIC", yytext);
  fprintf(cpp, ";");
  return SEMIC;
}

"\r\n"|"\n" { fprintf(cpp, "\n"); }

"number" {
  fprintf(saida, "\n{%2d} <NUMBER, %s, %s>",yylineno, "NUMBER", yytext);
  fprintf(cpp, "double ", yytext);
  return TYPE_NB;
}

"string" { 
  fprintf(saida, "\n{%2d} <STRING, %s, %s>",yylineno, "STRING", yytext);
  fprintf(cpp, "string ", yytext);
  return TYPE_STR;
}

"for" { 
  fprintf(saida, "\n{%2d} <FOR, %s, %s>",yylineno, "FOR", yytext);
  fprintf(cpp, "for", yytext);
  return TYPE_STR;
}
"while" { 
  fprintf(saida, "\n{%2d} <WHILE, %s, %s>",yylineno, "WHILE", yytext);
  fprintf(cpp, "while", yytext);
  return TYPE_STR;
}

{number} {
  fprintf(saida, "\n{%2d} <NUMBER, %s, %s>",yylineno, "NUMBER", yytext);
  fprintf(cpp, "%s", yytext);
  yylval.num = atof(yytext);
  return NUMBER;
}

{string} { 
  fprintf(saida, "\n{%2d} <STRING, %s, %s>",yylineno, "STRING", yytext);
  fprintf(cpp, "%s", yytext);
  yylval.str = strdup(yytext);
  return STRING;
}
{id} {
  fprintf(saida, "\n{%2d} <id, %s, %s>",yylineno, "id", yytext);
  fprintf(cpp, "%s", yytext);
  yylval.str = strdup(yytext);
  return ID;
}

[ \t]+ { }
.	{ }

%%

int main(int argc, char **argv) {
  FILE *source = fopen(argv[1], "r");

  if(!source) {
    printf("Erro ao abrir arquivo!\n");
    return -1;
  }

  yyin = source;
  saida = fopen(argv[2],"w");
  cpp = fopen(argv[3],"w");
  fprintf(cpp, "#include <iostream>\n#include <string>\nusing namespace std;\nint main() {\n");

  yyparse();
  yylex();

  fprintf(cpp, "return 0;\n}\n");

  return 0;
}
