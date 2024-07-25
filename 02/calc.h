#ifndef _CALC_H
#define _CALC_H

#define MAX_SYM_NUMBER 20 /* maximum number of symbols */

extern struct symtab {
	char *name;
	int value;
} g_symbals[MAX_SYM_NUMBER];

struct symtab *symlook(char *sym);

#endif