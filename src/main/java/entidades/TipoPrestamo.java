package entidades;

import java.math.BigDecimal;

public class TipoPrestamo {
	private int tipo_prestamo_id;
	private String descripcion;
	private BigDecimal interes_mensual;
	
	public TipoPrestamo(){
		
	}

	public TipoPrestamo(int tipo_prestamo_id, String descripcion, BigDecimal impinteres_mensual) {
		super();
		this.tipo_prestamo_id = tipo_prestamo_id;
		this.descripcion = descripcion;
		this.interes_mensual = impinteres_mensual;
	}

	public int getTipo_prestamo_id() {
		return tipo_prestamo_id;
	}

	public void setTipo_prestamo_id(int tipo_prestamo_id) {
		this.tipo_prestamo_id = tipo_prestamo_id;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public BigDecimal getInteres_mensual() {
		return interes_mensual;
	}

	public void setInteres_mensual(BigDecimal impinteres_mensual) {
		this.interes_mensual = impinteres_mensual;
	}
	
}
