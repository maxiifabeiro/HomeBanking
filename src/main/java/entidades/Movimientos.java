package entidades;


import java.math.BigDecimal;
import java.util.Date;

public class Movimientos {
	private int movimientoId;
    private Cuenta cuentaId;
    private java.util.Date fecha;
    private String detalle;
    private double importe;
    private BigDecimal saldo;
    private TipoMovimiento tipoMovimientoId;
    private Transferencia transferenciaId;
    
    public Movimientos() {
    	
    }
    
	public Movimientos(int movimientoId, Cuenta cuentaId, Date fecha, String detalle, double importe, BigDecimal saldo,
			TipoMovimiento tipoMovimientoId, Transferencia transferenciaId) {
		super();
		this.movimientoId = movimientoId;
		this.cuentaId = cuentaId;
		this.fecha = fecha;
		this.detalle = detalle;
		this.importe = importe;
		this.saldo = saldo;
		this.tipoMovimientoId = tipoMovimientoId;
		this.transferenciaId = transferenciaId;
	}

	public int getMovimientoId() {
		return movimientoId;
	}
	public void setMovimientoId(int movimientoId) {
		this.movimientoId = movimientoId;
	}
	public Cuenta getCuentaId() {
		return cuentaId;
	}
	public void setCuentaId(Cuenta cuentaId) {
		this.cuentaId = cuentaId;
	}
	public java.util.Date getFecha() {
		return fecha;
	}
	public void setFecha(java.util.Date fecha) {
		this.fecha = fecha;
	}
	public String getDetalle() {
		return detalle;
	}
	public void setDetalle(String detalle) {
		this.detalle = detalle;
	}
	public double getImporte() {
		return importe;
	}
	public void setImporte(double importe) {
		this.importe = importe;
	}
	public BigDecimal getSaldo() {
		return saldo;
	}

	public void setSaldo(BigDecimal saldo ) {
		this.saldo = saldo;
	}
	
	public TipoMovimiento getTipoMovimientoId() {
		return tipoMovimientoId;
	}
	public void setTipoMovimientoId(TipoMovimiento tipoMovimientoId) {
		this.tipoMovimientoId = tipoMovimientoId;
	}
	public Transferencia getTransferenciaId() {
		return transferenciaId;
	}
	public void setTransferenciaId(Transferencia transferenciaId) {
		this.transferenciaId = transferenciaId;
	}
    
    
}
