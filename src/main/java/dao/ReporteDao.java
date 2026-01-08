package dao;


import java.sql.Date;

import entidades.Reportes;

public interface ReporteDao {
	public Reportes obtenerResumenPorCliente(String dniCliente, Date desde, Date hasta) throws Exception;
	public int obtenerTotalUsuarios();
	public int obtenerNuevosUsuarios(Date desde, Date hasta);

}
