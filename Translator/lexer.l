%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "dynamicarray.h"
#include "grammar.tab.h" //Bison generated header file

extern YYSTYPE yylval;
int identifier;
int maxinstant=0;

int yyparse (void);
%}

%x comment

%%

"//"				BEGIN(comment);
<comment>[^\n]*		//Eats comments
<comment>[\n]		BEGIN(INITIAL);

causes-one-of		return CAUSES;
initially-one-of	return INITIALLY;
performed-at		return PERFORMED;
takes-values		return TAKESVALUES;
[{}(),;=]			return *yytext;

[0-9]+			{
							yylval.int_val = atoi(yytext);

							if (maxinstant < yylval.int_val)
							{
								maxinstant = yylval.int_val;
							}
							return INSTANT;
						}

[a-z][a-zA-Z0-9]*	{
						yylval.string = strdup(yytext);

						return OBJECT;
}

[0-9]+"/"[0-9]+			{
							char *aux;
							int i=0;

							aux=malloc(sizeof(char)*(6+strlen(yytext)));
							sprintf(aux, "frac(%s)", yytext);

							while (aux[i] != '/')
								i++;

							aux[i] = ',';

							yylval.string = strdup(aux);
							
							free(aux);

							return FRACTION;
						}
[ \n\t\r]				;
%%

void yyerror (char *string) { printf (" ERROR : %s.\n",string );}

int yywrap (void) {
	/* empty */
}

int main ( void ) {
	yyparse();

	printf("\n#const maxinstant=%d.\n", maxinstant+1);

	return 0;
}
