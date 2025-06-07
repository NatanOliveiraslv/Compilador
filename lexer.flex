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

"="             { return new Symbol(sym.ATRIB, yytext()); }
"+"             { return new Symbol(sym.MAIS, yytext()); }
"-"             { return new Symbol(sym.MENOS, yytext()); }
"*"             { return new Symbol(sym.VEZES, yytext()); }
"("             { return new Symbol(sym.LPAREN, yytext()); }
")"             { return new Symbol(sym.RPAREN, yytext()); }
";"             { return new Symbol(sym.SEMI, yytext()); }
{id}            { return new Symbol(sym.ID, yytext()); }
{digit}+        { return new Symbol(sym.NUMERO, Integer.parseInt(yytext())); }
{whitespace}    { /* ignora espaços em branco */ }
.               { System.err.println("Caractere inválido: " + yytext()); }