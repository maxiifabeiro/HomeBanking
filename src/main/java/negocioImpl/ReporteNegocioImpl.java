package negocioImpl;

import java.sql.Date;
import java.util.List;

import daoImpl.ReporteDaoImpl;
import entidades.Movimientos;
import entidades.Reportes;
import negocio.ReporteNegocio;

public class ReporteNegocioImpl implements ReporteNegocio{
	private ReporteDaoImpl rd = new ReporteDaoImpl();
	@Override
	public Reportes obtenerResumen(String dni, Date desde, Date hasta) throws Exception {
		return rd.obtenerResumenPorCliente(dni, desde, hasta);
	}


	@Override
	public int obtenerTotalUsuarios() {
		return rd.obtenerTotalUsuarios();
	}

	@Override
	public int obtenerNuevosUsuarios(Date desde, Date hasta) {
		return rd.obtenerNuevosUsuarios(desde, hasta);
	}

}
