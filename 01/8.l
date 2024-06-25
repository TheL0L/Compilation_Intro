%{
#include <stdio.h>

/*
    accept any word within the language
        L = {σω | ω ∈ (Σ - {σ})* ; σ ∈ Σ ; Σ = {0, 1, 2, 3, 4, 5}}
*/
%}

%%
^(0[12345]*|1[02345]*|2[01345]*|3[01245]*|4[01235]*|5[01234]*)$ printf("Yes");
.                                                               printf("%s", yytext);
%%

int main(int argc, char **argv) {
    yylex();
    return 0;
}