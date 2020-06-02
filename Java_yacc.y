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
%token T_PESIK T_OPEN_ANGLE_BRACKET T_CLOSE_ANGLE_BRACKET T_STAR T_IMPORT T_PACKAGE T_CLASS T_INTERFACE T_DATA_TYPE T_DATA_TYPE_VARIABLE T_DATA_TYPE_METHOD T_ENUM T_ACCESS_MODIFIERS T_STATIC_MODIFIERS T_FINAL_MODIFIERS T_ABSTRACT_MODIFIERS T_TRANSIENT_MODIFIERS T_NATIVE_MODIFIERS T_STRICTFP_MODIFIERS T_STREAM_MODIFIERS T_EXTENDS T_IMPLEMENTS T_THROW T_TRUE_FALSE T_IF T_ELSE T_SWITCH T_CASE T_DEFAULT T_TRY T_CATCH T_THROWS T_FINALLY T_FOR T_DO T_WHILE T_BREAK T_CONTINUE T_NEW T_SUPER T_THIS T_ASSERT T_INSTACEOF T_RETURN T_INCREMENT_DECREMENT_SIGN T_UNARY_SIGN_ONLY T_COMPARISON_SIGN T_BINARY_SIGN T_ASSIGNMENT T_OPEN_BRACKET T_CLOSE_BRACKET T_OPEN_SQUARE_BRACKET T_CLOSE_SQUARE_BRACKET T_OPEN_BRACE T_CLOSE_BRACE T_SEMICOLON T_DOT T_COMMA T_QUERY T_COLON T_FLOAT T_STRING T_NUMBER T_IDENTIFIER T_MINUS T_PLUS T_ASSIGNMENT2

%%
R_Programm:
        R_Directives R_Classes
        ;

R_Classes:
        |
        R_Classes R_Modifiers
        ;

R_Directives:
        |
        R_Directives R_Package T_SEMICOLON
        |
        R_Directives R_Import T_SEMICOLON
        ;

R_Package:
        T_PACKAGE R_Package_name
        ;

R_Package_name:
        T_IDENTIFIER
        |
        R_Package_name T_DOT T_IDENTIFIER
        ;

R_NamePacket:
        |
        R_NamePacket T_DOT T_IDENTIFIER
        ;

R_Import:
        T_IMPORT T_IDENTIFIER R_NamePacket T_DOT T_STAR
        |
        T_IMPORT T_IDENTIFIER R_NamePacket
        ;



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
        T_INTERFACE T_IDENTIFIER R_BodyClass
        ;

R_Modifiers:
        R_Modifiers2
        |
        R_Annotation R_Modifiers2
        ;

R_Annotation:
        T_PESIK T_IDENTIFIER
        |
        R_Annotation T_PESIK T_IDENTIFIER
        |
        T_PESIK T_IDENTIFIER T_OPEN_BRACKET R_ArgumentsCall T_CLOSE_BRACKET
        |
        R_Annotation T_PESIK T_IDENTIFIER T_OPEN_BRACKET R_ArgumentsCall T_CLOSE_BRACKET
        ;

//слой 0
R_Modifiers2:
        R_method_variable
        |
        R_class_interface
        |
        T_ACCESS_MODIFIERS R_access
        |
        T_STATIC_MODIFIERS R_static
        |
        T_FINAL_MODIFIERS R_final
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
R_access:
        R_method_variable
        |
        R_class_interface
        |
        T_STATIC_MODIFIERS R_access_static
        |
        T_FINAL_MODIFIERS R_access_final
        |
        T_ABSTRACT_MODIFIERS R_access_abstract
        |
        T_TRANSIENT_MODIFIERS R_access_transient
        |
        T_NATIVE_MODIFIERS R_access_native
        |
        T_STRICTFP_MODIFIERS R_access_strictfp
        ;

