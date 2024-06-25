%{
#include <stdio.h>
%}

%%
^(0[12345]*|1[02345]*|2[01345]*|3[01245]*|4[01235]*|5[01234]*)$ printf("Yes");
.                                                               printf("%s", yytext);
%%

int main(int argc, char **argv) {
    yylex();
    return 0;
}