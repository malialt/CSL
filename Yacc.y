%{
#include <stdio.h>
 %}

%token IF ELSE THEN WHILE FOR NL
%token CONST_VAR CONST_TYPE TRUE FALSE BEG ENDBEG NUMBER VARIABLE
%token PREDIFIER_FUNC PREDIFIER_INST_FCALL
%token ID ASSIGN_OP ARR
%token PLUS MINUS MULTIPLIER DIVISION AND OR EQUIVALENCE IMPLICATION
%token IS_EQUAL NEGATION
%token INP_STRM OUT_STRM
%token TYPE BOOLEAN
%token SPACE LEFT_PARA L_SQR R_SQR RIGHT_PARA L_CURL R_CURL COMMA COLON SEMICOLON GREATER_OP SMALLER_OP

%%
prog :BEG NL stat_list NL ENDBEG {printf("\n LANGUAGE IS CORRECT\n");return 0;}
;
stat_list: stmt | stat_list NL stmt
;
stmt :if_stmt
|stmt_e
;
stmt_e : |assign SEMICOLON| loop | fnc | in_out_stmt SEMICOLON| expr SEMICOLON
;


if_stmt : matched | unmatched
;
matched: IF LEFT_PARA bool_expr RIGHT_PARA THEN matched ELSE matched
| stmt_e
| L_CURL SPACE matched SPACE R_CURL
;
unmatched: IF LEFT_PARA bool_expr RIGHT_PARA THEN L_CURL stmt R_CURL
| IF LEFT_PARA expr RIGHT_PARA THEN matched ELSE unmatched
;

expr: bool_expr | math_expr
;
bool_expr : log_expr | equ_expr
;

log_expr: log_expr SPACE AND SPACE log_term|log_expr SPACE AND log_term|log_expr AND log_term|log_expr AND SPACE log_term
| log_expr SPACE OR SPACE log_term|log_expr SPACE OR log_term|log_expr OR log_term|log_expr OR SPACE log_term
| log_expr SPACE IMPLICATION SPACE log_term|log_expr SPACE IMPLICATION log_term|log_expr IMPLICATION log_term|log_expr IMPLICATION SPACE log_term
| log_expr SPACE EQUIVALENCE SPACE log_term|log_expr SPACE EQUIVALENCE log_term|log_expr EQUIVALENCE log_term|log_expr EQUIVALENCE SPACE log_term
| log_expr SPACE IS_EQUAL SPACE log_term|log_expr SPACE IS_EQUAL log_term| log_expr IS_EQUAL SPACE log_term | log_expr IS_EQUAL log_term
| log_term
| NEGATION log_term
;
log_term : LEFT_PARA log_expr  RIGHT_PARA | ID| LEFT_PARA SPACE log_expr RIGHT_PARA| LEFT_PARA log_expr SPACE RIGHT_PARA|LEFT_PARA SPACE log_expr SPACE RIGHT_PARA
| ID
;

equ_expr: ID SPACE GREATER_OP SPACE ID| ID SPACE SMALLER_OP SPACE ID
|NUMBER SPACE GREATER_OP SPACE NUMBER|NUMBER SPACE SMALLER_OP SPACE NUMBER
|NUMBER SPACE GREATER_OP SPACE ID|NUMBER SPACE SMALLER_OP SPACE ID
|ID SPACE GREATER_OP SPACE NUMBER|ID SPACE SMALLER_OP SPACE NUMBER
;

math_expr:math_expr SPACE PLUS SPACE math_term| math_expr SPACE PLUS math_term|math_expr PLUS math_term|math_expr PLUS SPACE math_term
| math_expr SPACE MINUS SPACE math_term |math_expr SPACE MINUS math_term| math_expr MINUS math_term|math_expr MINUS SPACE math_term
| math_term
;
math_term: math_term SPACE MULTIPLIER SPACE math_factor| math_term MULTIPLIER math_factor | math_term SPACE MULTIPLIER math_factor| math_term MULTIPLIER SPACE math_factor
| math_term SPACE DIVISION SPACE math_factor | math_term DIVISION math_factor | math_term SPACE DIVISION math_factor| math_term DIVISION SPACE math_factor
| math_factor
;
math_factor:LEFT_PARA math_expr  RIGHT_PARA
| LEFT_PARA SPACE math_expr RIGHT_PARA
| LEFT_PARA math_expr SPACE RIGHT_PARA
| LEFT_PARA SPACE math_expr SPACE RIGHT_PARA
| ID
| NUMBER
;

fnc: predicate L_CURL stmt R_CURL | predicate_instantiations
;
predicate: PREDIFIER_FUNC | PREDIFIER_FUNC NL | PREDIFIER_FUNC SPACE
;
predicate_instantiations: PREDIFIER_INST_FCALL SEMICOLON
;
assign: assi|assiSpace
;
assi:var ASSIGN_OP NUMBER
|var ASSIGN_OP BOOLEAN
|var ASSIGN_OP expr
|var ASSIGN_OP ID
|var ASSIGN_OP L_CURL arr R_CURL
;
assiSpace:var SPACE ASSIGN_OP SPACE NUMBER
|var SPACE ASSIGN_OP SPACE BOOLEAN
|var SPACE ASSIGN_OP SPACE expr
|var SPACE ASSIGN_OP SPACE ID
|var SPACE ASSIGN_OP SPACE L_CURL arr R_CURL
;

var: VARIABLE | VARIABLE SPACE ARR L_SQR NUMBER R_SQR | ID
;

arr:NUMBER|arr COMMA NUMBER
;

in_out_stmt: inp |inp SPACE | out | out SPACE
;
inp: INP_STRM SPACE ID
;
out: OUT_STRM SPACE ID
;

loop: while_stat | for_stat
;
while_stat: WHILE LEFT_PARA SPACE expr SPACE RIGHT_PARA SPACE L_CURL SPACE stmt_e SPACE R_CURL
;
for_stat: FOR LEFT_PARA SPACE assign SEMICOLON SPACE bool_expr SEMICOLON SPACE stmt_e SPACE RIGHT_PARA SPACE L_CURL SPACE stmt_e SPACE R_CURL
;


%%
#include "lex.yy.c"
int lineno = 1;
main() {
  return yyparse();
}
void yyerror(char *s) {printf("\n **** ERROR AT LINE NO %d ****\n\n", lineno);}
