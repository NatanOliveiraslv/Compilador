@echo off

echo Gerando o analisador léxico...
java -jar Jar\jflex-full-1.8.2.jar -d src lexer.flex

echo Gerando o analisador sintático...
java -jar Jar\java-cup-11b.jar -parser Parser -symbols sym -destdir src parser.cup

echo Compilando tudo...
javac -cp "Jar\java-cup-11b-runtime.jar;src" src\*.java

cls

echo Executando...
java -cp "Jar\java-cup-11b-runtime.jar;src" Compilador

pause

del src\*.class
del src\FLexer.java
del src\Parser.java
del src\sym.java
del src\FLexer.java~