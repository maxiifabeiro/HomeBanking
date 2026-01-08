package entidades;

import java.sql.Date;

public class Prestamos {
	private int prestamoId;
	private Cliente clienteId;
	private TipoPrestamo tipo_prestamo_id;
	private String nombreCliente;
	private String apellidoCliente;
	private int cuentaDestino;
	private double montoPedido;
	private int nroCuotas;
	private double cuotaMensual;
	private double saldoRestante;
	private int cuotasPagas;
	private Date fecha;
	private String estado;
	public Prestamos() { }
	public Prestamos(int prestamoId, Cliente clienteId, TipoPrestamo tipo_prestamo_id, String nombreCliente, String apellidoCliente, int cuentaDestino,
			double montoPedido, int nroCuotas, double cuotaMensual, double saldoRestante, int cuotasPagas, Date fecha, String estado){
			super();
			this.prestamoId = prestamoId;
			this.clienteId = clienteId;
			this.tipo_prestamo_id = tipo_prestamo_id;
			this.nombreCliente = nombreCliente;
			this.apellidoCliente = apellidoCliente;
			this.cuentaDestino = cuentaDestino;
			this.montoPedido = montoPedido;
			this.nroCuotas = nroCuotas; 
			this.cuotaMensual = cuotaMensual;
			this.saldoRestante = saldoRestante;
			this.cuotasPagas = cuotasPagas; 
			this.fecha = fecha;
			this.estado = estado;
			} 
	
	public int getPrestamoId() { 
		return prestamoId; 
	}
	public void setPrestamoId(int prestamoId) {
		this.prestamoId = prestamoId; 
	}
	public Cliente getClienteId() { 
		return clienteId; 
	} 
	public void setClienteId(Cliente clienteId) { 
		this.clienteId = clienteId; 
	} 
	public TipoPrestamo getTipo_prestamo_id() { 
		return tipo_prestamo_id; 
	} 
	public void setTipo_prestamo_id(TipoPrestamo tipo_prestamo_id) {
		this.tipo_prestamo_id = tipo_prestamo_id; 
	} 
	public String getNombreCliente() { 
		return nombreCliente; 
	}
	public void setNombreCliente(String nombreCliente) { 
		this.nombreCliente = nombreCliente; 
	} 
	public String getApellidoCliente() {
		return apellidoCliente; 
	} 
	public void setApellidoCliente(String apellidoCliente) {
		this.apellidoCliente = apellidoCliente; 
	} 
	public int getCuentaDestino() { 
		return cuentaDestino; 
	} 
	public void setCuentaDestino(int cuentaDestino) {
		this.cuentaDestino = cuentaDestino; 
	} 
	public double getMontoPedido() { 
		return montoPedido; 
	} 
	public void setMontoPedido(double montoPedido) {
		this.montoPedido = montoPedido; 
	} 
	public int getNroCuotas() { 
		return nroCuotas; 
	} 
	public void setNroCuotas(int nroCuotas) {
		this.nroCuotas = nroCuotas; 
	} 
	public double getCuotaMensual() { 
		return cuotaMensual; 
	} 
	public void setCuotaMensual(double cuotaMensual) { 
		this.cuotaMensual = cuotaMensual; 
	} 
	public double getSaldoRestante() { 
		return saldoRestante; 
	} 
	public void setSaldoRestante(double saldoRestante) { 
		this.saldoRestante = saldoRestante; 
	} 
	public int getCuotasPagas() { 
		return cuotasPagas; 
	} 
	public void setCuotasPagas(int cuotasPagas) { 
		this.cuotasPagas = cuotasPagas; 
	} 
	public Date getFecha() {
		return fecha;
	} 
	public void setFecha(Date fecha) {
		this.fecha = fecha; 
	} 
	public String getEstado() { 
		return estado; 
	} 
	public void setEstado(String estado) { 
		this.estado = estado;
	}
}
