# Compilador Bill

Este projeto é um compilador/interpreter simples desenvolvido em Java, utilizando JFlex para análise léxica e CUP para análise sintática. Ele interpreta uma linguagem fictícia com comandos personalizados, incluindo estruturas condicionais, laços (for e while), atribuição de variáveis, expressões aritméticas e impressão de valores.

---

## Gramática

A gramática utilizada pelo compilador Bill está definida em [parser.cup](parser.cup) e suporta comandos condicionais, laços, atribuições, expressões aritméticas e impressão. Veja as principais regras:

### Não Terminais

- `inicio`
- `estruturas`
- `logica`
- `print`
- `exp`
- `inteiro`
- `flutuante`
- `condicao`

### Regras Principais

```text
inicio ::= estruturas:e {: e.run(); :}

estruturas ::= logica
             | estruturas logica
             | exp SEMI
             | estruturas exp SEMI
             | print
             | estruturas print

logica ::= TENTAISSO ( condicao ) [ estruturas ]
         | TENTAISSO ( condicao ) [ estruturas ] SENAODERFAZISSO [ estruturas ]
         | REPETIDOR ( condicao ) [ estruturas ]           // laço while
         | REPETIDOR ( inteiro ) [ estruturas ]            // laço for

print ::= JOGANATELA ( exp ) ;
        | JOGANATELA ( STRING ) ;

exp ::= exp MAIS exp
     | exp MENOS exp
     | exp VEZES exp
     | MENOS exp
     | ( exp )
     | inteiro
     | flutuante
     | ID
     | ID ATRIB exp

inteiro ::= INT

flutuante ::= FLOAT

condicao ::= exp IGUAL exp
           | exp DIFERENTE exp
           | exp MENOR exp
           | exp MAIOR exp
           | TRUE
           | FALSE
```

**Observações:**
- O comando `repetidor` pode ser usado tanto como laço `for` (`repetidor(numero)[ ... ]`) quanto como laço `while` (`repetidor(condicao)[ ... ]`).
- Números inteiros e decimais são tratados separadamente como `inteiro` (`INT`) e `flutuante` (`FLOAT`).
- Atribuições e expressões aritméticas suportam variáveis, inteiros e decimais.
- O comando de impressão é `joganatela`.

---

## Tokens

Os tokens são definidos em [lexer.flex](lexer.flex):

| Token              | Lexema                |
|--------------------|----------------------|
| TENTAISSO          | `tentaisso`          |
| SENAODERFAZISSO    | `senaoderfazisso`    |
| REPETIDOR          | `repetidor`          |
| JOGANATELA         | `joganatela`         |
| IGUAL              | `==`                 |
| DIFERENTE          | `!=`                 |
| MENOR              | `<`                  |
| MAIOR              | `>`                  |
| ATRIB              | `=`                  |
| MAIS               | `+`                  |
| MENOS              | `-`                  |
| VEZES              | `*`                  |
| LCOLCHETE          | `[`                  |
| RCOLCHETE          | `]`                  |
| LPAREN             | `(`                  |
| RPAREN             | `)`                  |
| SEMI               | `;`                  |
| TRUE               | `verdade`            |
| FALSE              | `falsidade`          |
| ID                 | identificador        |
| INT                | número inteiro       |
| FLOAT              | número decimal       |
| STRING             | string entre aspas   |

---

## Como Executar

1. **Pré-requisitos:**  
   - Java instalado  
   - Os arquivos JAR do JFlex e CUP já estão na pasta `Jar/`

2. **Compilação e Execução:**  
   Execute o script `compila.bat` na raiz do projeto. Ele irá:
   - Gerar o analisador léxico (`FLexer.java`)
   - Gerar o analisador sintático (`Parser.java`, `sym.java`)
   - Compilar todos os arquivos `.java`
   - Executar o programa principal [`src/Compilador.java`](src/Compilador.java)

3. **Entrada:**  
   O código a ser analisado deve estar no arquivo [`codigo.txt`](codigo.txt).

4. **Saída:**  
   - Lista de tokens reconhecidos (análise léxica)
   - Execução do código (análise sintática e interpretação)

---

## Exemplo de Código de Entrada

Veja [`codigo.txt`](codigo.txt):

```txt
a = 3.5;
b = a + 5;
c = (b - 2) * 2;

tentaisso(falsidade)[
    joganatela("Ta no if:");
    joganatela(c);
]senaoderfazisso[
    joganatela("Ta no else:");
    joganatela(a);
]

repetidor(5)[
    joganatela("Ta no for");
]
```

---

## Observações

- O projeto limpa os arquivos gerados após a execução.
- Mensagens de erro são exibidas no console caso haja problemas léxicos ou sintáticos.
- Agora é possível utilizar números decimais nas expressões e comandos.
- O comando de repetição `repetidor` pode ser usado como laço `for` (com número) ou `while` (com condição).
- O comando de impressão foi renomeado para `joganatela`.