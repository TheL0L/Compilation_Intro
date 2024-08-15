#ifndef _SYMBOLICS_H
#define _SYMBOLICS_H

#define MAX_SYM_NUMBER 20 /* maximum number of symbols */

extern struct symtab {
	char *name;
	float value;
} g_symbals[MAX_SYM_NUMBER];

struct symtab *symlook(char *sym);

#endif