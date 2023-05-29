%{
#include <stdio.h>
#include <stdlib.h>
#include "simphtml_3.tab.h"

extern YYSTYPE yylval;

%}

%%

"<"[^>]*">"   { /* Ignore HTML tags */ }
[^<>\n]+      { yylval.strval = strdup(yytext); return TEXT; }
\n            { /* Ignore newlines */ }
.             { /* Ignore other characters */ }

%%

int yywrap() {
    return 1;
}

