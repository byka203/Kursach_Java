%{
	#include <stdio.h>
	#include "y.tab.h"
%}

%%
abstract						return T_ABSTRACT;
assert							return T_ASSERT;
boolean							return T_BOOLEAN;
break							return T_BREAK;
byte							return T_BYTE;
case							return T_CASE;
catch							return T_CATCH;
char							return T_CHAR;
class							return T_CLASS;
const							return T_CONST;
continue						return T_CONTINUE;
default							return T_DEFAULT;
do								return T_DO;
double							return T_DOUBLE;
else							return T_ELSE;
enum							return T_ENUM;
extends							return T_EXTENDS;
final							return T_FINAL;
finally							return T_FINALLY;
float							return T_FLOAT;
for								return T_FOR;
goto							return T_GOTO;
if								return T_IF;
implements						return T_IMPLEMENTS;
import							return T_IMPORT;
instaceof						return T_INSTACEOF;
int								return T_INT;
interface						return T_INTERFACE;
long							return T_LONG;
native							return T_NATIVE;
new								return T_NEW;
package							return T_PACKAGE;
private							return T_PRIVATE;
protected						return T_PROTECTED;
public							return T_PUBLIC;
return							return T_RETURN;
short							return T_SHORT;
static							return T_STATIC;
strictfp						return T_STRICTFP;
super							return T_SUPER;
switch							return T_SWITCH;
synchronized					return T_SYNCHRONIZED;
this							return T_THIS;
throw							return T_THROW;
throws							return T_THROWS;
transient						return T_TRANSIENT;
try								return T_TRY;
void							return T_VOID;
volatile						return T_VOLATILE;
while							return T_WHILE;
[a-zA-Z_][a-zA-Z0-9_]*			return T_VAR;
[0-9]+ 							return T_NUMBER;
"++"|"--"						return T_INCDEC;
"+="|"-="|"*="|"/="|"%="|"="	return T_ASSIGN;
"+"|"-"							return T_UNOP;
"*"|"/"|"&"|"|"|">>"|"<<"		return T_OP;
">"|"<"|"=="|">="|"<="|"!="		return T_COMP;
"&&"							return T_AND;
"||"							return T_OR;
\(								return T_OPEN;
\)								return T_CLOSE;
\{								return T_OBRACE;
\}								return T_EBRACE;
\;								return T_SEMICOLON;
(\r\n)|\n 						yylval++;
[ \t]+
%%