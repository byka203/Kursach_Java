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


%start R_Programm
%token T_STAR T_IMPORT T_PACKAGE T_CLASS T_INTERFACE T_DATA_TYPE T_DATA_TYPE_VARAIBLE T_DATA_TYPE_METHOD T_ENUM T_ACCESS_MODIFIERS T_VARAIBLE_CLASS_METHOD_MODIFIERS T_CLASS_METHOD_MODIFIERS T_VARAIBLE_MODIFIERS T_METHOD_MODIFIERS T_CLASS_MODIFIERS T_STREAM_MODIFIERS T_EXTENDS T_IMPLEMENTS T_THROW T_TRUE_FALSE T_IF T_ELSE T_SWITCH T_CASE T_DEFAULT T_TRY T_CATCH T_THROWS T_FINALLY T_FOR T_DO T_WHILE T_BREAK T_CONTINUE T_NEW T_SUPER T_THIS T_ASSERT T_INSTACEOF T_RETURN T_INCREMENT_DECREMENT_SIGN T_UNARY_SIGN_ONLY T_COMPARISON_SIGN T_BINARY_SIGN T_ASSIGNMENT T_OPEN_BRACKET T_CLOSE_BRACKET T_OPEN_SQUARE_BRACKET T_CLOSE_SQUARE_BRACKET T_OPEN_BRACE T_CLOSE_BRACE T_SEMICOLON T_DOT T_COMMA T_QUERY T_COLON T_FLOAT T_STRING T_NUMBER T_VARIABLE T_MINUS T_PLUS

%%
R_Programm:
        R_Directives R_Classes
        ;

R_Classes:
        |
        R_Classes R_Class
        ;

R_Directives:
        |
        R_Directives R_Package T_SEMICOLON
        |
        R_Directives R_Import T_SEMICOLON
        ;

R_Package:
        T_PACKAGE T_VARIABLE
        ;

R_NamePacket:
        |
        R_NamePacket T_DOT T_VARIABLE
        ;

R_Import:
        T_IMPORT T_VARIABLE R_NamePacket
        |
        T_IMPORT T_VARIABLE R_NamePacket T_STAR
        ;

R_ModifiersClass:
        |
        R_ModifiersClass R_ModifierClass
        ;

R_ModifierClass:
        T_ACCESS_MODIFIERS
        |
        T_VARAIBLE_CLASS_METHOD_MODIFIERS
        |
        T_CLASS_METHOD_MODIFIERS
        |
        T_CLASS_MODIFIERS
        ;

R_Class:
        R_ModifiersClass T_CLASS T_VARIABLE T_OPEN_BRACE R_BodyClass T_CLOSE_BRACE
        ;

R_ModifiersFields:
        |
        R_ModifiersFields R_ModifiersField
        ;

R_ModifiersField:
        T_ACCESS_MODIFIERS
        |
        T_VARAIBLE_CLASS_METHOD_MODIFIERS
        |
        T_VARAIBLE_MODIFIERS
        ;

R_BinarySign:
        T_BINARY_SIGN
        |
        T_STAR
        |
        T_MINUS
        |
        T_PLUS
        |
        T_COMPARISON_SIGN
        ;

R_UnarySign:
        T_MINUS
        |
        T_PLUS
        |
        T_UNARY_SIGN_ONLY
        ;

R_Strings:
        T_STRING
        |
        R_Strings T_PLUS T_STRING
        |
        R_Strings T_PLUS T_VARIABLE
        ;

R_Value:
        T_VARIABLE
        |
        T_NUMBER
        |
        R_Strings
        |
        T_FLOAT
        ;

R_Expression:
        R_UnarySign R_Expression
        |
        R_Value
        |
        T_OPEN_BRACKET R_Expression T_CLOSE_BRACKET
        |
        R_Expression R_BinarySign R_Expression
        ;

R_TypeField:
        T_DATA_TYPE
        |
        T_DATA_TYPE_VARAIBLE
        |
        T_VARIABLE
        ;

R_Fields:
        R_ModifiersField R_TypeField T_VARIABLE T_SEMICOLON
        |
        R_ModifiersField R_TypeField T_VARIABLE T_ASSIGNMENT R_Expression T_SEMICOLON
        ;

R_ModifiersMethods:
        |
        R_ModifiersMethods R_ModifiersMethod
        ;

R_ModifiersMethod:
        T_VARAIBLE_CLASS_METHOD_MODIFIERS
        |
        T_METHOD_MODIFIERS
        |
        T_CLASS_METHOD_MODIFIERS
        ;

R_TypeMethod:
        T_DATA_TYPE
        |
        T_DATA_TYPE_METHOD
        |
        T_VARIABLE
        ;

R_Arguments:
        |
        R_Arguments T_COMMA R_TypeField T_VARIABLE
        |
        R_TypeField T_VARIABLE
        ;

R_BodyMethod:
        R_Commands
        ;

R_Commands:
        |
        R_Commands R_Command
        ;

R_ArgumentsCall:
        |
        R_ArgumentsCall T_COMMA R_Value
        |
        R_Value
        ;

R_Call:
        T_VARIABLE T_OPEN_BRACKET R_ArgumentsCall T_CLOSE_BRACKET
        ;

R_Command:
        R_Expression T_SEMICOLON
        |
        R_Cycle
        |
        R_Call T_SEMICOLON
        |
        R_If
        ;

R_If:
        T_IF T_OPEN_BRACKET R_Cond T_CLOSE_BRACKET R_Body
        |
        T_IF T_OPEN_BRACKET R_Cond T_CLOSE_BRACKET R_Body T_ELSE R_Body
        ;

R_Cycle:
        T_WHILE T_OPEN_BRACKET R_Cond T_CLOSE_BRACKET R_Body
        ;

R_Cond:
        R_Expression
        ;

R_Body:
        T_OPEN_BRACE R_Commands T_CLOSE_BRACE
        |
        R_Command
        ;

R_Methods:
        R_ModifiersMethod R_TypeMethod T_VARIABLE T_OPEN_BRACKET R_Arguments T_CLOSE_BRACKET T_OPEN_BRACE R_BodyMethod T_CLOSE_BRACE
        ;

R_BodyClass:
        |
        R_BodyClass R_Methods
        |
        R_BodyClass R_Fields
        ;


%%

int main(int argc, char const *argv[]){
    yylval=1;
    return yyparse();
}