package entidades;

import java.math.BigDecimal;
import java.util.Date;

public class Transferencia {
	private int transferencia_id;
    private int cuenta_origen;
    private int cuenta_destino;
    private String aliasOrigen;
    private String aliasDestino;
	private Date fecha;
    private String detalle;
    private BigDecimal importe;
    private String estado;
    
    public Transferencia() {
    	
    }
    
	public Transferencia(int transferencia_id, int cuenta_origen, int cuenta_destino, String aliasOrigen, String aliasDestino, Date fecha, String detalle,
			BigDecimal importe, String estado) {
		super();
		this.transferencia_id = transferencia_id;
		this.cuenta_origen = cuenta_origen;
		this.cuenta_destino = cuenta_destino;
		this.aliasOrigen = aliasOrigen;
		this.aliasDestino = aliasDestino;
		this.fecha = fecha;
		this.detalle = detalle;
		this.importe = importe;
		this.estado = estado;
	}

	public int getTransferencia_id() {
		return transferencia_id;
	}

	public void setTransferencia_id(int transferencia_id) {
		this.transferencia_id = transferencia_id;
	}

	public int getCuenta_origen() {
		return cuenta_origen;
	}

	public void setCuenta_origen(int cuenta_origen) {
		this.cuenta_origen = cuenta_origen;
	}

	public int getCuenta_destino() {
		return cuenta_destino;
	}

	public void setCuenta_destino(int cuenta_destino) {
		this.cuenta_destino = cuenta_destino;
	}

    public String getAliasOrigen() {
		return aliasOrigen;
	}

	public void setAliasOrigen(String aliasOrigen) {
		this.aliasOrigen = aliasOrigen;
	}

	public String getAliasDestino() {
		return aliasDestino;
	}

	public void setAliasDestino(String aliasDestino) {
		this.aliasDestino = aliasDestino;
	}
	
	public Date getFecha() {
		return fecha;
	}

	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}

	public String getDetalle() {
		return detalle;
	}

	public void setDetalle(String detalle) {
		this.detalle = detalle;
	}

	public BigDecimal getImporte() {
		return importe;
	}

	public void setImporte(BigDecimal importe) {
		this.importe = importe;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}
    
    
}
