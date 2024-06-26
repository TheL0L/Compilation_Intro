%{
#include <stdio.h>

/*
    accept the following inputs:
        word (any combination of at least 2 letters)
        character (any single letter)
        string (any combination of letters and numbers)
        positive & negative numbers, where numbers are:
            integer, real (float), exponential (3.1e+8)
*/
%}

%%
\+?[0-9]+                                 printf("posInt");
-[0-9]+                                   printf("negInt");
\+?[0-9]+(\.[0-9]+)?[eE][\+\-]?[0-9]+     printf("posExp");
-[0-9]+(\.[0-9]+)?[eE][\+\-]?[0-9]+       printf("negExp");
\+?[0-9]+\.[0-9]+                         printf("posReal");
-[0-9]+\.[0-9]+                           printf("negReal");
[a-zA-Z]                                  printf("char");
[a-zA-Z]+                                 printf("word");
[a-zA-Z0-9]+                              printf("string");
.                                         printf("%s", yytext);
%%

int main(int argc, char **argv) {
    yylex();
    return 0;
}