R_static:
        R_method_variable
        |
        R_class_interface
        |
        T_ACCESS_MODIFIERS R_access_static
        |
        T_FINAL_MODIFIERS R_static_final
        |
        T_ABSTRACT_MODIFIERS R_static_abstract
        |
        T_TRANSIENT_MODIFIERS R_static_transient
        |
        T_NATIVE_MODIFIERS R_static_native
        |
        T_STRICTFP_MODIFIERS R_static_strictfp
        ;

R_final:
        R_method_variable
        |
        R_class_interface
        |
        T_ACCESS_MODIFIERS R_access_final
        |
        T_STATIC_MODIFIERS R_static_final
        |
        T_ABSTRACT_MODIFIERS R_final_abstract
        |
        T_TRANSIENT_MODIFIERS R_final_transient
        |
        T_NATIVE_MODIFIERS R_final_native
        |
        T_STRICTFP_MODIFIERS R_final_strictfp
        ;

R_abstract:
        R_method_abstract
        |
        R_class_interface
        |
        T_ACCESS_MODIFIERS R_access_abstract
        |
        T_STATIC_MODIFIERS R_static_abstract
        |
        T_FINAL_MODIFIERS R_final_abstract
        |
        T_NATIVE_MODIFIERS R_abstract_native
        |
        T_STRICTFP_MODIFIERS R_abstract_strictfp
        ;

R_transient:
        R_defin_var1
        |
        T_ACCESS_MODIFIERS R_access_transient
        |
        T_STATIC_MODIFIERS R_static_transient
        |
        T_FINAL_MODIFIERS R_final_transient
        ;

R_native:
        R_method_abstract//абстраткт так как нативный метод не имеет тела
        |
        T_ACCESS_MODIFIERS R_access_native
        |
        T_STATIC_MODIFIERS R_static_native
        |
        T_FINAL_MODIFIERS R_final_native
        ;

R_strictfp:
        R_class_interface
        |
        T_ACCESS_MODIFIERS R_access_strictfp
        |
        T_STATIC_MODIFIERS R_static_strictfp
        |
        T_FINAL_MODIFIERS R_final_strictfp
        |
        T_ABSTRACT_MODIFIERS R_abstract_strictfp
        ;


//слой 2
R_access_static:
        R_method_variable
        |
        R_class_interface
        |
        T_FINAL_MODIFIERS R_access_static_final
        |
        T_ABSTRACT_MODIFIERS R_access_static_abstract
        |
        T_TRANSIENT_MODIFIERS R_access_static_transient
        |
        T_NATIVE_MODIFIERS R_access_static_native
        |
        T_STRICTFP_MODIFIERS R_access_static_strictfp
        ;

R_access_final:
        R_method_variable
        |
        R_class_interface
        |
        T_STATIC_MODIFIERS R_access_static_final
        |
        T_ABSTRACT_MODIFIERS R_access_final_abstract
        |
        T_TRANSIENT_MODIFIERS R_access_final_transient
        |
        T_NATIVE_MODIFIERS R_access_final_native
        |
        T_STRICTFP_MODIFIERS R_access_final_strictfp
        ;

R_access_abstract:
        R_method_abstract
        |
        R_class_interface
        |
        T_STATIC_MODIFIERS R_access_static_abstract
        |
        T_FINAL_MODIFIERS R_access_final_abstract
        |
        T_NATIVE_MODIFIERS R_access_abstract_native
        |
        T_STRICTFP_MODIFIERS R_access_abstract_strictfp
        ;

R_access_transient:
        R_defin_var1
        |
        T_STATIC_MODIFIERS R_defin_var1
        |
        T_FINAL_MODIFIERS R_defin_var1
        |
        T_STATIC_MODIFIERS T_FINAL_MODIFIERS R_defin_var1
        |
        T_FINAL_MODIFIERS T_STATIC_MODIFIERS R_defin_var1
        ;

