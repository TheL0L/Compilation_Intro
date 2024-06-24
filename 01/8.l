%{
#include <stdio.h>

void check(char* string, size_t length)
{
    // L = {σω | ω ∈ (Σ - {σ})* ; σ ∈ (Σ}
    //      Σ = {0, 1, 2, 3, 4, 5}

    // any word is valid, as long as first char
    //      doesn't repeat within the word

    size_t invalid = 0;
    for (size_t i = 1; i < length; ++i)
    {
        if (string[i] != string[0]) continue;

        invalid = 1; break;
    }

    if (invalid == 0)   printf("Yes");
    else                printf("%s", string);
}
%}

%%
[0-5]+      check(yytext, yyleng);
.           printf("%s", yytext);
%%

int main(int argc, char **argv) {
    yylex();
    return 0;
}