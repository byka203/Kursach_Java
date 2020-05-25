%{
    #include <stdio.h>
    #include "y.tab.h"
    extern int number_str;

%}

%%
"import"                                            return T_IMPORT;
"package"                                           return T_PACKAGE;

"class"                                             return T_CLASS;
"interface"                                         return T_INTERFACE;

"byte"|"boolean"|"char"|"double"|"float"|"int"|"long"|"short"|"String" return T_DATA_TYPE;
"var"                                               return T_DATA_TYPE_VARAIBLE;
"void"                                              return T_DATA_TYPE_METHOD;

"enum"                                              return T_ENUM;

"public"|"private"|"protected"                      return T_ACCESS_MODIFIERS;

"static"|"final"                                    return T_VARAIBLE_CLASS_METHOD_MODIFIERS;
"abstract"                                          return T_CLASS_METHOD_MODIFIERS;
"transient"                                         return T_VARAIBLE_MODIFIERS;
"native"                                            return T_METHOD_MODIFIERS;
"strictfp"                                          return T_CLASS_MODIFIERS;
"synchronized"|"volatile"                           return T_STREAM_MODIFIERS;

"extends"                                           return T_EXTENDS;
"implements"                                        return T_IMPLEMENTS;
"throw"                                             return T_THROW;

"true"|"false"                                      return T_TRUE_FALSE;

"if"                                                return T_IF;
"else"                                              return T_ELSE;

"switch"                                            return T_SWITCH;
"case"                                              return T_CASE;
"default"                                           return T_DEFAULT;

"try"                                               return T_TRY;
"catch"                                             return T_CATCH;
"throws"                                            return T_THROWS;
"finally"                                           return T_FINALLY;

"for"                                               return T_FOR;
"do"                                                return T_DO;
"while"                                             return T_WHILE;

"break"                                             return T_BREAK;
"continue"                                          return T_CONTINUE;


"new"                                               return T_NEW;
"super"                                             return T_SUPER;
"this"                                              return T_THIS;

"assert"                                            return T_ASSERT;
"instaceof"                                         return T_INSTACEOF;
"return"                                            return T_RETURN;

"++"|"--"                                           return T_INCREMENT_DECREMENT_SIGN;
"~"|"!"                                             return T_UNARY_SIGN_ONLY;
"-"                                                 return T_MINUS;
"+"                                                 return T_PLUS;
"=="|"!="|">="|"<="|">"|"<"                         return T_COMPARISON_SIGN;
"/"|"%"|"&"|"|"|"^"|"<<"|">>"|">>>"|"&&"|"||"       return T_BINARY_SIGN;
"*"                                                 return T_STAR;
"="                                                 return T_ASSIGNMENT;

"("                                                 return T_OPEN_BRACKET;
")"                                                 return T_CLOSE_BRACKET;
"["                                                 return T_OPEN_SQUARE_BRACKET;
"]"                                                 return T_CLOSE_SQUARE_BRACKET;
"{"                                                 return T_OPEN_BRACE;
"}"                                                 return T_CLOSE_BRACE;

";"                                                 return T_SEMICOLON;
"."                                                 return T_DOT;
","                                                 return T_COMMA;
"?"                                                 return T_QUERY;
":"                                                 return T_COLON;

\"([^"]|\\.)*\"                                     return T_STRING;

[0-9]+"."[0-9]+"f"                                  return T_FLOAT;
[0-9]+                                              return T_NUMBER;
[_a-zA-Z][_a-zA-Z0-9]*                              return T_IDENTIFIER;
\n                                                  ++number_str;
[ \t]+                                              ;
%%