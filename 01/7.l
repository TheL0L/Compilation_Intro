%{
#include <stdio.h>

/*
    accept any words within the language expressed by the following CFG
        S -> 0S1 | 0S11 | 0S111 | 1
*/

void check(char* string, size_t length)
{
    size_t zeros = 0, ones = 0;

    for (size_t i = 0; i < length; ++i)
    {
        if (string[i] == '0') ++zeros;
        else                  ++ones;
    }

    // the CFG (context free grammar) rule
    //    S -> 0S1 | 0S11 | 0S111 | 1
    // ends at 1, thus a single 'one' can be subtracted
    --ones;

    // a valid word will contain zeros<=ones
    //      where ones is bounded [zeros, 3*zeros]

    if (zeros <= ones && ones <= 3*zeros) printf("Yes");
    else                                  printf("%s", string);
}
%}

%%
0*1+      check(yytext, yyleng);
.         printf("%s", yytext);
%%

int main(int argc, char **argv) {
    yylex();
    return 0;
}