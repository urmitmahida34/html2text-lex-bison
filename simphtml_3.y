%{
#include <stdio.h>
#include <stdlib.h>

extern FILE* yyin;
extern int yylex();

void yyerror(const char* s);

%}

%union {
    char* strval;
}

%token <strval> TEXT

%%

input:
    /* empty */
    | input line
    ;

line:
    TEXT { printf("%s ", $1); free($1); }
    ;

%%

int main(int argc, char** argv) {
    if (argc < 2) {
        printf("Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    yyin = fopen(argv[1], "r");
    if (!yyin) {
        printf("Failed to open input file.\n");
        return 1;
    }

    yyparse();

    fclose(yyin);

    return 0;
}

void yyerror(const char* s) {
    fprintf(stderr, "Error: %s\n", s);
}

