all:
	yacc -d Java_yacc.y
	lex Java_lex.l
	cc lex.yy.c y.tab.c -o Java.out

debug:
	yacc -d Java_yacc.y --debug
	lex Java_lex.l
	cc lex.yy.c y.tab.c -o Java.out

run:
	./Java.out < test.z
