%{
	#include <stdio.h>
	#include <string.h>

	extern int yylex();
	extern int yylval;
	extern int val;
	int yydebug=1;
	int err=0;

	void yyerror(const char *str){
		fprintf(stderr,"ошибка: %s\n",str);
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