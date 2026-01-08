package entidades;

import java.sql.Date;

public class Cuota {
	private int cuotaId;
    private Prestamos prestamo;
    private Cuenta cuenta;
    private int numeroCuota;
    private double monto;
    private Date fechaVencimiento;
    private Date fechaPago;
    private String estado;
    
    
    public Cuota() {
    	
    }
	public Cuota(int cuotaId, Prestamos prestamo, Cuenta cuenta, int numeroCuota, double monto, Date fechaVencimiento,
			Date fechaPago, String estado) {
		super();
		this.cuotaId = cuotaId;
		this.prestamo = prestamo;
		this.cuenta = cuenta;
		this.numeroCuota = numeroCuota;
		this.monto = monto;
		this.fechaVencimiento = fechaVencimiento;
		this.fechaPago = fechaPago;
		this.estado = estado;
	}
	public int getCuotaId() {
		return cuotaId;
	}
	public void setCuotaId(int cuotaId) {
		this.cuotaId = cuotaId;
	}
	public Prestamos getPrestamo() {
		return prestamo;
	}
	public void setPrestamo(Prestamos prestamo) {
		this.prestamo = prestamo;
	}
	public Cuenta getCuenta() {
		return cuenta;
	}
	public void setCuenta(Cuenta cuenta) {
		this.cuenta = cuenta;
	}
	public int getNumeroCuota() {
		return numeroCuota;
	}
	public void setNumeroCuota(int numeroCuota) {
		this.numeroCuota = numeroCuota;
	}
	public double getMonto() {
		return monto;
	}
	public void setMonto(double monto) {
		this.monto = monto;
	}
	public Date getFechaVencimiento() {
		return fechaVencimiento;
	}
	public void setFechaVencimiento(Date fechaVencimiento) {
		this.fechaVencimiento = fechaVencimiento;
	}
	public Date getFechaPago() {
		return fechaPago;
	}
	public void setFechaPago(Date fechaPago) {
		this.fechaPago = fechaPago;
	}
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
}