R_access_native:
        R_method_abstract//абстраткт так как нативный метод не имеет тела
        |
        T_STATIC_MODIFIERS R_method_abstract
        |
        T_FINAL_MODIFIERS R_method_abstract
        |
        T_STATIC_MODIFIERS T_FINAL_MODIFIERS R_method_abstract
        |
        T_FINAL_MODIFIERS T_STATIC_MODIFIERS R_method_abstract
        ;

R_access_strictfp:
        R_class_interface
        |
        T_STATIC_MODIFIERS R_access_static_strictfp
        |
        T_FINAL_MODIFIERS  R_access_final_strictfp
        |
        T_ABSTRACT_MODIFIERS R_access_abstract_strictfp
        ;

R_static_final:
        R_method_variable
        |
        R_class_interface
        |
        T_ACCESS_MODIFIERS R_access_static_final
        |
        T_ABSTRACT_MODIFIERS R_static_final_abstract
        |
        T_TRANSIENT_MODIFIERS R_static_final_transient
        |
        T_NATIVE_MODIFIERS R_static_final_native
        |
        T_STRICTFP_MODIFIERS R_static_final_strictfp
        ;

R_static_abstract:
        R_method_abstract
        |
        R_class_interface
        |
        T_ACCESS_MODIFIERS R_access_static_abstract
        |
        T_FINAL_MODIFIERS R_static_final_abstract
        |
        T_NATIVE_MODIFIERS R_static_abstract_native
        |
        T_STRICTFP_MODIFIERS R_static_abstract_strictfp
        ;

R_static_transient:
        R_defin_var1
        |
        T_FINAL_MODIFIERS R_defin_var1
        |
        T_ACCESS_MODIFIERS R_defin_var1
        |
        T_FINAL_MODIFIERS T_ACCESS_MODIFIERS R_defin_var1
        |
        T_ACCESS_MODIFIERS T_FINAL_MODIFIERS R_defin_var1
        ;

R_static_native:
        R_method_abstract//абстраткт так как нативный метод не имеет тела
        |
        T_FINAL_MODIFIERS R_method_abstract
        |
        T_ACCESS_MODIFIERS R_method_abstract
        |
        T_FINAL_MODIFIERS T_ACCESS_MODIFIERS R_method_abstract
        |
        T_ACCESS_MODIFIERS T_FINAL_MODIFIERS R_method_abstract
        ;

R_static_strictfp:
        R_class_interface
        |
        T_ACCESS_MODIFIERS R_access_static_strictfp
        |
        T_FINAL_MODIFIERS R_static_final_strictfp
        |
        T_ABSTRACT_MODIFIERS R_static_abstract_strictfp
        ;

R_final_abstract:
        R_method_abstract
        |
        R_class_interface
        |
        T_STATIC_MODIFIERS R_static_final_abstract
        |
        T_ACCESS_MODIFIERS R_access_final_abstract
        |
        T_NATIVE_MODIFIERS R_final_abstract_native
        |
        T_STRICTFP_MODIFIERS R_final_abstract_strictfp
        ;

R_final_transient:
        R_defin_var1
        |
        T_STATIC_MODIFIERS R_defin_var1
        |
        T_ACCESS_MODIFIERS R_defin_var1
        |
        T_STATIC_MODIFIERS T_ACCESS_MODIFIERS R_defin_var1
        |
        T_ACCESS_MODIFIERS T_STATIC_MODIFIERS R_defin_var1
        ;

R_final_native:
        R_method_abstract//абстраткт так как нативный метод не имеет тела
        |
        T_STATIC_MODIFIERS R_method_abstract
        |
        T_ACCESS_MODIFIERS R_method_abstract
        |
        T_STATIC_MODIFIERS T_ACCESS_MODIFIERS R_method_abstract
        |
        T_ACCESS_MODIFIERS T_STATIC_MODIFIERS R_method_abstract
        ;

R_final_strictfp:
        R_class_interface
        |
        T_ACCESS_MODIFIERS R_access_final_strictfp
        |
        T_STATIC_MODIFIERS R_static_final_strictfp
        |
        T_ABSTRACT_MODIFIERS R_final_abstract_strictfp
        ;

