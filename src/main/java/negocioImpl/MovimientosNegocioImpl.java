package negocioImpl;

import java.sql.Date;
import java.util.List;

import daoImpl.MovimientosDaoImpl;
import entidades.Movimientos;
import entidades.TipoCuenta;
import negocio.MovimientosNegocio;

public class MovimientosNegocioImpl implements MovimientosNegocio{

private MovimientosDaoImpl mdao = new MovimientosDaoImpl();
	
	@Override
	public List<Movimientos> listarMovimientosPorFechas(Date desde, Date hasta, int nrocliente) {
		return mdao.listarMovimientosPorFechas(desde, hasta, nrocliente);
	}

	@Override
	public List<TipoCuenta> obtenerTipoCuenta() {
		return mdao.obtenerTipoCuenta();
	}

	@Override
	public List<Movimientos> listarMovimientosPorCliente(int usuarioId) {
		return mdao.listarMovimientosPorCliente(usuarioId);
	}

	@Override
	public List<Movimientos> obtenerMovimientos() {
		return mdao.obtenerMovimientos();
	}

	@Override
	public List<Movimientos> listarMovimientosPorCuenta(int cuentaId) {
		return mdao.listarMovimientosPorCuenta(cuentaId);
	}

}
