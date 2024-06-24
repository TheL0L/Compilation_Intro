%{
#include <stdio.h>

void check(char* string, size_t length)
{
    size_t a = 0;
    size_t b = 0;
    size_t c = 0;
    size_t d = 0;

    for (size_t i = 0; i < length; ++i)
    {
        if      (string[i] == 'a') ++a;
        else if (string[i] == 'b') ++b;
        else if (string[i] == 'c') ++c;
        else if (string[i] == 'd') ++d;
    }

    if (
        (a == b+1) &&
        (d == 3*c + 2)
    ) printf("Yes");
    else printf("%s", string);
}
%}

%%
a+b*c*ed+   check(yytext, yyleng);
.           printf("%c", yytext[0]);
%%

int main(int argc, char **argv) {
    yylex();
    return 0;
}