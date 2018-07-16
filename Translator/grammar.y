%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "dynamicarray.h"
#include "Symbol_Table/symbol_table.h"

int yylex(void);
void yyerror (char *);
extern int identifier;

%}

%start domain_description

%token CAUSESONEOF
%token INITIALLYONEOF
%token PERFORMEDAT
%token TAKESVALUES
%token WITHPROB
%token IFHOLDS
%token '(' ')'
%token '{' '}'
%token ',' ';'
%token '='
%token '1'

%token <string> OBJECT
%token <string> FRACTION
%token <int_val> INTEGER

%union {
	TwoDimensionalArray pairs_array;
	Array string_array;
	int int_val;
	double double_val;
	char *string;
};

%type <int_val> instant
%type <string> prob
%type <pairs_array> list_pairs;
%type <string_array> pair;
%type <string_array> list_objects;
%type <string_array> list_assignments;
%type <string_array> nonempty_list_assignments;
%type <string> assignment;

%%

instant:
	'1' { $$ = 1; }
	|
	INTEGER { $$ = $1; }
;

prob:
	'1' {
		$$ = (char *)malloc(9*sizeof(char));
		sprintf($$, "frac(1,1)");
	}
	|
	FRACTION {
		$$ = (char *)malloc(sizeof(char)*strlen($1));
		$$ = strdup($1);
	}
;

list_objects:
	list_objects ',' OBJECT {
								$$=$1;
								insertArray(&$$, $3);
							}
	|
	OBJECT 	{
				initArray(&$$,0);
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
	performed_full_form | performed_shorthand1 | performed_shorthand2 | performed_shorthand3
;

performed_full_form:
	OBJECT PERFORMEDAT instant WITHPROB prob IFHOLDS '{' nonempty_list_assignments '}'
	{
		printf("performed(%s, %d, %s) :-\n", $1, $3, $5);

		for (int i=0; i<$8.used; i++) {
			printf("\tholds( (%s,%d) )",$8.array[i],$3);

			if (i<$8.used-1)
				printf(",\n");
			else
				printf(".\n\n");
		}
	}
;

performed_shorthand1:
	OBJECT PERFORMEDAT instant WITHPROB prob { printf("performed(%s, %d, %s).\n", $1, $3, $5); }
;

performed_shorthand2:
	OBJECT PERFORMEDAT instant IFHOLDS '{' nonempty_list_assignments '}' {
		printf("performed(%s, %d, frac(1,1)) :-\n", $1, $3);

		for (int i=0; i<$6.used; i++) {
			printf("\tholds( (%s,I) )",$6.array[i]);

			if (i<$6.used-1)
				printf(",\n");
			else
				printf(".\n\n");
		}
	}
;

performed_shorthand3:
	OBJECT PERFORMEDAT instant { printf("performed(%s, %d, frac(1,1)).\n", $1, $3); }
;

causes:
	'{' nonempty_list_assignments '}' CAUSESONEOF '{' list_pairs '}'
									{
										for (int i=0; i<$6.used; i++) {

												for (int j=0; j<$6.array[i].used; j++) {
													printf("belongsTo(%s, id%d).\n",$6.array[i].array[j],identifier);
												}

												printf("causedOutcome( (id%d, %s), I) :-\n", identifier, $6.array[i].probability);

												for (int k=0; k<$2.used; k++) {
													printf("\tholds( (%s,I) )",$2.array[k]);

													if (k<$2.used-1)
														printf(",\n");
													else
														printf(".\n\n");
												}

												identifier++;
										}

									}
;

initially:
	INITIALLYONEOF '{' list_pairs '}'	{
										for (int i=0; i<$3.used; i++) {

											for (int j=0; j<$3.array[i].used; j++) {
												printf("belongsTo(%s, id%d).\n",$3.array[i].array[j], identifier);
											}

											printf("initialCondition( (id%d, %s) ).\n\n", identifier,$3.array[i].probability);

											identifier++;
										}
									}
;

list_pairs:
	pair ',' list_pairs { $$=$3; insert2DArray(&$$, $1); }
	|
	pair { init2DArray(&$$,0); insert2DArray(&$$, $1); }
;

pair:
	'(' '{' list_assignments '}' ',' prob ')' 	{
														$$=$3;
														$$.probability = $6;
													}
;

list_assignments:
	/* empty */	{
								initArray(&$$,0);
							}
	|
	nonempty_list_assignments	{
											$$=$1;
										}
;

nonempty_list_assignments:
	assignment	{
								initArray(&$$,0);
								insertArray(&$$, $1);
							}
	|
	assignment ',' nonempty_list_assignments {
												$$=$3;
												insertArray( &$$, $1 );
											}
;

assignment:
	OBJECT '=' OBJECT	{
							char *aux;
							aux = (char *) malloc(sizeof(char) * (strlen($1) + strlen($3) + 3));
							sprintf(aux, "(%s,%s)", $1, $3);
							$$ = strdup(aux);
							free(aux);
						}
;

%%
