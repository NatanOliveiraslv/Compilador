# Compilador

Este projeto é um compilador simples desenvolvido em Java utilizando JFlex para análise léxica e CUP para análise sintática. Ele interpreta uma linguagem fictícia com comandos personalizados.

## Gramática

A gramática utilizada está definida em [parser.cup](parser.cup):

- **Comandos de controle:**  
  - `tentaisso(condicao)[ ... ] senaoderfazisso[ ... ]` (estrutura condicional tipo if-else)
- **Atribuição e expressões:**  
  - `a = 3;`
  - `b = a + 5;`
  - `c = (b - 2) * 2;`
- **Impressão:**  
  - `mostraessamerda("texto");`
  - `mostraessamerda(variavel);`

### Não Terminais

- `inicio`
- `estruturas`
- `logica`
- `print`
- `exp`
- `condicao`

### Regras Principais

```text
inicio ::= estruturas:e {: e.run(); :}

estruturas ::= logica | estruturas logica | exp SEMI | estruturas exp SEMI | print | estruturas print

logica ::= TENTAISSO ( condicao ) [ estruturas ] 
         | TENTAISSO ( condicao ) [ estruturas ] SENAODERFAZISSO [ estruturas ]

print ::= MOSTRAESSAMERDA ( exp ) ;
        | MOSTRAESSAMERDA ( STRING ) ;

exp ::= exp MAIS exp
     | exp MENOS exp
     | exp VEZES exp
     | MENOS exp
     | ( exp )
     | INT
     | FLOAT
     | ID
     | ID ATRIB exp

condicao ::= exp IGUAL exp
           | exp DIFERENTE exp
           | exp MENOR exp
           | exp MAIOR exp
           | TRUE
           | FALSE
```

## Tokens

Os tokens são definidos em [lexer.flex](lexer.flex):

| Token              | Lexema                |
|--------------------|----------------------|
| TENTAISSO          | `tentaisso`          |
| SENAODERFAZISSO    | `senaoderfazisso`    |
| MOSTRAESSAMERDA    | `mostraessamerda`    |
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
| Float              | número flutuante     | 
| STRING             | string entre aspas   |

## Como Executar

1. **Pré-requisitos:**  
   - Java instalado  
   - Os arquivos JAR do JFlex e CUP já estão na pasta `Jar/`

2. **Compilação e Execução:**  
   Basta rodar o script `compila.bat` na raiz do projeto. Ele irá:
   - Gerar o analisador léxico (`FLexer.java`)
   - Gerar o analisador sintático (`Parser.java`, `sym.java`)
   - Compilar todos os arquivos `.java`
   - Executar o programa principal [`src/Compilador.java`](src/Compilador.java)

3. **Entrada:**  
   O código a ser analisado deve estar no arquivo [`codigo.txt`](codigo.txt).

4. **Saída:**  
   - Lista de tokens reconhecidos (análise léxica)
   - Execução do código (análise sintática e interpretação)

## Exemplo de Código de Entrada

Veja [`codigo.txt`](codigo.txt):

```txt
a = 3.5;
b = a + 5;
c = (b - 2) * 2;

tentaisso(falsidade)[
    mostraessamerda("Ta no if:");
    mostraessamerda(c);
]senaoderfazisso[
    mostraessamerda("Ta no else:");
    mostraessamerda(a);
]
```

## Observações

- O projeto limpa os arquivos gerados após a execução.
- Mensagens de erro são exibidas no console caso haja problemas léxicos ou sintáticos.

---