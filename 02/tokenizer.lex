%{
#include "y.tab.h"
#include <stdlib.h>
#include "symbolics.h"
%}

digit       [0-9]
letter      [a-zA-Z]
identifier  {letter}({letter}|{digit})*
number      {digit}+(\.{digit}+)?([eE][\-\+]?{digit}+)?

%%
"+"         { return PLUS; }
"-"         { return MINUS; }
"*"         { return MULTIPLY; }
"/"         { return DIVIDE; }
"%"         { return MOD; }
"**"        { return POWER; }
"zero?"     { return ISZERO; }
"("         { return LPAREN; }
")"         { return RPAREN; }
"if"        { return IF; }
"then"      { return THEN; }
"else"      { return ELSE; }
"="         { return EQUALS; }
";"         { return SEMICOLON; }
","         { return COMMA; }
"let"       { return LET; }
"in"        { return IN; }
"exit"      { printf("[exit]\n"); exit(1); }

{identifier} { yylval.symp = symlook(yytext); return IDENTIFIER; }
{number}     { yylval.fval = atof(yytext); return NUMBER; }
[ \t\n]+     ;  // ignore whitespace
.            { fprintf(stderr, "unexpected token: %s\n", yytext); }
%%

