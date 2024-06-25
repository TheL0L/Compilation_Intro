%{
#include <stdio.h>
%}

%%
" "+    printf(" ");
[a-z]   printf("%c", yytext[0]-32);
[A-Z]   printf("%c", yytext[0]+32);
.       ;
%%

int main(int argc, char **argv) {
    yylex();
    return 0;
}