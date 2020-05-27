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
%token T_STAR T_IMPORT T_PACKAGE T_CLASS T_INTERFACE T_DATA_TYPE T_DATA_TYPE_VARAIBLE T_DATA_TYPE_METHOD T_ENUM T_ACCESS_MODIFIERS T_STATIC_FINAL_MODIFIERS T_ABSTRACT_MODIFIERS T_TRANSIENT_MODIFIERS T_NATIVE_MODIFIERS T_STRICTFP_MODIFIERS T_STREAM_MODIFIERS T_EXTENDS T_IMPLEMENTS T_THROW T_TRUE_FALSE T_IF T_ELSE T_SWITCH T_CASE T_DEFAULT T_TRY T_CATCH T_THROWS T_FINALLY T_FOR T_DO T_WHILE T_BREAK T_CONTINUE T_NEW T_SUPER T_THIS T_ASSERT T_INSTACEOF T_RETURN T_INCREMENT_DECREMENT_SIGN T_UNARY_SIGN_ONLY T_COMPARISON_SIGN T_BINARY_SIGN T_ASSIGNMENT T_OPEN_BRACKET T_CLOSE_BRACKET T_OPEN_SQUARE_BRACKET T_CLOSE_SQUARE_BRACKET T_OPEN_BRACE T_CLOSE_BRACE T_SEMICOLON T_DOT T_COMMA T_QUERY T_COLON T_FLOAT T_STRING T_NUMBER T_IDENTIFIER T_MINUS T_PLUS

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

R_class_interface:
        T_CLASS T_IDENTIFIER R_EXTENDS R_IMPLEMENTS R_BodyClass
        |
        T_INTERFACE T_IDENTIFIER R_BodyInterface
        ;


//слой 0
R_Modifiers:
        R_method_varaible
        |
        R_class_interface
        |
        T_ACCESS_MODIFIERS R_access
        |
        T_STATIC_FINAL_MODIFIERS R_staticfinal
        |
        T_ABSTRACT_MODIFIERS R_abstract
        |
        T_TRANSIENT_MODIFIERS R_transient
        |
        T_NATIVE_MODIFIERS R_native
        |
        T_STRICTFP_MODIFIERS R_strictfp
        ;


//слой 1
R_access://модификатор доступа может быть у классов, методов, переменных
        R_method_varaible//только модификатор доступа затем тип
        |
        R_class_interface
        |
        T_STATIC_FINAL_MODIFIERS R_access_staticfinal
        |
        T_ABSTRACT_MODIFIERS R_access_abstract
        |
        T_TRANSIENT_MODIFIERS R_access_transient
        |
        T_NATIVE_MODIFIERS R_access_native
        |
        T_STRICTFP_MODIFIERS R_access_strictfp
        ;

R_staticfinal:
        R_method_varaible
        |
        R_class_interface
        |
        T_ACCESS_MODIFIERS R_access_staticfinal
        |
        T_ABSTRACT_MODIFIERS R_staticfinal_abstract
        |
        T_TRANSIENT_MODIFIERS R_staticfinal_transient
        |
        T_NATIVE_MODIFIERS R_staticfinal_native
        |
        T_STRICTFP_MODIFIERS R_staticfinal_strictfp
        ;

R_abstract:
        R_method_abstract
        |
        R_class_interface
        |
        T_STATIC_FINAL_MODIFIERS R_staticfinal_abstract
        |
        T_ACCESS_MODIFIERS R_access_abstract
        |
        T_NATIVE_MODIFIERS R_abstract_native
        |
        T_STRICTFP_MODIFIERS R_abstract_strictfp
        ;

R_transient:
        R_defin_var1//только модификатор transient затем тип
        |
        T_ACCESS_MODIFIERS R_defin_var1//втроой модификатор - доступа
        |
        T_ACCESS_MODIFIERS T_STATIC_FINAL_MODIFIERS R_defin_var1//втроой модификатор - доступа, третий модификатор - подходит для классов, методов, переменных
        |
        T_STATIC_FINAL_MODIFIERS R_defin_var1//втроой модификатор - подходит для классов, методов, переменных
        |
        T_STATIC_FINAL_MODIFIERS T_ACCESS_MODIFIERS R_defin_var1//втроой модификатор - подходит для классов, методов, переменных, третий модификатор - доступа
        ;

