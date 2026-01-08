package entidades;

public class TipoCuenta {
	private int tipoCuenta_id;
	private String descripcion;
	
	public TipoCuenta() {
		
	}
	
	public TipoCuenta(int tipoC, String desc) {
	    this.tipoCuenta_id = tipoC;
	    this.descripcion = desc;
	}


	public int getTipoCuenta_id() {
		return tipoCuenta_id;
	}

	public void setTipoCuenta_id(int tipoCuenta_id) {
		this.tipoCuenta_id = tipoCuenta_id;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	
}
