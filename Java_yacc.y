//SAMPLES FOR JAVA
//https://www.cs.utexas.edu/~scottm/cs307/codingSamples.htm

//Online compuler JAVA
//https://www.jdoodle.com/online-java-compiler/

%{
#include <stdio.h>
#include <string.h>

extern int yylex();

extern int yylval;
int yydebug=1;
int number_str=1;

void yyerror(const char *str){
	fprintf(stderr,"error: %s\n", str);
	fprintf(stderr,"str: %d\n", number_str);
}

int yywrap(){
	return 1;
}

%}


%start
%token



%%








%%

int main(int argc, char const *argv[]){
	yylval=1;
	return yyparse();
}