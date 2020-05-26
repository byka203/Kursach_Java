//SAMPLES FOR JAVA
//https://www.cs.utexas.edu/~scottm/cs307/codingSamples.htm

//Online compuler JAVA
//https://www.jdoodle.com/online-java-compiler/

//карта Java
//http://blog.nicksieger.com/articles/2006/10/27/visualization-of-rubys-grammar/

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
%token T_STAR T_IMPORT T_PACKAGE T_CLASS T_INTERFACE T_DATA_TYPE T_DATA_TYPE_VARAIBLE T_DATA_TYPE_METHOD T_ENUM T_ACCESS_MODIFIERS T_VARAIBLE_CLASS_METHOD_MODIFIERS T_CLASS_METHOD_MODIFIERS T_VARAIBLE_MODIFIERS T_METHOD_MODIFIERS T_CLASS_MODIFIERS T_STREAM_MODIFIERS T_EXTENDS T_IMPLEMENTS T_THROW T_TRUE_FALSE T_IF T_ELSE T_SWITCH T_CASE T_DEFAULT T_TRY T_CATCH T_THROWS T_FINALLY T_FOR T_DO T_WHILE T_BREAK T_CONTINUE T_NEW T_SUPER T_THIS T_ASSERT T_INSTACEOF T_RETURN T_INCREMENT_DECREMENT_SIGN T_UNARY_SIGN_ONLY T_COMPARISON_SIGN T_BINARY_SIGN T_ASSIGNMENT T_OPEN_BRACKET T_CLOSE_BRACKET T_OPEN_SQUARE_BRACKET T_CLOSE_SQUARE_BRACKET T_OPEN_BRACE T_CLOSE_BRACE T_SEMICOLON T_DOT T_COMMA T_QUERY T_COLON T_FLOAT T_STRING T_NUMBER T_IDENTIFIER T_MINUS T_PLUS

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
        T_PACKAGE T_IDENTIFIER
        ;

R_NamePacket:
        |
        R_NamePacket T_DOT T_IDENTIFIER
        ;

R_Import:
        T_IMPORT T_IDENTIFIER R_NamePacket
        |
        T_IMPORT T_IDENTIFIER R_NamePacket T_DOT T_STAR
        ;

//++++++++++++++++++++++++++++++++++++++++++++++++

//R_TypeMethodField:
//        T_IDENTIFIER
//        |
//        T_DATA_TYPE
//        |
//        T_DATA_TYPE_VARAIBLE
//        |
//        T_DATA_TYPE_METHOD
//        ;

R_EXTENDS://наследование
        |
        T_EXTENDS T_IDENTIFIER
        ;

R_IMPLEMENTS://имплементация
        |
        T_IMPLEMENTS T_IDENTIFIER R_comma_next_IMPLEMENTS
        ;

R_comma_next_IMPLEMENTS://множественная имплементация
        |
        T_COMMA T_IDENTIFIER R_comma_next_IMPLEMENTS
        ;

R_Modifiers:
        R_method_var//без модификаторов но есть тип
        |
        T_CLASS T_IDENTIFIER R_EXTENDS R_IMPLEMENTS R_BodyClass//без модификаторов но есть слово "class" и возможно наследование, имплементация
        |
        T_INTERFACE T_IDENTIFIER R_BodyInterface//без модификаторов но есть слово "interface" 
        |
        T_ACCESS_MODIFIERS R_first_access//первый модификатор - доступа
        |
        T_VARAIBLE_CLASS_METHOD_MODIFIERS R_first_class_method_var//первый модификатор - подходит для классов, методов, переменных
        |
        T_CLASS_METHOD_MODIFIERS R_first_class_method//первый модификатор - подходит для классов, методов
        |
        T_VARAIBLE_MODIFIERS R_first_var//первый модификатор - подходит для переменных
        |
        T_METHOD_MODIFIERS R_first_method//первый модификатор - подходит для методов
        |
        T_CLASS_MODIFIERS R_first_class//первый модификатор - подходит для классов
        ;

