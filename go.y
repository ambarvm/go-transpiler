%{
  #include <stdio.h>

  int yylex();
  void yyerror(char*);

  extern FILE *yyin;
%}

%right '=' DECLARE_ASSIGN ADD_ASSIGN SUB_ASSIGN MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN LS_ASSIGN RS_ASSIGN AND_ASSIGN XOR_ASSIGN OR_ASSIGN

%left LOG_OR
%left LOG_AND
%left EQ NEQ '<' LTE '>' GTE
%left '+' '-' '|' '^'
%left '*' '/' '%' LSHIFT RSHIFT '&'

%right '!'
%token INCR DECR
%token VARIADIC

// Keywords
%token BREAK DEFAULT FUNC INTERFACE SELECT CASE DEFER GO MAP STRUCT CHAN ELSE GOTO PACKAGE SWITCH CONST FALLTHROUGH IF RANGE TYPE CONTINUE FOR IMPORT RETURN VAR

%token INT_LTR STRING_LTR BOOL_LTR IDENT

%%
file:package_clause import_list func_decl ';';

package_clause: PACKAGE IDENT ';';

import_list:import_list import
|import_list
|;

import: IMPORT STRING_LTR ';'
|IMPORT IDENT STRING_LTR ';'
|IMPORT '.' STRING_LTR ';';

stmt_list:
|stmt_list stmt ';';

stmt: expr;

block: '{' stmt_list '}';

expr:expr '+' expr
|expr '-' expr
|expr '*' expr
|expr '/' expr
|expr '%' expr
|expr '&' expr
|expr '|' expr
|expr '^' expr
|expr '<' expr
|expr LTE expr
|expr '>' expr
|expr GTE expr
|'(' expr ')'
|IDENT
|IDENT '(' expr ')'
|IDENT '[' expr ']'
|INT_LTR
|STRING_LTR
|BOOL_LTR;

/* Data Types */
type: type_name
|arr_type
|ptr_type
|'(' type ')';
type_name: IDENT;
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
param_decl:ident_list_opt variadic_opt type;

ident_list_opt:
|ident_list;
ident_list:IDENT
|ident_list ',' IDENT;

variadic_opt:
|VARIADIC;


assign_expr:IDENT assign_op expr;

assign_op:'='
|ADD_ASSIGN
|SUB_ASSIGN
|MUL_ASSIGN
|DIV_ASSIGN
|MOD_ASSIGN
|LS_ASSIGN
|RS_ASSIGN
|AND_ASSIGN
|XOR_ASSIGN
|OR_ASSIGN;
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
