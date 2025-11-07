%{
#include <stdio.h>
#include <stdlib.h>

int line_number = 1;

/* Function to print tokens with line number and type */
void print_token(const char *token_type, const char *lexeme) {
    printf("Line %d: %s → %s\n", line_number, token_type, lexeme);
}

/* Function to report errors */
void report_error(const char *lexeme) {
    printf("Line %d: ERROR → %s (invalid token)\n", line_number, lexeme);
}
%}

%option noyywrap

/* Regular Expression Definitions */
DIGIT           [0-9]
LETTER          [a-zA-Z]
UNDERSCORE      [_]
ID              {LETTER}{LETTER}|{DIGIT}|{UNDERSCORE}*
FLOAT           {DIGIT}+\.{DIGIT}{1,2}
INTEGER         {DIGIT}+
WHITESPACE      [ \t]
NEWLINE         \n

/* Keyword List (15 unique trading-domain keywords) */
strategy        strategy
asset           asset
when            when
otherwise       otherwise
monitor         monitor
buy             buy
sell            sell
hold            hold
stop_loss       stop_loss
take_profit     take_profit
log             log
get_price       get_price
get_volume      get_volume
portfolio       portfolio
shares          shares

/* Operator Symbols */
ASSIGN          =
GREATER         >
LESS            <
MULTIPLY        \*
PLUS            \+

/* Punctuation Symbols */
SEMICOLON       ;
LPAREN          \(
RPAREN          \)
LBRACE          \{
RBRACE          \}
QUOTE           \"

%%

{NEWLINE}           { line_number++; }
{WHITESPACE}        { /* Skip whitespace */ }

{strategy}          { print_token("KEYWORD", yytext); }
{asset}             { print_token("KEYWORD", yytext); }
{when}              { print_token("KEYWORD", yytext); }
{otherwise}         { print_token("KEYWORD", yytext); }
{monitor}           { print_token("KEYWORD", yytext); }
{buy}               { print_token("KEYWORD", yytext); }
{sell}              { print_token("KEYWORD", yytext); }
{hold}              { print_token("KEYWORD", yytext); }
{stop_loss}         { print_token("KEYWORD", yytext); }
{take_profit}       { print_token("KEYWORD", yytext); }
{log}               { print_token("KEYWORD", yytext); }
{get_price}         { print_token("KEYWORD", yytext); }
{get_volume}        { print_token("KEYWORD", yytext); }
{portfolio}         { print_token("KEYWORD", yytext); }
{shares}            { print_token("KEYWORD", yytext); }

{FLOAT}             { print_token("FLOAT", yytext); }
{INTEGER}           { print_token("INTEGER", yytext); }

{ASSIGN}            { print_token("OPERATOR", yytext); }
{GREATER}           { print_token("OPERATOR", yytext); }
{LESS}              { print_token("OPERATOR", yytext); }
{MULTIPLY}          { print_token("OPERATOR", yytext); }
{PLUS}              { print_token("OPERATOR", yytext); }

{SEMICOLON}         { print_token("PUNCTUATION", yytext); }
{LPAREN}            { print_token("PUNCTUATION", yytext); }
{RPAREN}            { print_token("PUNCTUATION", yytext); }
{LBRACE}            { print_token("PUNCTUATION", yytext); }
{RBRACE}            { print_token("PUNCTUATION", yytext); }

\"[^"]*\"           { print_token("STRING", yytext); }

{ID}                { print_token("IDENTIFIER", yytext); }

.                   { report_error(yytext); }

%%

int main(int argc, char *argv[]) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror("Error opening file");
            return 1;
        }
    }
    
    yylex();
    return 0;
}
