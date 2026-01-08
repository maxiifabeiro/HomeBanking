package Excepciones;

public class SaldoInsuficienteExcepcion extends Exception{
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public SaldoInsuficienteExcepcion(String mensaje) {
        super(mensaje);
    }
}
