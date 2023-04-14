%{
    #include <stdio.h>
    void yyerror (const char *msg)
    {return; }
%}

%token tCOMMA tLBRAC tRBRAC tSTRING tGET tSET tFUNCTION tPRINT tIF tRETURN tADD tSUB tMUL tDIV tINC tGT tEQUALITY tDEC tLT tLEQ tGEQ tIDENT tNUM

%start prog

%%

prog: tLBRAC statement_seq tRBRAC
;

statement_seq :
    | statement statement_seq
;

statement: setstate 
    | ifstate 
    | printstate 
    | increment 
    | decrement 
    | exp 
    | return
;

setstate : tLBRAC tSET tCOMMA tIDENT tCOMMA exp tRBRAC
;

exp: tNUM 
    | tSTRING 
    | function 
    | condition 
    | getstate 
    | arithmetic
;

getstate: tLBRAC tGET tCOMMA tIDENT tCOMMA tLBRAC mul_exp tRBRAC tRBRAC 
    | tLBRAC tGET tCOMMA tIDENT tRBRAC
;

mul_exp:
    | exp
    | exp tCOMMA mul_exp
;

arithmetic: tLBRAC op tCOMMA exp tCOMMA exp tRBRAC
;

op: tADD 
    | tSUB
    | tDIV
    | tMUL
;

printstate: tLBRAC tPRINT tCOMMA exp tRBRAC
;

ifstate: tLBRAC tIF tCOMMA condition tCOMMA then else tRBRAC
;

condition: tLBRAC compare tCOMMA exp tCOMMA exp tRBRAC
;

compare: tEQUALITY 
    | tLEQ 
    | tGEQ
    | tLT
    | tGT

then: tLBRAC statement_seq tRBRAC
;

else: 
    | tLBRAC statement_seq tRBRAC
;

return: tLBRAC tRETURN r_exp tRBRAC
;

r_exp: 
    | tCOMMA exp
;

increment: tLBRAC tINC tCOMMA tIDENT tRBRAC
;

decrement: tLBRAC tDEC tCOMMA tIDENT tRBRAC
;

function: tLBRAC tFUNCTION tCOMMA tLBRAC param tRBRAC tCOMMA tLBRAC statement_seq tRBRAC tRBRAC
;

param: 
    | tIDENT
    | tIDENT tCOMMA param
;

%%

int main()
{
    if (yyparse())
    {
        printf("ERROR\n");
        return 1;
    }
    else 
    {
        printf("OK\n");
        return 0;
    }
}

