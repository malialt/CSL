integer [0-9]+
numb [+-]?[0-9]+
char [A-Za-z]
id {char}+[0-9]*
boolean {tru}|{fal}
type "int"|"char"|"string"|"void"|"bool"
const_var {const_type}{spc}+{var}
const_type "const"|"CONST"
ids {id}{spc}*{comma}{spc}*
assign "="
spc " "
var {type}{spc}*{id}
vars {var}{spc}*{comma}{spc}*
lp "("
rp  ")"
lcurl "{"
rcurl "}"
fcall "f"{alt}
alt "_"
comma ","
beg "beg"|"BEG"
arr "arr"
endbeg "endbeg"|"ENDBEG"
tru "true"|"TRUE"
fal "false"|"FALSE"
plus "++"
minus "--"
mul "**"
div "//"
and "&&"
or "||"
implication "->"
equivalence "<->"
lsq "["
rsq "]"
neg "~"
equal "=="
colon ":"
semicolon ";"
greater ">"
smaller "<"
if "if"|"IF"
then "then"|"THEN"
else "else"|"ELSE"
while "while"
for "for"
inp "inp"
out "out"
pred bool{spc}*{fcall}{id}{spc}*{lp}{spc}*{vars}*{var}{spc}*{rp}
predInst {fcall}{id}{spc}*{lp}{spc}*{ids}*{id}{spc}*{rp}
nl \n
%%

{nl}         {extern int lineno; lineno++;
               return NL;
             }
{lp} return LEFT_PARA ;
{rp} return RIGHT_PARA ;
{lcurl} return L_CURL;
{rcurl} return R_CURL;
{lsq} return L_SQR;
{rsq} return R_SQR;
{inp} return INP_STRM;
{arr} return ARR;
{out} return OUT_STRM ;
{if} return IF ;
{else} return ELSE ;
{then} return THEN ;
{while} return WHILE ;
{for} return FOR;
{const_type} return CONST_TYPE ;
{beg} return BEG ;
{endbeg} return ENDBEG ;
{numb} return NUMBER ;
{type} return TYPE;
{var} return VARIABLE;
{const_var} return CONST_VAR;
{pred} return PREDIFIER_FUNC ;
{predInst} return  PREDIFIER_INST_FCALL ;
{id} return ID ;
{assign} return ASSIGN_OP ;
{comma} return COMMA ;
{colon} return COLON ;
{semicolon} return  SEMICOLON ;
{greater} return GREATER_OP ;
{smaller} return SMALLER_OP ;
{plus} return PLUS ;
{minus} return MINUS ;
{mul} return MULTIPLIER ;
{div} return DIVISION ;
{and} return AND ;
{or} return OR ;
{equivalence} return EQUIVALENCE ;
{implication} return IMPLICATION ;
{equal} return IS_EQUAL ;
{neg} return NEGATION ;
{spc} return SPACE;
. {return (yytext[0]);}
%%
int yywrap() { return 1; }


