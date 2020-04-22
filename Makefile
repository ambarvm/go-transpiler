lexer: lexer.l tokens.h
	flex -+ ./lexer.l
	g++ lex.yy.cc -lfl -o lexer

clean:
	rm lex.yy.cc lexer
