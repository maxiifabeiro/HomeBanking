package negocio;

import java.sql.Date;
import java.util.List;

import entidades.Movimientos;
import entidades.TipoCuenta;

public interface MovimientosNegocio {
	public List<Movimientos> obtenerMovimientos();
	public List<Movimientos> listarMovimientosPorFechas(Date desde, Date hasta, int nrocliente);
	public List<Movimientos> listarMovimientosPorCliente(int usuarioId);
	public List<Movimientos> listarMovimientosPorCuenta(int cuentaId);
	public List<TipoCuenta> obtenerTipoCuenta();
}
