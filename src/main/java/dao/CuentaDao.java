package dao;

import java.sql.SQLException;
import java.util.List;

import entidades.Cuenta;
import entidades.TipoCuenta;


public interface CuentaDao {
	public boolean agregarCuenta (Cuenta agregarCuenta)throws SQLException;
    public List<TipoCuenta> obtenerTipoCuenta();
    
    public List<Cuenta> obtenerCuentaPorDni(String dni);
    public List<Cuenta> obtenerCuentas();
    
	int obtenerClienteIdPorUsuario(int usuarioId) throws Exception;
	List<Cuenta> obtenerCuentasPorCliente(int clienteId) throws Exception;
	
	public boolean modificarCuenta(Cuenta cuenta);
	public Cuenta obtenerCuentaPorId(int id);
	
	public boolean eliminarCuenta(int cuentaId);
	
	//Esta es para obtener los movimientos de la cuenta
	public List<Cuenta> obtenerCuentasPorClienteMovimientos(int usuarioId);
	
	public List<Cuenta> obtenerCuentasPorUsuario(int usuarioId);

}
