%{
#include <stdio.h>
%}

%%
[a-zA-Z]+   printf("%s", yytext);
.           ;
%%

int main(int argc, char **argv) {
    yylex();
    return 0;
}