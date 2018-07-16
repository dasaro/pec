#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symbol_table.h"

int symbolCount=0;

int isValidPosition(int pos) {
	// Checks if position on input is a valid index
	if ((pos!=ERR)&&(pos<symbolCount))
		return TRUE;
	else
		return FALSE;
}

int lookup(char *name) {
	// Returns position in symbol table if present
	// ERR otherwise
	int i;

	for (i=0; i<symbolCount; i++) {
		if ( strcmp(table[i].name,name)==0 ) {
			return i;
		}
	}
	return ERR;
}

int addSymbol(char *name, char type) {
	// INPUT:
	// Name and type of symbol to be added
	// %
	// OUTPUT:
	// TRUE if symbol was added
	// FALSE otherwise
	if ( symbolCount<MAX_SYMBOLS ) {
		// Sets up symbol name
		table[symbolCount].name = (char*) malloc( strlen(name)*sizeof(char) );
		strcpy( table[symbolCount].name, name );

		// Sets up symbol type
		table[symbolCount].type = type;

		// Sets initial no of values to 0
		table[symbolCount].values_count = 0;

		// Increments counter
		symbolCount = symbolCount+1;

		return TRUE;
	}
	else {
		return FALSE;
	}
}

int isPossibleValue(int pos, char *value) {
	// INPUT:
	// Position in Symbol Table
	// %
	// OUTPUT:
	// ERR if *name is not defined in the symbol table
	// TRUE if *value is a possible value for *name
	// FALSE if *value is not a possible value for *name
	int i;

	if (isValidPosition(pos)) {
		for (i=0; i<table[pos].values_count; i++) {
			if ( strcmp( table[pos].values[i], value ) == 0 ) {
				return TRUE;
			}
		}
		return FALSE;
	}
	else
		return ERR;
}

int addValue(int pos, char *new_value) {
	// INPUT:
	// Position in the Symbol Table
	// %
	// OUTPUT:
	// Adds value and returns TRUE if position is valid
	// It does nothing and returns FALSE otherwise
	int *values_count;

	if (isValidPosition(pos)) {
		values_count = &table[pos].values_count;

		// Copies new value to array
		table[pos].values[*values_count] = (char*) malloc( strlen(new_value)*sizeof(char) );
		strcpy( table[pos].values[*values_count], new_value );

		// Updates number of values
		*values_count = (*values_count)+1;

		return TRUE;
	}
	else
		return FALSE;
}

// int main() {
// 	int pos;
//
// 	addSymbol("tuberculosis",'f');
// 	addSymbol("exposure",'a');
//
// 	pos = lookup("tuberculosis");
// 	if (isValidPosition(pos)) {
// 		addValue(pos,"latent");
// 		addValue(pos,"active");
// 		addValue(pos,"absent");
// 	}
//
//
// 	printf("Is latent a possible value for tuberculosis?: %d\n", isPossibleValue(pos,"latent"));
// 	printf("Is absent a possible value for tuberculosis?: %d\n", isPossibleValue(pos,"absent"));
// 	printf("Is Active a possible value for tuberculosis?: %d\n", isPossibleValue(pos,"Active"));
// 	printf("Is latent a possible value for xxx?: %d\n", isPossibleValue(lookup("xxx"),"latent"));
//
// 	return 0;
// }
