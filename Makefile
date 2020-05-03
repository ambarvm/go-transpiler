lexer: lexer.l include/tokens.h include/symbol-table.h src/symbol-table.cc
	flex -+ ./lexer.l
	g++ src/symbol-table.cc lex.yy.cc -lfl -o lexer

clean:
	rm lex.yy.cc lexer
