parser: go.l go.y
	bison -d go.y
	flex go.l
	gcc go.tab.c lex.yy.c -lfl -o parse

clean:
	rm lex.yy.c parse go.tab.* go.output
