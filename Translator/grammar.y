%{
#include <stdio.h>
#include <string.h>
#include "dynamicarray.h"

int yylex(void);
void yyerror (char *);
int yywrap (void);

extern int identifier;
%}

%start domain_description

%token CAUSES
%token INITIALLY
%token PERFORMED
%token TAKESVALUES
%token '(' ')'
%token '{' '}'
%token ',' ';'
%token '='

%token <string> OBJECT
%token <string> FRACTION
%token <int_val> INSTANT

%union {
	TwoDimensionalArray pairs_array;
	Array string_array;
	int int_val;
	double double_val;
	char *string;
};

%type <pairs_array> list_pairs;
%type <string_array> pair;
%type <string_array> list_objects;
%type <string_array> list_assignments;
%type <string_array> loop_list_assignments;
%type <string> assignment;

%%

list_objects:
	list_objects ',' OBJECT {
								$$=$1;
								insertArray(&$$, $3);
							}
	|
	OBJECT 	{
				initArray(&$$,1);
				insertArray(&$$, $1);
			}

;

domain_description:
	/* empty */
	|
	statement domain_description
;

statement:
	takesvalues
	|
	performed
	|
	causes
	|
	initially
;

takesvalues:
	OBJECT TAKESVALUES '{' list_objects '}' {
												printf("fluent(%s). ",$1);

												for (int i=0; i<$4.used; i++) {
													printf("possVal(%s, %s). ", $1, $4.array[i] );
												}

												printf("\n");
											}
;

performed:
	OBJECT PERFORMED INSTANT { printf("performed(%s, %d).\n", $1, $3); }
;

causes:
	'{' loop_list_assignments assignment '}' CAUSES '{' list_pairs '}'
									{
										insertArray(&$2, $3);

										for (int i=0; i<$7.used; i++) {
											if ($7.array[i].used>0) {
												// Standard case
												for (int j=0; j<$7.array[i].used; j++) {
													printf("causesOutcome(id%d, (%s,I))",identifier,$7.array[i].array[j]);

													printf(":-\n");

													for (int k=0; k<$2.used; k++) {
														printf("\tworld( (%s,I) )",$2.array[k]);
														if (k<$2.used-1)
															printf(",\n");
														else
															printf(".\n");
													}
												}
											}
											else
											{
												// Special case: persistence
												printf("causesOutcome(id%d,((F,V),I))",identifier);

												printf(":-\n");

												for (int k=0; k<$2.used; k++) {
													printf("\tworld( (%s,I) ),\n",$2.array[k]);
												}

												printf("\tworld( ((F,V),I) ).\n");
											}

											printf("probabilityOf(id%d, %s).\n\n", identifier, $7.array[i].probability );

											identifier++;
										}

									}
;

initially:
	INITIALLY '{' list_pairs '}'	{
										for (int i=0; i<$3.used; i++) {

											for (int j=0; j<$3.array[i].used; j++) {
												printf("initialState(id%d, %s).\n",identifier,$3.array[i].array[j]);
											}

											printf("probabilityOf(id%d, %s).\n\n", identifier,$3.array[i].probability);

											identifier++;
										}
									}
;

list_pairs:
	list_pairs ',' pair { $$=$1; insert2DArray(&$$, $3); }
	|
	pair { init2DArray(&$$,1); insert2DArray(&$$, $1); }
;

pair:
	'(' '{' list_assignments '}' ',' FRACTION ')' 	{
														$$=$3;
														$$.probability = (char *)malloc(sizeof(char)*strlen($6));
														strcpy($$.probability,$6);
													}
;

list_assignments:
	/* empty */	{
								initArray(&$$,0);
							}
	|
	loop_list_assignments assignment	{
											$$=$1;
											insertArray(&$$, $2);
										}
;

loop_list_assignments:
	/* empty */	{
					initArray(&$$,0);
				}
	|
	loop_list_assignments assignment ','	{
												$$=$1;
												insertArray( &$$, $2 );
											}
;

assignment:
	OBJECT '=' OBJECT	{
							$$ = (char *) malloc( sizeof(char) * (3+strlen($1)+strlen($3)) );
							strcpy($$,"(");
							strcat($$,$1);
							strcat($$,",");
							strcat($$,$3);
							strcat($$,")");
						}
;

%%
