package daoImpl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import java.util.List;

import dao.ReporteDao;
import entidades.Cuenta;
import entidades.Movimientos;
import entidades.Reportes;
import entidades.TipoMovimiento;
import entidades.Transferencia;

public class ReporteDaoImpl implements ReporteDao{

	private static final String sqlTotal = "SELECT COUNT(*) AS total FROM cuentas";

	@Override
	// Este método genera un resumen de movimientos (cantidad, monto total y promedio) para un cliente dentro de un rango de fechas
	public Reportes obtenerResumenPorCliente(String dniCliente, Date desde, Date hasta) {
	    String sql = "SELECT COUNT(*) AS totalMovimientos, SUM(m.importe) AS montoTotal, AVG(m.importe) AS promedio " +
	                 "FROM movimientos m " +
	                 "INNER JOIN cuentas c ON m.cuenta_id = c.cuenta_id " +
	                 "INNER JOIN clientes cl ON c.cliente_id = cl.cliente_id " +
	                 "WHERE cl.dni = ? AND m.fecha BETWEEN ? AND ?";

	    Reportes rep = new Reportes();

	    try (Connection conn = Conexion.getSQLConexion();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {

	        stmt.setString(1, dniCliente);
	        stmt.setDate(2, desde);
	        stmt.setDate(3, hasta);

	        try (ResultSet rs = stmt.executeQuery()) {
	            if (rs.next()) {
	                rep.setTotalTransacciones(rs.getInt("totalMovimientos"));
	                rep.setMontoTotal(rs.getBigDecimal("montoTotal"));
	                rep.setPromedio(rs.getDouble("promedio"));
	            }
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return rep;
	}

	@Override
	// Este método devuelve la cantidad total de usuarios registrados en el sistema
	public int obtenerTotalUsuarios() {
	    int totalUsuarios = 0;

	    try (Connection conn = Conexion.getSQLConexion();
	         CallableStatement stmt = conn.prepareCall(sqlTotal);
	         ResultSet rs = stmt.executeQuery()) {

	        if (rs.next()) {
	            totalUsuarios = rs.getInt("total");
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return totalUsuarios;
	}

	@Override
	// Este método obtiene la cantidad de nuevos usuarios según una fecha de creación dentro de un rango
	public int obtenerNuevosUsuarios(Date desde, Date hasta) {
	    int nuevosUsuarios = 0;

	    String sql = "SELECT COUNT(*) AS total FROM cuentas WHERE fecha_creacion BETWEEN ? AND ?";

	    try (Connection conn = Conexion.getSQLConexion();
	         PreparedStatement ps = conn.prepareStatement(sql)) {

	        ps.setDate(1, desde);
	        ps.setDate(2, hasta);

	        try (ResultSet rs = ps.executeQuery()) {
	            if (rs.next()) {
	                nuevosUsuarios = rs.getInt("total");
	            }
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return nuevosUsuarios;
	}
	
}
