%{
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "calc.h"
int yylex();
int yyerror();
%}

%union {
	int ival;
	struct symtab *symp;
}
%token <ival> NUMBER
%token <symp> NAME
%token POWER

%type <ival> expression

%left '+' '-'
%left '*'
%left POWER

%start	statement_list
%%

statement_list:	statement '\n'
              | statement_list statement '\n'
			  ;

statement:	NAME '=' expression { $1->value = $3; }
          | expression			{ printf("= %d\n", $1); }
		  ;

expression: expression '+' expression {$$ = $1 + $3; }
          | expression '-' expression {$$ = $1 - $3; }
          | expression '*' expression {$$ = $1 * $3; }
          | expression POWER expression {$$ = 1;
				for(int i = $3 ; i != 0; --i) $$ *= $1; }
		  | NUMBER
		  | NAME {$$ = $1->value; }
		  ;

%%
int main() {
	return yyparse();
}

int yyerror() {
	fprintf(stderr, "Error\n");
	return 0;
}

struct symtab *symlook(char *sym) {
	for (struct symtab *sp = g_symbals; sp < &g_symbals[MAX_SYM_NUMBER]; ++sp) {
		if (!sp->name) {
			sp->name = strdup(sym);
			return sp;
		} else if (!strcmp(sp->name, sym))
			return sp;			
	}
	fprintf(stderr, "Too many symbols\n");
	exit(1);
}

struct symtab g_symbals[MAX_SYM_NUMBER];