# Compilador Bill

Este projeto é um compilador/interpreter simples desenvolvido em Java, utilizando JFlex para análise léxica e CUP para análise sintática. Ele interpreta uma linguagem fictícia com comandos personalizados, incluindo estruturas condicionais, laços e impressão de valores.

---

## Gramática

A gramática está definida em [parser.cup](parser.cup):

- **Comandos de controle:**  
  - `tentaisso(condicao)[ ... ] senaoderfazisso[ ... ]` (estrutura condicional tipo if-else)
  - `repetidor(numero)[ ... ]` (estrutura de repetição tipo for)
- **Atribuição e expressões:**  
  - `a = 3.5;`
  - `b = a + 5;`
  - `c = (b - 2) * 2;`
- **Impressão:**  
  - `joganatela("texto");`
  - `joganatela(variavel);`

### Não Terminais

- `inicio`
- `estruturas`
- `logica`
- `repeticao`
- `print`
- `exp`
- `condicao`

### Regras Principais

```text
inicio ::= estruturas:e {: e.run(); :}

estruturas ::= logica
             | estruturas logica
             | repeticao
             | estruturas repeticao
             | exp SEMI
             | estruturas exp SEMI
             | print
             | estruturas print

logica ::= TENTAISSO ( condicao ) [ estruturas ]
         | TENTAISSO ( condicao ) [ estruturas ] SENAODERFAZISSO [ estruturas ]

repeticao ::= REPETIDOR ( exp ) [ estruturas ]

print ::= JOGANATELA ( exp ) ;
        | JOGANATELA ( STRING ) ;

exp ::= exp MAIS exp
     | exp MENOS exp
     | exp VEZES exp
     | MENOS exp
     | ( exp )
     | NUMERO
     | ID
     | ID ATRIB exp

condicao ::= exp IGUAL exp
           | exp DIFERENTE exp
           | exp MENOR exp
           | exp MAIOR exp
           | TRUE
           | FALSE
```

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
| NUMERO             | número inteiro ou decimal |
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
- O comando de repetição `repetidor` foi adicionado, permitindo executar blocos múltiplas vezes.
- O comando de impressão foi renomeado para `joganatela`.

---