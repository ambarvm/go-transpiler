%option noyywrap

%{
#include "tokens.h"
#include <iostream>
#include <fstream>

using namespace std;

int count = 0;
%}
sep [ \n\t]

%%

func return FUNC;
var return VAR;
if return IF;
else return ELSE;
for return FOR;

break return BREAK;
continue return CONTINUE;
return return RETURN;
package return PACKAGE;
switch return SWITCH;
case return CASE;
struct return STRUCT;
import return IMPORT;
goto return GOTO;

go return GO;
defer return DEFER;
default return DEFAULT;
interface return INTERFACE;
map return MAP;
select return SELECT;
const return CONST;
chan return CHAN;
range return RANGE;
type return TYPE;
fallthrough return FALLTHROUGH;


; return SEMICOLON;
: return COLON;
, return COMMA;
\. return DOT;
:= return DEFINE;


\{ return BRACE_START;
\} return BRACE_END;
\( return RBRACKET_START;
\) return RBRACKET_END;
\[ return SBRACKET_START;
\] return SBRACKET_END;


>|<|>=|<=|==|!= return RELOP;
\+|\-|\*|\/|%|\+\+|-- return AROP;
&&|\|\||! return LOGOP;
=|\+=|-=|\*=|\/=|%=|<<=|>>=|&=|^=|\|= return ASOP;

true|false return BOOL_CONST;
\"(\\.|[^"\\\n])*\" return STR_CONST;
[0-9]+ return INT_CONST;

[a-zA-Z_][a-zA-Z0-9_]* return ID;

%%

int main() {
    ifstream inputFile;
    inputFile.open("./test.go");

    FlexLexer* lexer = new yyFlexLexer(&inputFile);

    int token;

    while((token = lexer->yylex()) != 0) {
        printf("<%d, %s>", token, lexer->YYText());
    }

    return 0;
}
