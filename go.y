%{
  #include <stdio.h>

  int yylex();
  void yyerror(char*);

  extern FILE *yyin;
%}

%right '=' COLON_EQUAL ADD_ASSIGN SUB_ASSIGN MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN LS_ASSIGN RS_ASSIGN AND_ASSIGN XOR_ASSIGN OR_ASSIGN

%left LOG_OR
%left LOG_AND
%left '>' '<' EQ NEQ LTE GTE
%left '+' '-' '|' '^'
%left '*' '/' '%' '&' BIT_CLEAR LSHIFT RSHIFT

%left '('
%left ')'

%right '!'
%token INCR DECR
%token VARIADIC

// Keywords
%token BREAK DEFAULT FUNC INTERFACE SELECT CASE DEFER GO MAP STRUCT CHAN ELSE GOTO PACKAGE SWITCH CONST FALLTHROUGH IF RANGE TYPE CONTINUE FOR IMPORT RETURN VAR

%token INT_LTR STRING_LTR BOOL_LTR IDENT

%%
file:package_clause ';' import_list top_level_decl_list;

package_clause: PACKAGE IDENT;

import_list:
|import_list import ';';

import: IMPORT STRING_LTR
|IMPORT IDENT STRING_LTR
|IMPORT '.' STRING_LTR;

top_level_decl_list:
|top_level_decl_list top_level_decl ';';

top_level_decl: func_decl
|declaration;

declaration:const_decl
|type_decl
|var_decl;

const_decl:CONST const_spec
|CONST '(' const_spec_list ')';

const_spec_list:
|const_spec_list const_spec ';';

const_spec:ident_list
|ident_list '=' expr_list
|ident_list type '='  expr_list;


var_decl:VAR var_spec
|'(' var_spec_list ')';

var_spec_list:
|var_spec_list var_spec ';';

var_spec:ident_list '=' expr_list
|ident_list type
|ident_list type '=' expr_list;

type_decl:TYPE type_spec
|TYPE '(' type_spec_list ')';

type_spec_list:
|type_spec_list type_spec ';';

type_spec:alias_decl
|type_def;

alias_decl: IDENT '=' type;

type_def: IDENT type;

expr_list:expr
|expr_list ',' expr;

stmt_list:
|stmt_list stmt ';';

stmt:declaration
|labeled_stmt
|simple_stmt
|go_stmt
|return_stmt
|break_stmt
|continue_stmt
|goto_stmt
|FALLTHROUGH
|block
|if_stmt
|for_stmt
|switch_stmt
|defer_stmt;

simple_stmt:
|expr
|inc_dec_stmt
|assignment
|short_var_decl;

short_var_decl:ident_list COLON_EQUAL expr_list;

inc_dec_stmt:expr INCR
|expr DECR;

assignment:expr_list assign_op expr_list;
assign_op:ADD_ASSIGN
|SUB_ASSIGN
|MUL_ASSIGN
|DIV_ASSIGN
|MOD_ASSIGN
|LS_ASSIGN
|RS_ASSIGN
|AND_ASSIGN
|XOR_ASSIGN
|OR_ASSIGN;

labeled_stmt:IDENT ':' stmt;
go_stmt:GO expr;
return_stmt:RETURN
|RETURN expr_list;
break_stmt:BREAK
|BREAK IDENT;
continue_stmt:CONTINUE
|CONTINUE IDENT;
goto_stmt:GOTO IDENT;
defer_stmt:DEFER expr;

if_stmt:IF expr block else_block_opt
|IF simple_stmt ';' expr block else_block_opt;

else_block_opt:ELSE block
|ELSE if_stmt;

for_stmt:FOR block
|FOR condition block
|FOR for_clause block
|FOR range_clause block
;

condition:expr;
for_clause:simple_stmt ';' condition ';' simple_stmt;
range_clause:expr_list '=' RANGE expr
|ident_list COLON_EQUAL RANGE expr;

switch_stmt:SWITCH expr_opt '{' case_list '}'
|SWITCH simple_stmt ';' expr_opt '{' case_list '}';

case_list:
|case_list case_clause;

case_clause:switch_case ':' stmt_list;

switch_case:DEFAULT
|CASE expr_list;

block: '{' stmt_list '}';

expr:unary_expr
|expr binary_op expr;

unary_expr:primary_expr
|unary_op unary_expr;

binary_op:LOG_OR|LOG_AND|rel_op|add_op|mul_op;
rel_op:EQ|NEQ|'<'|LTE|'>'|GTE;
add_op:'+'|'-'|'|'|'^';
mul_op:'*'|'/'|'%'|LSHIFT|RSHIFT|'&'|BIT_CLEAR;

unary_op:'+'|'-'|'!'|'^'|'*'|'&';

primary_expr:operand
|primary_expr selector
|primary_expr index
|primary_expr type_assertion
|primary_expr arguments;

selector: '.' IDENT;
index:'[' expr ']';
type_assertion:'.' '(' type ')';
arguments: '(' expr_list comma_opt ')'
|'(' expr_list VARIADIC comma_opt ')';

operand:literal
|operand_name
|'(' expr ')';

operand_name:IDENT;

literal: basic_lit;

basic_lit:INT_LTR|STRING_LTR;

expr_opt:
|expr;

/* Data Types */
type: type_name
|type_lit
|'(' type ')';

type_name: IDENT;

type_lit:arr_type
|ptr_type;

arr_type: '[' expr ']' type;

ptr_type: '*' type;


/* Functions */
func_decl: FUNC IDENT signature block;

signature:params
|params result;

result:params
|type;

params:'(' ')'
|'(' param_list ')'
|'(' param_list ',' ')';

param_list:param_list ',' param_decl
|param_decl;

param_decl:ident_list VARIADIC type
|ident_list type
|VARIADIC type;

ident_list:IDENT
|ident_list ',' IDENT;

comma_opt:','|;
%%

int main(int argc, char* argv[]) {
  if (argc == 2) {
    yyin = fopen(argv[1], "r");
  } else if (argc > 2) {
    printf("Usage: %s [filename]\n", argv[0]);
    return 1;
  }
  yyparse();
  return 0;
}

void yyerror(char *s) {
  fprintf(stderr, "error:%s\n", s);
}
