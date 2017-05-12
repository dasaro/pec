%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "dynamicarray.h"
#include "grammar.tab.h" //Bison generated header file

extern YYSTYPE yylval;
int identifier;
int maxinstant=1;
int line=0;

int yyparse (void);
%}

%x comment

%%

"//"				BEGIN(comment);
<comment>[^\n]*		//Eats comments
<comment>[\n]		{ line++; BEGIN(INITIAL); }

causes-one-of		return CAUSESONEOF;
initially-one-of	return INITIALLYONEOF;
performed-at		return PERFORMEDAT;
takes-values		return TAKESVALUES;
with-prob			return WITHPROB;
[1{}(),;=]			return *yytext;

[0-9]+			{
							yylval.int_val = atoi(yytext);

							if (maxinstant < yylval.int_val)
							{
								maxinstant = yylval.int_val;
							}
							return INTEGER;
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

[ \t\r]			;
\n 					line++;
%%

void yyerror (char *string) { printf("LEXER ERROR ON LINE %d: %s.\n",line,string ); }

int yywrap (void) {
	/* empty */
}

int main ( void ) {
	yyparse();

	printf("\n#const maxinstant=%d.\n", maxinstant+1);

	return 0;
}
