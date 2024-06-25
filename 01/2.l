%{
#include <stdio.h>

/* accept only letters. */
%}

%%
[a-zA-Z]+   printf("%s", yytext);
.           ;
%%

int main(int argc, char **argv) {
    yylex();
    return 0;
}