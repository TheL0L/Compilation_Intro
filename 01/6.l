%{
#include <stdio.h>
%}

%%
9[789]          printf("%d", atoi(yytext)-32);
1[01][0-9]      printf("%d", atoi(yytext)-32);
1[2][012]       printf("%d", atoi(yytext)-32);
.               printf("%s", yytext);
%%

int main(int argc, char **argv) {
    yylex();
    return 0;
}