R_abstract_native:
        R_method_abstract
        |
        R_class_interface
        |
        T_STATIC_MODIFIERS R_static_abstract_native
        |
        T_FINAL_MODIFIERS R_final_abstract_native
        |
        T_ACCESS_MODIFIERS R_access_abstract_native
        ;

R_abstract_strictfp:
        R_class_interface
        |
        T_STATIC_MODIFIERS R_static_abstract_strictfp
        |
        T_FINAL_MODIFIERS R_final_abstract_strictfp
        |
        T_ACCESS_MODIFIERS R_access_abstract_strictfp
        ;


//слой 3
R_access_static_final:
        R_method_variable
        |
        R_class_interface
        |
        T_ABSTRACT_MODIFIERS R_access_static_final_abstract
        |
        T_TRANSIENT_MODIFIERS R_defin_var1
        |
        T_NATIVE_MODIFIERS R_access_static_final_native
        |
        T_STRICTFP_MODIFIERS R_access_static_final_strictfp
        ;

R_access_static_abstract:
        R_method_abstract
        |
        R_class_interface
        |
        T_FINAL_MODIFIERS R_access_static_final_abstract
        |
        T_NATIVE_MODIFIERS R_access_static_abstract_native
        |
        T_STRICTFP_MODIFIERS R_access_static_abstract_strictfp
        ;

R_access_static_transient:
        R_defin_var1
        |
        T_FINAL_MODIFIERS R_defin_var1
        ;

R_access_static_native:
        R_method_abstract
        |
        T_FINAL_MODIFIERS R_method_abstract
        |
        T_ABSTRACT_MODIFIERS R_method_abstract
        |
        T_FINAL_MODIFIERS T_ABSTRACT_MODIFIERS R_method_abstract
        |
        T_ABSTRACT_MODIFIERS T_FINAL_MODIFIERS R_method_abstract
        ;

R_access_static_strictfp:
        R_class_interface
        |
        T_FINAL_MODIFIERS R_class_interface
        |
        T_ABSTRACT_MODIFIERS R_class_interface
        |
        T_FINAL_MODIFIERS T_ABSTRACT_MODIFIERS R_class_interface
        |
        T_ABSTRACT_MODIFIERS T_FINAL_MODIFIERS R_class_interface
        ;

R_access_final_abstract:
        R_method_abstract
        |
        R_class_interface
        |
        T_STATIC_MODIFIERS R_access_static_final_abstract
        |
        T_NATIVE_MODIFIERS R_access_final_abstract_native
        |
        T_STRICTFP_MODIFIERS R_access_final_abstract_strictfp
        ;

R_access_final_transient:
        R_defin_var1
        |
        T_STATIC_MODIFIERS R_defin_var1
        ;

R_access_final_native:
        R_method_abstract
        |
        T_STATIC_MODIFIERS R_method_abstract
        |
        T_ABSTRACT_MODIFIERS R_method_abstract
        |
        T_STATIC_MODIFIERS T_ABSTRACT_MODIFIERS R_method_abstract
        |
        T_ABSTRACT_MODIFIERS T_STATIC_MODIFIERS R_method_abstract
        ;

R_access_final_strictfp:
        R_class_interface
        |
        T_STATIC_MODIFIERS R_class_interface
        |
        T_ABSTRACT_MODIFIERS R_class_interface
        |
        T_STATIC_MODIFIERS T_ABSTRACT_MODIFIERS R_class_interface
        |
        T_ABSTRACT_MODIFIERS T_STATIC_MODIFIERS R_class_interface
        ;

R_access_abstract_native:
        R_method_abstract
        |
        T_STATIC_MODIFIERS R_method_abstract
        |
        T_FINAL_MODIFIERS R_method_abstract
        |
        T_STATIC_MODIFIERS T_FINAL_MODIFIERS R_method_abstract
        |
        T_FINAL_MODIFIERS T_STATIC_MODIFIERS R_method_abstract
        ;