R_native:
        R_method_abstract//абстраткт так как нативный метод не имеет тела
        |
        T_ACCESS_MODIFIERS R_method_abstract
        |
        T_ACCESS_MODIFIERS T_STATIC_FINAL_MODIFIERS R_method_abstract
        |
        T_STATIC_FINAL_MODIFIERS R_method_abstract
        |
        T_STATIC_FINAL_MODIFIERS T_ACCESS_MODIFIERS R_method_abstract
        ;

R_strictfp:
        R_class_interface
        |
        T_ACCESS_MODIFIERS R_access_strictfp
        |
        T_STATIC_FINAL_MODIFIERS R_staticfinal_strictfp
        |
        T_ABSTRACT_MODIFIERS R_abstract_strictfp
        ;


//слой 2
R_access_staticfinal:
        R_method_varaible
        |
        R_class_interface
        |
        T_ABSTRACT_MODIFIERS R_access_staticfinal_abstract
        |
        T_TRANSIENT_MODIFIERS R_defin_var1
        |
        T_NATIVE_MODIFIERS R_method_abstract
        |
        T_STRICTFP_MODIFIERS R_access_staticfinal_strictfp
        ;

R_access_abstract:
        R_method_abstract
        |
        R_class_interface
        |
        T_STATIC_FINAL_MODIFIERS R_access_staticfinal_abstract
        |
        T_NATIVE_MODIFIERS R_access_abstract_native
        |
        T_STRICTFP_MODIFIERS R_access_abstract_strictfp
        ;

R_access_transient:
        R_defin_var1
        |
        T_STATIC_FINAL_MODIFIERS R_defin_var1
        ;

R_access_native:
        R_method_abstract//абстраткт так как нативный метод не имеет тела
        |
        T_STATIC_FINAL_MODIFIERS R_method_abstract
        ;

R_access_strictfp:
        R_class_interface
        |
        T_STATIC_FINAL_MODIFIERS R_class_interface
        |
        T_STATIC_FINAL_MODIFIERS T_ABSTRACT_MODIFIERS R_class_interface
        |
        T_ABSTRACT_MODIFIERS R_class_interface
        |
        T_ABSTRACT_MODIFIERS T_STATIC_FINAL_MODIFIERS R_class_interface
        ;

R_staticfinal_abstract:
        R_method_abstract
        |
        R_class_interface
        |
        T_ACCESS_MODIFIERS R_access_staticfinal_abstract
        |
        T_NATIVE_MODIFIERS R_staticfinal_abstract_native
        |
        T_STRICTFP_MODIFIERS R_staticfinal_abstract_strictfp
        ;

R_staticfinal_transient:
        R_defin_var1
        |
        T_ACCESS_MODIFIERS R_defin_var1
        ;

R_staticfinal_native:
        R_method_abstract//абстраткт так как нативный метод не имеет тела
        |
        T_ACCESS_MODIFIERS R_method_abstract
        ;

R_staticfinal_strictfp:
        R_class_interface
        |
        T_ACCESS_MODIFIERS R_class_interface
        |
        T_ACCESS_MODIFIERS T_ABSTRACT_MODIFIERS R_class_interface
        |
        T_ABSTRACT_MODIFIERS R_class_interface
        |
        T_ABSTRACT_MODIFIERS T_ACCESS_MODIFIERS R_class_interface
        ;

R_abstract_native:
        R_method_abstract
        |
        R_class_interface
        |
        T_STATIC_FINAL_MODIFIERS R_staticfinal_abstract_native
        |
        T_ACCESS_MODIFIERS R_access_abstract_native
        ;

R_abstract_strictfp:
        R_class_interface
        |
        T_STATIC_FINAL_MODIFIERS R_class_interface
        |
        T_STATIC_FINAL_MODIFIERS T_ACCESS_MODIFIERS R_class_interface
        |
        T_ACCESS_MODIFIERS R_class_interface
        |
        T_ACCESS_MODIFIERS T_STATIC_FINAL_MODIFIERS R_class_interface
        ;


//слой 3
R_access_staticfinal_abstract:
        R_method_abstract
        |
        R_class_interface
        |
        T_NATIVE_MODIFIERS R_method_abstract
        |
        T_STRICTFP_MODIFIERS R_class_interface
        ;

