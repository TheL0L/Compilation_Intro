%{
#include "y.tab.h"
#include <stdlib.h>
#include "calc.h"
%}

%%
[ \t] ; /* ignore whitespace */
[0-9]*  {
		yylval.ival = atoi(yytext); return NUMBER; }
[A-Za-z][A-Za-z0-9]* {
		yylval.symp = symlook(yytext); return NAME; }
"**"	return POWER;
"$"	    exit(1);
\n		return yytext[0];
.		return yytext[0];
%%

