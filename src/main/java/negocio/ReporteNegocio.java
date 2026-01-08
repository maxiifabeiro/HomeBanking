package negocio;


import java.sql.Date;
import java.util.List;

import entidades.Movimientos;
import entidades.Reportes;

public interface ReporteNegocio {
	Reportes obtenerResumen(String dni, Date desde, Date hasta)throws Exception;
	public int obtenerTotalUsuarios();
	public int obtenerNuevosUsuarios(Date desde, Date hasta);
}
