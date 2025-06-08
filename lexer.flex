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

int = [0-9]+
float = ([0-9]+)\.([0-9]+)
letter = [a-zA-Z]
id = {letter}({letter}|{int})*
whitespace = [ \t\r\n\f]+
string = \"([^\"\\]|\\.)*\"

%%

"tentaisso"           { return new Symbol(sym.TENTAISSO, yytext()); }
"senaoderfazisso"     { return new Symbol(sym.SENAODERFAZISSO, yytext()); }
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

{float}               { return new Symbol(sym.FLOAT, Double.parseDouble(yytext())); }
{int}                 { return new Symbol(sym.INT, Integer.parseInt(yytext())); }
{id}                  { return new Symbol(sym.ID, yytext()); }
{string}              { String texto = yytext().substring(1, yytext().length()-1); return new Symbol(sym.STRING, texto); }
{whitespace}          { /* ignora espaços */ }

.                     { System.err.println("Caractere inválido: " + yytext()); }