R_access_abstract_strictfp:
        R_class_interface
        |
        T_STATIC_MODIFIERS R_class_interface
        |
        T_FINAL_MODIFIERS R_class_interface
        |
        T_STATIC_MODIFIERS T_FINAL_MODIFIERS R_class_interface
        |
        T_FINAL_MODIFIERS T_STATIC_MODIFIERS R_class_interface
        ;

R_static_final_abstract:
        R_method_abstract
        |
        R_class_interface
        |
        T_ACCESS_MODIFIERS R_access_static_final_abstract
        |
        T_NATIVE_MODIFIERS R_static_final_abstract_native
        |
        T_STRICTFP_MODIFIERS R_static_final_abstract_strictfp
        ;

R_static_final_transient:
        R_defin_var1
        |
        T_ACCESS_MODIFIERS R_defin_var1
        ;

R_static_final_native:
        R_method_abstract
        |
        T_ACCESS_MODIFIERS R_method_abstract
        |
        T_ABSTRACT_MODIFIERS R_method_abstract
        |
        T_ACCESS_MODIFIERS T_ABSTRACT_MODIFIERS R_method_abstract
        |
        T_ABSTRACT_MODIFIERS T_ACCESS_MODIFIERS R_method_abstract
        ;

R_static_final_strictfp:
        R_class_interface
        |
        T_ACCESS_MODIFIERS R_class_interface
        |
        T_ABSTRACT_MODIFIERS R_class_interface
        |
        T_ACCESS_MODIFIERS T_ABSTRACT_MODIFIERS R_class_interface
        |
        T_ABSTRACT_MODIFIERS T_ACCESS_MODIFIERS R_class_interface
        ;

R_static_abstract_native:
        R_method_abstract
        |
        T_ACCESS_MODIFIERS R_method_abstract
        |
        T_FINAL_MODIFIERS R_method_abstract
        |
        T_ACCESS_MODIFIERS T_FINAL_MODIFIERS R_method_abstract
        |
        T_FINAL_MODIFIERS T_ACCESS_MODIFIERS R_method_abstract
        ;

R_static_abstract_strictfp:
        R_class_interface
        |
        T_ACCESS_MODIFIERS R_class_interface
        |
        T_FINAL_MODIFIERS R_class_interface
        |
        T_ACCESS_MODIFIERS T_FINAL_MODIFIERS R_class_interface
        |
        T_FINAL_MODIFIERS T_ACCESS_MODIFIERS R_class_interface
        ;

R_final_abstract_native:
        R_method_abstract
        |
        T_STATIC_MODIFIERS R_method_abstract
        |
        T_ACCESS_MODIFIERS R_method_abstract
        |
        T_STATIC_MODIFIERS T_ACCESS_MODIFIERS R_method_abstract
        |
        T_ACCESS_MODIFIERS T_STATIC_MODIFIERS R_method_abstract
        ;

R_final_abstract_strictfp:
        R_class_interface
        |
        T_STATIC_MODIFIERS R_class_interface
        |
        T_ACCESS_MODIFIERS R_class_interface
        |
        T_STATIC_MODIFIERS T_ACCESS_MODIFIERS R_class_interface
        |
        T_ACCESS_MODIFIERS T_STATIC_MODIFIERS R_class_interface
        ;


//слой4
R_access_static_final_abstract:
        R_method_abstract
        |
        R_class_interface
        |
        T_NATIVE_MODIFIERS R_method_abstract
        |
        T_STRICTFP_MODIFIERS R_class_interface
        ;

R_access_static_final_native:
        R_method_abstract
        |
        T_ABSTRACT_MODIFIERS R_method_abstract
        ;

R_access_static_final_strictfp:
        R_class_interface
        |
        T_ABSTRACT_MODIFIERS R_class_interface
        ;

R_access_static_abstract_native:
        R_method_abstract
        |
        T_FINAL_MODIFIERS R_method_abstract
        ;

