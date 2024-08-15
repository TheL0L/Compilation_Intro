%{
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <math.h>  // gcc needs to be linked with math library, use `-lm` at the end of the command
#include "symbolics.h"

int yylex();
int yyerror();
%}

%start statement_list

%union {
    float fval;
    struct symtab *symp;
}

%token <fval> NUMBER
%token <symp> IDENTIFIER

%token PLUS MINUS MULTIPLY DIVIDE MOD POWER
%token EQUALS LPAREN RPAREN COMMA SEMICOLON
%token IF THEN ELSE ISZERO LET IN

%type  <fval> expression

%right EQUALS
%left  IN

%%
statement_list:
    statement_list expression SEMICOLON
        { printf("[%g]\n", $2); }
    | expression SEMICOLON
        { printf("[%g]\n", $1); }
    ;

expression:
    NUMBER
        { $$ = $1; }
    | IDENTIFIER
        { $$ = $1->value; }
    | PLUS LPAREN expression COMMA expression RPAREN
        { $$ = $3 + $5; }
    | MINUS LPAREN expression COMMA expression RPAREN
        { $$ = $3 - $5; }
    | MULTIPLY LPAREN expression COMMA expression RPAREN
        { $$ = $3 * $5; }
    | DIVIDE LPAREN expression COMMA expression RPAREN
        {
            if ($5 == 0)
            {
                fprintf(stderr, "division by zero\n");
                exit(1);
            }
            else $$ = $3 / $5;
        }
    | MOD LPAREN expression COMMA expression RPAREN
        { $$ = fmod($3, $5); }
    | POWER LPAREN expression COMMA expression RPAREN
        { $$ = powf($3, $5); }
    | ISZERO LPAREN expression RPAREN
        { $$ = ($3 == 0); }
    | IF expression THEN expression ELSE expression
        { $$ = $2 ? $4 : $6; }
    | LET IDENTIFIER EQUALS expression IN expression
        { $2->value = $4; $$ = $6; }
    ;
%%

int main()
{
    return yyparse();
}

int yyerror()
{
    fprintf(stderr, "Error\n");
    return 0;
}

/*
    look up a symbol in the symbolic table,
        if the symbol is not whithin the table, try inserting it.
    assumption: entries cannot be deleted from the table.
*/
struct symtab *symlook(char *sym)
{
    // iterate over the symbolic table
    for (struct symtab *sp = g_symbals; sp < &g_symbals[MAX_SYM_NUMBER]; ++sp)
    {
        // if the current symbol has null name member
        if (!sp->name)
        {
            // override it with the requested symbol, and return it
            sp->name = strdup(sym);
            return sp;
        }
        // otherwise, if it matches the requested symbol, return it
        else if (!strcmp(sp->name, sym)) return sp;
    }

    // if reached this part, the requested symbol wasn't found, and couldn't insert it
    fprintf(stderr, "Too many symbols\n");
    exit(1);
}

struct symtab g_symbals[MAX_SYM_NUMBER];
