package negocio;

import java.util.List;

import entidades.Cuenta;
import entidades.TipoCuenta;

public interface CuentaNegocio {
	public boolean agregarCuenta(Cuenta agregarCuenta)throws Exception;
    public List<TipoCuenta> obtenerTipoCuenta();
    public String generarAlias();
    public String generarCBU();
    
    public List<Cuenta> obtenerCuentaPorDni(String dni);
    public List<Cuenta> obtenerCuentas();
    
	public int obtenerClientePorUsuario(int usuarioId) throws Exception;
	public List<Cuenta> obtenerCuentasPorCliente(int clienteId) throws Exception;
	
	public boolean modificarCuenta(Cuenta cuenta);
	public Cuenta obtenerCuentaPorId(int id);
	
	public boolean eliminarCuenta(int cuentaId);
	
	public List<Cuenta> obtenerCuentasPorUsuario(int usuarioId);
	
	public List<Cuenta> obtenerCuentasPorClienteMovimientos(int usuarioId);
}