R_first_access://модификатор доступа может быть у классов, методов, переменных
        R_method_var//только модификатор доступа затем тип
        |
        T_CLASS T_IDENTIFIER R_EXTENDS R_IMPLEMENTS R_BodyClass//только модификатор доступа затем слово "class" и возможно наследование, имплементация
        |
        T_INTERFACE T_IDENTIFIER R_BodyInterface//только модификатор доступа затем "interface" 
        |
        T_VARAIBLE_CLASS_METHOD_MODIFIERS R_second_class_method_var//второй модификатор - подходит для классов, методов, переменных
        |
        T_CLASS_METHOD_MODIFIERS R_second_class_method//второй модификатор - подходит для классов, методов
        |
        T_VARAIBLE_MODIFIERS R_second_var//второй модификатор - подходит для переменных
        |
        T_METHOD_MODIFIERS R_second_method//второй модификатор - подходит для методов
        |
        T_CLASS_MODIFIERS R_second_class//второй модификатор - подходит для классов
        ;

R_first_class_method_var:
        R_method_var//только модификатор доступа затем тип
        |
        T_CLASS T_IDENTIFIER R_EXTENDS R_IMPLEMENTS R_BodyClass//только модификатор доступа затем слово "class" и возможно наследование, имплементация
        |
        T_INTERFACE T_IDENTIFIER R_BodyInterface//только модификатор доступа затем "interface" 
        |
        T_ACCESS_MODIFIERS R_CMV_second_access//второй модификатор - доступа
        |
        T_CLASS_METHOD_MODIFIERS R_CMV_second_class_method//второй модификатор - подходит для классов, методов
        |
        T_VARAIBLE_MODIFIERS R_CMV_second_var//второй модификатор - подходит для переменных
        |
        T_METHOD_MODIFIERS R_CMV_second_method//второй модификатор - подходит для методов
        |
        T_CLASS_MODIFIERS R_CMV_second_class//второй модификатор - подходит для классов
        ;

R_first_class_method:
        R_method_abstract//только модификатор abstract затем тип
        |
        T_CLASS T_IDENTIFIER R_EXTENDS R_IMPLEMENTS R_BodyClass_abstract//только модификатор abstract затем "class" и возможно наследование, имплементация
        |
        T_INTERFACE T_IDENTIFIER R_BodyInterface//только модификатор abstract затем "interface" 
        |
        T_VARAIBLE_CLASS_METHOD_MODIFIERS R_CM_second_class_method//второй модификатор - подходит для классов, методов, переменных
        |
        T_ACCESS_MODIFIERS R_CM_second_access//второй модификатор - доступа
        |
        T_METHOD_MODIFIERS R_CM_second_method//второй модификатор - подходит для методов
        |
        T_CLASS_MODIFIERS R_CM_second_class//второй модификатор - подходит для классов
        ;

R_first_var:
        R_defin_var1//только модификатор transient затем тип
        |
        T_ACCESS_MODIFIERS R_defin_var1//втроой модификатор - доступа
        |
        T_ACCESS_MODIFIERS T_VARAIBLE_CLASS_METHOD_MODIFIERS R_defin_var1//втроой модификатор - доступа, третий модификатор - подходит для классов, методов, переменных
        |
        T_VARAIBLE_CLASS_METHOD_MODIFIERS R_defin_var1//втроой модификатор - подходит для классов, методов, переменных
        |
        T_VARAIBLE_CLASS_METHOD_MODIFIERS T_ACCESS_MODIFIERS R_defin_var1//втроой модификатор - подходит для классов, методов, переменных, третий модификатор - доступа
        ;

R_first_method:
        R_method_abstract//только модификатор native затем тип
        |
        T_ACCESS_MODIFIERS R_M_second_access//второй модификатор - доступа
        |
        T_METHOD_MODIFIERS R_M_second_method//второй модификатор - подходит для методов
        |
        T_VARAIBLE_CLASS_METHOD_MODIFIERS R_M_second_class_method_var//второй модификатор - подходит для классов, методов, переменных
        ;