R_access_static_abstract_strictfp:
        R_class_interface
        |
        T_FINAL_MODIFIERS R_class_interface
        ;

R_access_final_abstract_native:
        R_method_abstract
        |
        T_STATIC_MODIFIERS R_method_abstract
        ;

R_access_final_abstract_strictfp:
        R_class_interface
        |
        T_STATIC_MODIFIERS R_class_interface
        ;

R_static_final_abstract_native:
        R_method_abstract
        |
        T_ACCESS_MODIFIERS R_method_abstract
        ;

R_static_final_abstract_strictfp:
        R_class_interface
        |
        T_ACCESS_MODIFIERS R_class_interface
        ;



R_Repeat_square_bracket:
        |
        T_OPEN_SQUARE_BRACKET R_Expression T_CLOSE_SQUARE_BRACKET R_Repeat_square_bracket
        |
        T_OPEN_SQUARE_BRACKET T_CLOSE_SQUARE_BRACKET R_Repeat_square_bracket
        ;


R_method_abstract://разные типы
        T_IDENTIFIER R_Repeat_square_bracket T_IDENTIFIER R_defin_method_abstract
        |
        T_DATA_TYPE R_Repeat_square_bracket T_IDENTIFIER R_defin_method_abstract 
        |
        T_DATA_TYPE_METHOD T_IDENTIFIER R_defin_method_abstract
        ;

R_defin_var1:
        T_IDENTIFIER R_Repeat_square_bracket T_IDENTIFIER R_defin_var//всё ещё не понятно переменная или метод
        |
        T_DATA_TYPE R_Repeat_square_bracket T_IDENTIFIER R_defin_var//всё ещё не понятно переменная или метод
        |
        T_DATA_TYPE_VARIABLE R_Repeat_square_bracket T_IDENTIFIER R_defin_var//точно переменная
        ;

R_method_variable://пеменная или метод
        T_IDENTIFIER R_template R_Repeat_square_bracket T_IDENTIFIER R_method_or_var//всё ещё не понятно переменная или метод
        |
        T_DATA_TYPE R_template R_Repeat_square_bracket T_IDENTIFIER R_method_or_var//всё ещё не понятно переменная или метод
        |
        T_DATA_TYPE_VARIABLE R_template R_Repeat_square_bracket T_IDENTIFIER R_defin_var//точно переменная
        |
        T_DATA_TYPE_METHOD R_template T_IDENTIFIER R_defin_method//точно метод
        |
        T_IDENTIFIER R_template R_defin_method
        ;

R_template:
        |
        T_OPEN_ANGLE_BRACKET R_many_identifier T_CLOSE_ANGLE_BRACKET
        ;

R_many_identifier:
        |
        R_TypeField
        |
        R_many_identifier T_COMMA R_TypeField
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
        T_OPEN_BRACKET R_Arguments T_CLOSE_BRACKET T_OPEN_BRACE R_Body_Method T_CLOSE_BRACE//точно метод
        |
        T_OPEN_BRACKET R_Arguments T_CLOSE_BRACKET T_SEMICOLON
        |
        T_OPEN_BRACKET R_Arguments T_CLOSE_BRACKET T_THROWS R_ArgumentsCall T_OPEN_BRACE R_Body_Method T_CLOSE_BRACE 
        ;

R_defin_var:
        R_comma_next_var2 R_comma_next_var T_SEMICOLON//возможно несолько переменных одного типа
        |
        R_comma_next_var2 R_comma_next_var
        ;

R_comma_next_var://несолько переменных одного типа через запятую
        |
        T_COMMA R_TypeField T_IDENTIFIER R_comma_next_var2 R_comma_next_var
        ;

R_comma_next_var2://возможно присвоение
        |
        T_ASSIGNMENT R_Expression
        |
        T_ASSIGNMENT T_OPEN_BRACE R_ArgumentsCall T_CLOSE_BRACE
        ;


R_unary_sign:
        T_MINUS
        |
        T_PLUS
        |
        T_UNARY_SIGN_ONLY
        ;

