package entidades;

import java.util.Date;
import java.math.BigDecimal;

public class Cuenta {
    private int cuenta_id;
    private String cbu;
    private Cliente cliente;
    private Date fecha_creacion;
    private String alias;
    private TipoCuenta tipoCuenta;
    private BigDecimal saldo;
    private String dni;

    public Cuenta() {
    }

    public Cuenta(int cuenta_id, String cbu, Cliente cliente, Date fecha_creacion,
                  String alias, TipoCuenta tipoCuenta, BigDecimal saldo,String _dni) {
        this.cuenta_id = cuenta_id;
        this.cbu = cbu;
        this.cliente = cliente;
        this.fecha_creacion = fecha_creacion;
        this.alias = alias;
        this.tipoCuenta = tipoCuenta;
        this.saldo = saldo;
        this.dni = _dni;
    }

    public int getCuenta_id() {
        return cuenta_id;
    }

    public void setCuenta_id(int cuenta_id) {
        this.cuenta_id = cuenta_id;
    }

    public String getCbu() {
        return cbu;
    }

    public void setCbu(String cbu) {
        this.cbu = cbu;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public Date getFecha_creacion() {
        return fecha_creacion;
    }

    public void setFecha_creacion(Date fecha_creacion) {
        this.fecha_creacion = fecha_creacion;
    }

    public String getAlias() {
        return alias;
    }

    public void setAlias(String alias) {
        this.alias = alias;
    }

    public TipoCuenta getTipoCuenta() {
        return tipoCuenta;
    }

    public void setTipoCuenta(TipoCuenta tipoCuenta) {
        this.tipoCuenta = tipoCuenta;
    }

    public BigDecimal getSaldo() {
        return saldo;
    }

    public void setSaldo(BigDecimal saldo) {
        this.saldo = saldo;
    }

	public String getDni() {
		return dni;
	}

	public void setDni(String dni) {
		this.dni = dni;
	}
    
}
