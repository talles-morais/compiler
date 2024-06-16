%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.tab.h"
%}

%option noyywrap

/* Regular expression definitions */
d [0-9]
w [a-zA-Z_]
number [+-]?{d}+(\.{d}+(e[+-]?{d}+)?)?
string \'({w}+)'

/* Rule definitions */
%%
{number} { yylval.floatval = atof(yytext); return NUMBER; }
{string} { yytext[strlen(yytext) - 1] = '\0'; yylval.strval = strdup(yytext + 1); return STRING; }
"+"      { return PLUS; }
"-"      { return MINUS; }
"*"      { return MULTIPLY; }
"/"      { return DIVIDE; }
[ \t]+   { /* ignore whitespace */ }
\n       { return '\n'; }
.        { return yytext[0]; }
%%

