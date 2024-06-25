%{
#include <stdio.h>

/*
    accept any words within the language expressed by the expression
        (a * (a + b)^{*} * a * a) + (b * (a + b)^{*} * b) + ((a + b)(a + b))^{+}
*/
%}

%%
a[ab]*aa|b[ab]*b|([ab][ab])+   printf("Yes");
.                              printf("%c", yytext[0]);
%%

int main(int argc, char **argv) {
    yylex();
    return 0;
}