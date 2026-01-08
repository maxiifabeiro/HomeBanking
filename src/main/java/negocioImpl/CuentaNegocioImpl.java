package negocioImpl;

import java.sql.SQLException;
import java.util.List;
import java.util.Random;

import daoImpl.CuentaDaoImpl;
import entidades.Cuenta;
import entidades.TipoCuenta;
import negocio.CuentaNegocio;

public class CuentaNegocioImpl implements CuentaNegocio{
	private CuentaDaoImpl cDao = new CuentaDaoImpl();
	
	@Override
	public boolean agregarCuenta(Cuenta agregarCuenta)throws Exception {
		try{return cDao.agregarCuenta(agregarCuenta);
		}catch(SQLException ex){
			throw new Exception(ex.getMessage());
		}
	}

	@Override
	public List<TipoCuenta> obtenerTipoCuenta() {
		return cDao.obtenerTipoCuenta();
	}

	public String generarCBU() {
	    Random random = new Random();
	    StringBuilder cbu = new StringBuilder();

	    for (int i = 0; i < 22; i++) {
	        cbu.append(random.nextInt(10));
	    }

	    return cbu.toString();
	}


	public String generarAlias() {
        return  generarPalabra(6) + "." +
        		generarPalabra(6) + "." +
        		generarPalabra(6);
    }

    private String generarPalabra(int longitud) {
        String consonantes = "BCDFGHJKLMNPQRSTVWXYZ";
        String vocales = "AEIOU";
        Random random = new Random();
        StringBuilder palabra = new StringBuilder();

        for (int i = 0; i < longitud / 2; i++) {
            palabra.append(consonantes.charAt(random.nextInt(consonantes.length())));
            palabra.append(vocales.charAt(random.nextInt(vocales.length())));
        }

        return palabra.toString();
    }
    
	@Override
	public List<Cuenta> obtenerCuentaPorDni(String dni) {
		return cDao.obtenerCuentaPorDni(dni);
	}

	@Override
	public List<Cuenta> obtenerCuentas() {
		return cDao.obtenerCuentas();
	}
    
    
	@Override
	public int obtenerClientePorUsuario(int usuarioId) throws Exception {
		return cDao.obtenerClienteIdPorUsuario(usuarioId);
	}

	@Override
	public List<Cuenta> obtenerCuentasPorCliente(int clienteId) throws Exception {
		return cDao.obtenerCuentasPorCliente(clienteId);
	}
	
	public boolean modificarCuenta(Cuenta cuenta) {
        return cDao.modificarCuenta(cuenta);
	}
	
    public Cuenta obtenerCuentaPorId(int id) {
    	return cDao.obtenerCuentaPorId(id);
    }
    
	@Override
	public boolean eliminarCuenta(int cuentaId) {
		return cDao.eliminarCuenta(cuentaId);
	}

	@Override
	public List<Cuenta> obtenerCuentasPorClienteMovimientos(int usuarioId) {
		return cDao.obtenerCuentasPorClienteMovimientos(usuarioId);
	}

	@Override
	public List<Cuenta> obtenerCuentasPorUsuario(int usuarioId) {
		return cDao.obtenerCuentasPorUsuario(usuarioId);
	}
	
	
} 
