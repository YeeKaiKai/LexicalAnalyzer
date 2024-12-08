%{
    #include <stdio.h>
    #include <getopt.h>

    #define EOF         0
    #define AND         1
    #define BEGIN       2
    #define DO          3
    #define ELSE        4
    #define END         5
    #define ENDIF       6
    #define ENDWHILE    7
    #define EXIT        8
    #define IF          9
    #define SET         10
    #define NOT         11
    #define OR          12
    #define PROGRAM     13
    #define READ        14
    #define THEN        15
    #define VAR         16
    #define WHILE       17
    #define WRITE       18
    #define ADD         19
    #define SUB         20
    #define MUL         21
    #define DIV         22
    #define MOD         23
    #define ASS         24
    #define EQ          25
    #define NEQ         26
    #define GT          27
    #define GTE         28
    #define LT          29
    #define LTE         30
    #define LP          31
    #define RP          32
    #define ID          33
    #define CONSTANT    34

    extern char *yytext;
    extern int yyleng;

    union {
        char* str;
        int con;
    } yylval;
%}

%option    noyywrap
%option    yylineno

delim               [ \t\r\n]
ws                  {delim}+
letter              [A-Za-z]
digit               [0-9]
underscore          [_]
constant            [digit]+

%%

"/""/".*      { /* no action and no return */ }
{ws}        { /* no action and no return */ }
And         { return (AND); }
Begin       { return (BEGIN); }
Do          { return (DO); }
Else        { return (ELSE); }
End         { return (END); }
EndIf       { return (ENDIF); }
EndWhile    { return (ENDWHILE); }
Exit        { return (EXIT); }
If          { return (IF); }
Set         { return (SET); }
Not         { return (NOT); }
Or          { return (OR); }
Program     { return (PROGRAM); }
Read        { return (READ); }
Then        { return (THEN); }
Var         { return (VAR); }
While       { return (WHILE); }
Write       { return (WRITE); }
"+"         { return (ADD); }
"-"         { return (SUB); }
"*"         { return (MUL); }
"/"         { return (DIV); }
"%"         { return (MOD); }
"="         { return (ASS); }
"=="        { return (EQ); }
"<>"        { return (NEQ); }
">"         { return (GT); }
">="        { return (GTE); }
"<"         { return (LT); }
"<="        { return (LTE); }
"("         { return (LP); }
")"         { return (RP); }
({letter}|{underscore})({letter}|{digit}|{underscore})* { 
    yylval.str = strdup(yytext); 
    return (ID);
}
[0-9]+ {
    yylval.con = atoi(yytext);
    return (CONSTANT);
}
. {
    fprintf(stderr, "Lexical error: line %d: unknown character %s\n", yylineno, yytext);
}

%%
int main(int argc, char* argv[]) {
    int opt, verbose = 0;
    while ((opt = getopt(argc, argv, "s")) != -1) {
        switch (opt) {
            case 's':
                verbose = 1;
                break;
            default:
                fprintf(stderr, "Usage: %s [-s]\n", argv[0]);
                exit(EXIT_FAILURE);
        }
    }

    int token;
    if (verbose == 1) {
        while ((token = yylex()) != EOF) {
            switch (token) {
                case ID:
                    printf("Identifier: %s\n", yylval.str);
                    break;
                case PROGRAM:
                    printf("Keyword: Program\n");
                    break;
                case BEGIN:
                    printf("Keyword: Begin\n");
                    break;
                case DO:
                    printf("Keyword: Do\n");
                    break;
                case ELSE:
                    printf("Keyword: Else\n");
                    break;
                case END:
                    printf("Keyword: End\n");
                    break;
                case ENDIF:
                    printf("Keyword: EndIf\n");
                    break;
                case ENDWHILE:
                    printf("Keyword: EndWhile\n");
                    break;
                case EXIT:
                    printf("Keyword: Exit\n");
                    break;
                case IF:
                    printf("Keyword: If\n");
                    break;
                case SET:
                    printf("Keyword: Set\n");
                    break;
                case NOT:
                    printf("Keyword: Not\n");
                    break;
                case OR:
                    printf("Keyword: Or\n");
                    break;
                case READ:
                    printf("Keyword: Read\n");
                    break;
                case THEN:
                    printf("Keyword: Then\n");
                    break;
                case VAR:
                    printf("Keyword: Var\n");
                    break;
                case WHILE:
                    printf("Keyword: While\n");
                    break;
                case WRITE:
                    printf("Keyword: Write\n");
                    break;
                case ADD:
                    printf("Operator: +\n");
                    break;
                case SUB:
                    printf("Operator: -\n");
                    break;
                case MUL:
                    printf("Operator: *\n");
                    break;
                case DIV:
                    printf("Operator: /\n");
                    break;
                case MOD:
                    printf("Operator: %%\n");
                    break;
                case ASS:
                    printf("Operator: =\n");
                    break;
                case EQ:
                    printf("Operator: ==\n");
                    break;
                case NEQ:
                    printf("Operator: <>\n");
                    break;
                case GT:
                    printf("Operator: >\n");
                    break;
                case GTE:
                    printf("Operator: >=\n");
                    break;
                case LT:
                    printf("Operator: <\n");
                    break;
                case LTE:
                    printf("Operator: <=\n");
                    break;
                case LP:
                    printf("Operator: (\n");
                    break;
                case RP:
                    printf("Operator: )\n");
                    break;
                case CONSTANT:
                    printf("Integer Constant: %d\n", yylval.con);
                    break;
                default:
                    break;
            }
        }
    }
    return 0;
}
