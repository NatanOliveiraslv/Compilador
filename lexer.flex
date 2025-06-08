import java_cup.runtime.Symbol;

%%

%class FLexer
%unicode
%cup
%line
%char
%full
%eofval{
  return new Symbol(sym.EOF);
%eofval}

digit = [0-9]
letter = [a-zA-Z]
id = {letter}({letter}|{digit})*
whitespace = [ \t\r\n\f]+

%%

"tentaisso"           { return new Symbol(sym.TENTAISSO, yytext()); }
"mostraessamerda"     { return new Symbol(sym.MOSTRAESSAMERDA, yytext()); }
"=="                  { return new Symbol(sym.IGUAL, yytext()); }
"!="                  { return new Symbol(sym.DIFERENTE, yytext()); }
"<"                   { return new Symbol(sym.MENOR, yytext()); }
">"                   { return new Symbol(sym.MAIOR, yytext()); }
"="                   { return new Symbol(sym.ATRIB, yytext()); }
"+"                   { return new Symbol(sym.MAIS, yytext()); }
"-"                   { return new Symbol(sym.MENOS, yytext()); }
"*"                   { return new Symbol(sym.VEZES, yytext()); }
"["                   { return new Symbol(sym.LCOLCHETE, yytext()); }
"]"                   { return new Symbol(sym.RCOLCHETE, yytext()); }
"("                   { return new Symbol(sym.LPAREN, yytext()); }
")"                   { return new Symbol(sym.RPAREN, yytext()); }
";"                   { return new Symbol(sym.SEMI, yytext()); }
"verdade"             { return new Symbol(sym.TRUE, yytext()); }
"falsidade"           { return new Symbol(sym.FALSE, yytext()); }
{id}                  { return new Symbol(sym.ID, yytext()); }
{digit}+              { return new Symbol(sym.NUMERO, Integer.parseInt(yytext())); }
{whitespace}          { /* ignora espaços em branco */ }
.                     { System.err.println("Caractere inválido: " + yytext()); }