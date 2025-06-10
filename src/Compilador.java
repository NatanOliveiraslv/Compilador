import java.io.FileReader;
import java.io.StringReader;
import java.nio.file.Files;
import java.nio.file.Paths;
import java_cup.runtime.Symbol;

public class Compilador {
    public static void main(String[] args) {
        try {
            // Lê o conteúdo do arquivo como String
            String codigo = new String(Files.readAllBytes(Paths.get("codigo.txt")));

            // ---------- Análise Léxica ----------
            System.out.println("Análise Léxica: Lista de Tokens:");
            FLexer lexer = new FLexer(new StringReader(codigo));
            Symbol s = lexer.next_token();
            while (s.sym != 0) {
                System.out.printf("<%d, %s>\n", s.sym, s.value);
                s = lexer.next_token();
            }

            // ---------- Resultado  ------------
            System.out.println("\nResultado:\n");
            FLexer scanner = new FLexer(new StringReader(codigo));
            Parser parser = new Parser(scanner);        
            parser.parse();

        } catch (Exception e) {
            System.out.println("Erro: " + e.getMessage());
        }
    }
}