R_Strings:
        T_STRING R_Repeat_square_bracket
        ;

R_Value:
        T_NUMBER
        |
        R_Strings
        |
        T_FLOAT
        |
        T_TRUE_FALSE
        ;

R_TypeField:
        T_DATA_TYPE
        |
        T_DATA_TYPE_VARIABLE
        |
        T_IDENTIFIER
        ;

R_Arguments:
        |
        R_Arguments T_COMMA R_TypeField R_template R_Repeat_square_bracket T_IDENTIFIER
        |
        R_TypeField R_template R_Repeat_square_bracket T_IDENTIFIER
        ;

R_Body_Method:
        R_Commands
        ;

R_Commands:
        |
        R_Commands R_Command
        ;

R_ArgumentsCall:
        |
        R_ArgumentsCall T_COMMA R_Expression
        |
        R_Expression
        ;

R_Expression:
        T_OPEN_BRACKET R_TypeField T_CLOSE_BRACKET R_Expression
        |
        T_OPEN_BRACKET R_Expression T_CLOSE_BRACKET
        |
        T_OPEN_BRACKET R_Expression T_CLOSE_BRACKET R_all_binary_sign R_next_Expression
        |
        R_first_variable
        |
        R_number
        |
        R_sign
        |
        T_NEW R_TypeField R_template R_Repeat_square_bracket R_Call_methods T_OPEN_BRACKET R_ArgumentsCall T_CLOSE_BRACKET
        |
        T_NEW R_TypeField R_template R_Repeat_square_bracket R_Call_methods
        |
        R_Expression T_QUERY R_Expression T_COLON R_Expression
        |
        R_this_super_block R_can_assigment
        ;

R_this_super_block:
        R_this_super R_Repeat_bracket R_Repeat_square_bracket R_Call_methods
        |
        R_this_super R_Call_methods
        |
        R_this_super R_Repeat_bracket R_Repeat_square_bracket R_Call_methods R_all_binary_sign R_next_Expression
        |
        R_this_super R_Call_methods R_all_binary_sign R_next_Expression
        |
        R_this_super R_Repeat_bracket R_Repeat_square_bracket R_Call_methods T_INCREMENT_DECREMENT_SIGN
        |
        R_this_super R_Repeat_bracket R_Repeat_square_bracket R_Call_methods T_INCREMENT_DECREMENT_SIGN R_all_binary_sign R_next_Expression
        ;

R_can_assigment:
        |
        R_assignment_sign R_Expression
        ;

R_this_super:
        T_THIS
        |
        T_SUPER
        |
        T_CLASS
        ;

R_assignment_sign:
        T_ASSIGNMENT
        |
        T_ASSIGNMENT2
        ;

R_first_variable:
        R_variable
        |
        T_IDENTIFIER R_Repeat_square_bracket R_assignment_sign R_Expression
        ;

R_Call_methods:
        |
        T_DOT T_IDENTIFIER R_Repeat_bracket R_Repeat_square_bracket R_Call_methods
        |
        T_DOT T_IDENTIFIER R_Repeat_square_bracket R_Call_methods
        |
        T_DOT R_this_super R_Repeat_bracket R_Repeat_square_bracket R_Call_methods
        |
        T_DOT R_this_super R_Call_methods
        ;

R_variable:
        T_IDENTIFIER R_Repeat_bracket R_Repeat_square_bracket R_Call_methods
        |
        T_IDENTIFIER R_Repeat_square_bracket R_Call_methods
        |
        T_IDENTIFIER R_Repeat_bracket R_Repeat_square_bracket R_Call_methods R_all_binary_sign R_next_Expression
        |
        T_IDENTIFIER R_Repeat_square_bracket R_Call_methods R_all_binary_sign R_next_Expression
        |
        T_IDENTIFIER R_Repeat_square_bracket T_INCREMENT_DECREMENT_SIGN
        |
        T_IDENTIFIER R_Repeat_square_bracket T_INCREMENT_DECREMENT_SIGN R_all_binary_sign R_next_Expression
        ;

