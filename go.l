%{
  #include "go.tab.h"

  int f(int);
%}

%option yylineno

ESCAPED_CHAR \\[abfnrtv\\'"]

%%
 /* Operators */
"+"|"-"|"*"|"/"|"%"|"="|">"|"<"|"&"|"|"|"!"|"^" return f(yytext[0]);
"&&" return f(LOG_AND);
"||" return f(LOG_OR);
"==" return f(EQ);
"!=" return f(NEQ);
"<=" return f(LTE);
">=" return f(GTE);
"<<" return f(LSHIFT);
">>" return f(RSHIFT);
"&^" return f(BIT_CLEAR);

":=" return f(COLON_EQUAL);
"+=" return f(ADD_ASSIGN);
"-=" return f(SUB_ASSIGN);
"*=" return f(MUL_ASSIGN);
"/=" return f(DIV_ASSIGN);
"%=" return f(MOD_ASSIGN);
"<<=" return f(LS_ASSIGN);
">>=" return f(RS_ASSIGN);
"&=" return f(AND_ASSIGN);
"^=" return f(XOR_ASSIGN);
"|=" return f(OR_ASSIGN);

"++" return f(INCR);
"--" return f(DECR);

"..." return f(VARIADIC);

 /* Brackets */
"("|")"|"["|"]"|"{"|"}" return f(yytext[0]);
 /* Punctuation */
","|";"|"."|":" return f(yytext[0]);

 /* Keywords */
break return f(BREAK);
default return f(DEFAULT);
func return f(FUNC);
interface return f(INTERFACE);
select return f(SELECT);
case return f(CASE);
defer return f(DEFER);
go return f(GO);
map return f(MAP);
struct return f(STRUCT);
chan return f(CHAN);
else return f(ELSE);
goto return f(GOTO);
package return f(PACKAGE);
switch return f(SWITCH);
const return f(CONST);
fallthrough return f(FALLTHROUGH);
if return f(IF);
range return f(RANGE);
type return f(TYPE);
continue return f(CONTINUE);
for return f(FOR);
import return f(IMPORT);
return return f(RETURN);
var return f(VAR);


 /* Constants */
[0][oO](_[0-7]|[0-7])*|[0][xX](_[0-9a-fA-F]|[0-9a-fA-F])*|[0][bB](_[01]|[01])*|[0-9](_[0-9]|[0-9])* return f(INT_LTR);
\"(\\.|[^"\\\n])*\" return f(STRING_LTR);
'({ESCAPED_CHAR}|[^'\\\n])' return f(RUNE_LTR);
true|false return f(BOOL_LTR);


 /* Comments */
"//".* ;
\/\*([^*]|\*+[^/])*\*+\/ ;


[a-zA-Z_][a-zA-Z0-9_]* return f(IDENT);

\n { int token = f('\n'); if (token != '\n') return token; }
[ \t] ;

. printf("Unknown Character: %s\n",yytext);
%%

int insert_semi = 0;

/**
* Insert ';' at end of statement
*/
int f(int token) {
  if (insert_semi && token == '\n') {
    insert_semi = 0;
    return ';';
  } else {
    insert_semi = (
      token == IDENT
      || token == INT_LTR
      || token == BOOL_LTR
      || token == STRING_LTR
      || token == BREAK
      || token == CONTINUE
      || token == FALLTHROUGH
      || token == RETURN
      || token == INCR
      || token == DECR
      || token == ')'
      || token == '}'
    );
    return token;
  }
}
