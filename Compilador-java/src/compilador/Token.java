
package compilador;


public class Token {
    public String descripcion;
    public String valor;

    public Token(String descripcion, String valor) {
        this.descripcion = descripcion;
        this.valor = valor;
    }

    @Override
    public String toString() {
        return "\nToken{" + "descripcion=" + descripcion + ", valor=" + valor + '}';
    }
    
    
    
    
}