R_Repeat_bracket:
        T_OPEN_BRACKET R_ArgumentsCall T_CLOSE_BRACKET
        ;

R_number:
        R_Value
        |
        R_Value R_all_binary_sign R_next_Expression
        ;

R_sign:
        R_unary_sign R_next_Expression
        |
        T_INCREMENT_DECREMENT_SIGN T_IDENTIFIER R_Repeat_square_bracket
        |
        T_INCREMENT_DECREMENT_SIGN T_IDENTIFIER R_Repeat_square_bracket R_all_binary_sign R_next_Expression
        |
        T_INCREMENT_DECREMENT_SIGN R_this_super_block
        |
        T_INCREMENT_DECREMENT_SIGN R_this_super_block R_all_binary_sign R_next_Expression
        ;

R_next_Expression:
        R_variable
        |
        R_number
        |
        R_sign
        |
        T_OPEN_BRACKET R_TypeField T_CLOSE_BRACKET R_next_Expression
        |
        T_OPEN_BRACKET R_Expression T_CLOSE_BRACKET
        |
        T_OPEN_BRACKET R_Expression T_CLOSE_BRACKET R_all_binary_sign R_next_Expression
        ;


R_Command:
        R_Expression T_SEMICOLON
        |
        R_Modifiers
        |
        R_Cycle
        |
        R_If
        |
        R_Try
        |
        T_BREAK T_SEMICOLON
        |
        T_CONTINUE T_SEMICOLON
        |
        T_ASSERT R_Expression T_SEMICOLON
        |
        T_ASSERT R_Expression T_COLON R_Expression T_SEMICOLON
        |
        T_RETURN R_Expression T_SEMICOLON
        |
        T_THROW R_Expression T_SEMICOLON
        ;

R_Try:
        T_TRY R_Body R_Catch R_Finaly
        ;

R_Catch:
        T_CATCH T_OPEN_BRACKET R_Arguments T_CLOSE_BRACKET R_Body
        |
        R_Catch T_CATCH T_OPEN_BRACKET R_Arguments T_CLOSE_BRACKET R_Body
        ;

R_Finaly:
        |
        T_FINALLY R_Body
        ;


R_If:
        T_IF T_OPEN_BRACKET R_Cond T_CLOSE_BRACKET R_Body
        |
        T_IF T_OPEN_BRACKET R_Cond T_CLOSE_BRACKET R_Body T_ELSE R_Body
        ;

R_Cycle:
        T_FOR T_OPEN_BRACKET R_Initialization_for R_Cond_for T_SEMICOLON R_Cond_for T_CLOSE_BRACKET R_Body
        |
        T_FOR T_OPEN_BRACKET R_Initialization_for T_COLON R_Expression T_CLOSE_BRACKET R_Body
        |
        T_WHILE T_OPEN_BRACKET R_Cond T_CLOSE_BRACKET R_Body
        |
        T_DO R_Body T_WHILE T_OPEN_BRACKET R_Cond T_CLOSE_BRACKET T_SEMICOLON
        ;

R_Initialization_for:
        |
        R_Modifiers
        ;

R_Cond_for:
        |
        R_Expression
        ;

R_Cond:
        R_Expression
        ;

R_Body:
        T_OPEN_BRACE R_Commands T_CLOSE_BRACE
        |
        R_Command
        ;


R_all_binary_sign:
        R_unary_sign
        |
        R_binary_sign
        |
        R_comparison_sign
        ;


R_binary_sign:
        T_BINARY_SIGN
        |
        T_STAR
        ;

R_comparison_sign:
        T_COMPARISON_SIGN
        |
        T_CLOSE_ANGLE_BRACKET
        |
        T_OPEN_ANGLE_BRACKET
        ;

R_BodyClass:
        T_OPEN_BRACE R_BodyClass2 T_CLOSE_BRACE
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