%{
#include <stdio.h>
%}

%%
a[ab]*aa|b[ab]*b|([ab][ab])+   printf("Yes");
.                              printf("%c", yytext[0]);
%%

int main(int argc, char **argv) {
    yylex();
    return 0;
}