R_access_staticfinal_strictfp:
        R_class_interface
        |
        T_ABSTRACT_MODIFIERS R_class_interface
        ;

R_access_abstract_native:
        R_method_abstract
        |
        T_STATIC_FINAL_MODIFIERS R_method_abstract
        ;

R_access_abstract_strictfp:
        R_class_interface
        |
        T_STATIC_FINAL_MODIFIERS R_class_interface
        ;

R_staticfinal_abstract_native:
        R_method_abstract
        |
        T_ACCESS_MODIFIERS R_method_abstract
        ;

R_staticfinal_abstract_strictfp:
        R_class_interface
        |
        T_ACCESS_MODIFIERS R_class_interface
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

R_method_varaible://пеменная или метод
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
        T_OPEN_BRACKET R_Arguments T_CLOSE_BRACKET T_SEMICOLON
        ;

R_defin_method:
        T_OPEN_BRACKET R_Arguments T_CLOSE_BRACKET T_OPEN_BRACE R_Body_Method T_CLOSE_BRACKET//точно метод
        |
        R_defin_method_abstract
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
        T_ACCESS_MODIFIERS
        |
        T_STATIC_FINAL_MODIFIERS
        |
        T_ABSTRACT_MODIFIERS
        |
        T_STRICTFP_MODIFIERS

        |
        T_STATIC_FINAL_MODIFIERS T_ACCESS_MODIFIERS
        |
        T_ABSTRACT_MODIFIERS T_ACCESS_MODIFIERS
        |
        T_STRICTFP_MODIFIERS T_ACCESS_MODIFIERS

        |
        T_ACCESS_MODIFIERS T_STATIC_FINAL_MODIFIERS
        |
        T_ABSTRACT_MODIFIERS T_STATIC_FINAL_MODIFIERS
        |
        T_STRICTFP_MODIFIERS T_STATIC_FINAL_MODIFIERS

        |
        T_ACCESS_MODIFIERS T_ABSTRACT_MODIFIERS
        |
        T_STATIC_FINAL_MODIFIERS T_ABSTRACT_MODIFIERS
        |
        T_STRICTFP_MODIFIERS T_ABSTRACT_MODIFIERS

        |
        T_ACCESS_MODIFIERS T_STRICTFP_MODIFIERS
        |
        T_STATIC_FINAL_MODIFIERS T_STRICTFP_MODIFIERS
        |
        T_ABSTRACT_MODIFIERS T_STRICTFP_MODIFIERS
        ;

R_ModifierClass:
        T_ACCESS_MODIFIERS
        |
        T_STATIC_FINAL_MODIFIERS
        |
        T_ABSTRACT_MODIFIERS
        |
        T_STRICTFP_MODIFIERS
        ;

//R_Class:
//        R_ModifiersClass T_CLASS T_IDENTIFIER T_OPEN_BRACE R_BodyClass T_CLOSE_BRACE
//        ;

//R_ModifiersFields:
//        |
//        R_ModifiersFields R_ModifiersField
//        ;
//
//R_ModifiersField:
//        T_ACCESS_MODIFIERS
//        |
//        T_STATIC_FINAL_MODIFIERS
//        |
//        T_TRANSIENT_MODIFIERS
//        ;

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
//
//R_Fields:
//        R_ModifiersField R_TypeField T_IDENTIFIER T_SEMICOLON
//        |
//        R_ModifiersField R_TypeField T_IDENTIFIER T_ASSIGNMENT R_Expression T_SEMICOLON
//        ;
//
//R_ModifiersMethods:
//        |
//        R_ModifiersMethods R_ModifiersMethod
//        ;
//
//R_ModifiersMethod:
//        T_STATIC_FINAL_MODIFIERS
//        |
//        T_NATIVE_MODIFIERS
//        |
//        T_ABSTRACT_MODIFIERS
//        ;
//
//R_TypeMethod:
//        T_DATA_TYPE
//        |
//        T_DATA_TYPE_METHOD
//        |
//        T_IDENTIFIER
//        ;

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
        T_OPEN_BRACE R_BodyClass2 T_CLOSE_BRACKET
        ;

R_BodyClass2:
        |
        R_BodyClass2 R_Modifiers
        ;

%%

int main(int argc, char const *argv[]){
    yylval=1;
    return yyparse();
}