package entidades;

import java.math.BigDecimal;

public class Reportes {
	private int totalTransacciones;
    private BigDecimal montoTotal;
    private double promedio;
    
    public Reportes() {
    	
    }
    
	public int getTotalTransacciones() {
		return totalTransacciones;
	}
	public void setTotalTransacciones(int totalTransacciones) {
		this.totalTransacciones = totalTransacciones;
	}
	public BigDecimal getMontoTotal() {
		return montoTotal;
	}
	public void setMontoTotal(BigDecimal montoTotal) {
		this.montoTotal = montoTotal;
	}
	public double getPromedio() {
		return promedio;
	}
	public void setPromedio(double promedio) {
		this.promedio = promedio;
	}
    
}