R_first_class:
        T_CLASS R_EXTENDS R_IMPLEMENTS R_BodyClass//только модификатор strictfp затем слово "class" и возможно наследование, имплементация
        |
        T_INTERFACE R_BodyInterface//только модификатор strictfp затем слово "interface" 
        |
        T_ACCESS_MODIFIERS R_C_second_access//второй модификатор - доступа
        |
        T_VARAIBLE_CLASS_METHOD_MODIFIERS R_C_second_class_method_var//второй модификатор - подходит для классов, методов, переменных
        |
        T_CLASS_METHOD_MODIFIERS R_C_second_class_method//второй модификатор - подходит для классов, методов
        ;

R_method_abstract://разные типы
        T_IDENTIFIER T_IDENTIFIER R_defin_method_abstract
        |
        T_DATA_TYPE T_IDENTIFIER R_defin_method_abstract
        |
        T_DATA_TYPE_METHOD T_IDENTIFIER R_defin_method_abstract
        ;

R_defin_var1:
        T_IDENTIFIER T_IDENTIFIER R_defin_var//всё ещё не понятно переменная или метод
        |
        T_DATA_TYPE T_IDENTIFIER R_defin_var//всё ещё не понятно переменная или метод
        |
        T_DATA_TYPE_VARAIBLE T_IDENTIFIER R_defin_var//точно переменная
        ;

R_method_var://пеменная или метод
        T_IDENTIFIER T_IDENTIFIER R_method_or_var//всё ещё не понятно переменная или метод
        |
        T_DATA_TYPE T_IDENTIFIER R_method_or_var//всё ещё не понятно переменная или метод
        |
        T_DATA_TYPE_VARAIBLE T_IDENTIFIER R_defin_var//точно переменная
        |
        T_DATA_TYPE_METHOD T_IDENTIFIER R_defin_method//точно метод
        ;

R_method_or_var:
        R_defin_method
        |
        R_defin_var//точно переменная
        ;

R_defin_method_abstract:
        T_OPEN_BRACKET R_Arguments T_CLOSE_BRACKET T_OPEN_BRACE T_CLOSE_BRACKET
        ;

R_defin_method:
        T_OPEN_BRACKET R_Arguments T_CLOSE_BRACKET T_OPEN_BRACE R_Body_Method T_CLOSE_BRACKET//точно метод
        ;

R_defin_var:
        R_comma_next_var2 R_comma_next_var T_SEMICOLON//возможно несолько переменных одного типа
        ;

R_comma_next_var://несолько переменных одного типа через запятую
        |
        T_COMMA R_TypeField T_IDENTIFIER R_comma_next_var2 R_comma_next_var
        ;

R_comma_next_var2://возможно присвоение
        |
        T_ASSIGNMENT R_Expression
        ;

//++++++++++++++++++++++++++++++++++++++++++++++++


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
        R_ModifiersClass T_CLASS T_IDENTIFIER T_OPEN_BRACE R_BodyClass T_CLOSE_BRACE
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
        R_Strings T_PLUS T_IDENTIFIER
        ;

R_Value:
        T_IDENTIFIER
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
        T_IDENTIFIER
        ;

R_Fields:
        R_ModifiersField R_TypeField T_IDENTIFIER T_SEMICOLON
        |
        R_ModifiersField R_TypeField T_IDENTIFIER T_ASSIGNMENT R_Expression T_SEMICOLON
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
        T_IDENTIFIER
        ;

R_Arguments:
        |
        R_Arguments T_COMMA R_TypeField T_IDENTIFIER
        |
        R_TypeField T_IDENTIFIER
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
        T_IDENTIFIER T_OPEN_BRACKET R_ArgumentsCall T_CLOSE_BRACKET
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
        R_ModifiersMethod R_TypeMethod T_IDENTIFIER T_OPEN_BRACKET R_Arguments T_CLOSE_BRACKET T_OPEN_BRACE R_BodyMethod T_CLOSE_BRACE
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