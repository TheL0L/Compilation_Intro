%{
#include <stdio.h>

/* convert lower case letters ASCII codes to upper case equivalents. */
%}

%%
9[789]          |
1[01][0-9]      |
1[2][012]       printf("%d", atoi(yytext)-32);
.               printf("%s", yytext);
%%

int main(int argc, char **argv) {
    yylex();
    return 0;
}