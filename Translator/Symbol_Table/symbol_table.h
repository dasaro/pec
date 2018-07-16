#ifndef _symbol_table_h
#define _symbol_table_h

#define MAX_SYMBOLS 1000
#define MAX_VALUES 1000

#define TRUE 1
#define FALSE 0
#define ERR -1

typedef struct {
	char *name;
	char type;
	int values_count;
	char *values[MAX_VALUES];
} symbol;

symbol table[MAX_SYMBOLS];

// INPUT: Name of symbol to look up
// OUTPUT: position in symbol table if present,
//   ERR otherwise
int lookup(char *);

// INPUT: Name and type of symbol to be added
// OUTPUT: TRUE if symbol was added, FALSE otherwise
int addSymbol(char *, char);

// INPUT: Position in Symbol Table
// OUTPUT: ERR if *name is not defined in the symbol table
//   TRUE if *value is a possible value for *name
//   FALSE if *value is not a possible value for *name
int isPossibleValue(int, char *);

// INPUT: Position in the Symbol Table
// OUTPUT: Adds value and returns TRUE if position is valid
//   It does nothing and returns FALSE otherwise
int addValue(int, char *);

#endif
