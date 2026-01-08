package daoImpl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.PrestamosDao;
import entidades.Cliente;
import entidades.Cuenta;
import entidades.Cuota;
import entidades.TipoPrestamo;
import entidades.Prestamos;

public class PrestamosDaoImpl implements PrestamosDao{
	private static final String listarPrestamos = "CALL listarPrestamosPendientes()";
	private static final String actualizarPrestamo = "CALL actualizarEstadoPrestamo(?, ?)";
	private static final String obtenerTiposPrestamo = "SELECT * FROM tipos_prestamo";
	private static final String agregarPrestamo = "CALL agregarPrestamo(?,?,?,?,?,?,?)";

	@Override
	// Este método crea un nuevo préstamo utilizando el procedimiento agregarPrestamo.
	public boolean crearPrestamo(Prestamos prestamo) {
	    String sql = agregarPrestamo;

	    try (Connection conn = Conexion.getSQLConexion();
	         CallableStatement stmt = conn.prepareCall(sql)) {

	        Date fechaActual = new Date(System.currentTimeMillis());
	        stmt.setInt(1, prestamo.getClienteId().getClienteId());
	        stmt.setInt(2, prestamo.getCuentaDestino());
	        stmt.setInt(3, prestamo.getTipo_prestamo_id().getTipo_prestamo_id());
	        stmt.setDate(4, fechaActual);
	        stmt.setDouble(5, prestamo.getMontoPedido());
	        stmt.setInt(6, prestamo.getNroCuotas());
	        stmt.setDouble(7, prestamo.getCuotaMensual());

	        stmt.execute();
	        conn.commit();
	        return true;

	    } catch (SQLException ex) {
	        ex.printStackTrace();
	        return false;
	    }
	}

	@Override
	// Este método actualiza el estado del préstamo según el ID ejecutando el sp.
	public boolean actualizarEstadoPrestamo(int id, String estado) {
	    String sql = actualizarPrestamo;

	    try (Connection conn = Conexion.getSQLConexion();
	         CallableStatement stmt = conn.prepareCall(sql)) {

	        stmt.setInt(1, id);
	        stmt.setString(2, estado);

	        stmt.execute();
	        conn.commit();
	        return true;

	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}

	@Override
	// Este método lista todos los préstamos pendientes usando un sp.
	public List<Prestamos> listarPrestamos() {
	    List<Prestamos> prestamos = new ArrayList<>();
	    String sql = listarPrestamos;

	    try (Connection conn = Conexion.getSQLConexion();
	         CallableStatement stmt = conn.prepareCall(sql);
	         ResultSet rs = stmt.executeQuery()) {

	        while (rs.next()) {
	            Cliente cli = new Cliente();
	            cli.setClienteId(rs.getInt("cliente_id"));
	            cli.setNombre(rs.getString("nombre_cliente"));
	            cli.setApellido(rs.getString("apellido_cliente"));

	            TipoPrestamo tp = new TipoPrestamo();
	            tp.setTipo_prestamo_id(rs.getInt("tipo_prestamo_id"));
	            tp.setDescripcion(rs.getString("tipo_prestamo"));
	            tp.setInteres_mensual(rs.getBigDecimal("interes_mensual"));

	            Prestamos p = new Prestamos();
	            p.setPrestamoId(rs.getInt("prestamo_id"));
	            p.setClienteId(cli);
	            p.setTipo_prestamo_id(tp);
	            p.setCuentaDestino(rs.getInt("cuenta_destino"));
	            p.setMontoPedido(rs.getDouble("monto_pedido"));
	            p.setNroCuotas(rs.getInt("nro_cuotas"));
	            p.setCuotaMensual(rs.getDouble("cuota_mensual"));
	            p.setSaldoRestante(rs.getDouble("saldo_restante"));
	            p.setCuotasPagas(rs.getInt("cuotas_pagas"));
	            p.setFecha(rs.getDate("fecha"));
	            p.setEstado(rs.getString("estado"));

	            prestamos.add(p);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return prestamos;
	}

	@Override
	// Este método obtiene una lista de préstamos pertenecientes a un cliente según su DNI.
	public List<Prestamos> listarPrestamosPorDni(String dni) {
	    List<Prestamos> lista = new ArrayList<>();

	    String sql = "SELECT p.prestamo_id, p.cliente_id AS p_cliente_id, p.cuenta_destino, " +
	                 "p.tipo_prestamo_id AS p_tipo_prestamo_id, p.fecha AS p_fecha, p.monto_pedido, " +
	                 "p.nro_cuotas, p.cuota_mensual, p.saldo_restante, p.cuotas_pagas, p.estado AS p_estado, " +
	                 "c.cliente_id AS c_cliente_id, c.nombre AS c_nombre, c.apellido AS c_apellido, c.dni AS c_dni, " +
	                 "tp.tipo_prestamo_id AS tp_id, tp.descripcion AS tp_descripcion, tp.interes_mensual AS tp_interes " +
	                 "FROM prestamos p " +
	                 "JOIN clientes c ON p.cliente_id = c.cliente_id " +
	                 "JOIN tipos_prestamo tp ON p.tipo_prestamo_id = tp.tipo_prestamo_id " +
	                 "WHERE c.dni = ?";

	    try (Connection conn = Conexion.getSQLConexion();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {

	        stmt.setString(1, dni);

	        try (ResultSet rs = stmt.executeQuery()) {
	            while (rs.next()) {
	                Cliente cli = new Cliente();
	                cli.setClienteId(rs.getInt("c_cliente_id"));
	                cli.setNombre(rs.getString("c_nombre"));
	                cli.setApellido(rs.getString("c_apellido"));
	                cli.setDni(rs.getString("c_dni"));

	                TipoPrestamo tp = new TipoPrestamo();
	                tp.setTipo_prestamo_id(rs.getInt("tp_id"));
	                tp.setDescripcion(rs.getString("tp_descripcion"));
	                tp.setInteres_mensual(rs.getBigDecimal("tp_interes"));

	                Prestamos p = new Prestamos();
	                p.setPrestamoId(rs.getInt("prestamo_id"));
	                p.setClienteId(cli);
	                p.setTipo_prestamo_id(tp);
	                p.setCuentaDestino(rs.getInt("cuenta_destino"));
	                p.setMontoPedido(rs.getDouble("monto_pedido"));
	                p.setNroCuotas(rs.getInt("nro_cuotas"));
	                p.setCuotaMensual(rs.getDouble("cuota_mensual"));
	                p.setSaldoRestante(rs.getDouble("saldo_restante"));
	                p.setCuotasPagas(rs.getInt("cuotas_pagas"));
	                p.setFecha(rs.getDate("p_fecha"));
	                p.setEstado(rs.getString("p_estado"));

	                lista.add(p);
	            }
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return lista;
	}

	@Override
	// Este método obtiene todos los tipos de préstamo disponibles desde la base de datos.
	public List<TipoPrestamo> obtenerTipoPrestamos() {
	    List<TipoPrestamo> tiposP = new ArrayList<>();

	    try (Connection conn = Conexion.getSQLConexion();
	         PreparedStatement statement = conn.prepareStatement(obtenerTiposPrestamo);
	         ResultSet resultSet = statement.executeQuery()) {

	        while (resultSet.next()) {
	            TipoPrestamo pres = new TipoPrestamo();
	            pres.setTipo_prestamo_id(resultSet.getInt("tipo_prestamo_id"));
	            pres.setDescripcion(resultSet.getString("descripcion"));
	            tiposP.add(pres);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return tiposP;
	}

	@Override
	// Este método obtiene préstamos por cliente usando un procedimiento almacenado.
	public List<Prestamos> obtenerPrestamosPorCliente(int clienteId) {
	    List<Prestamos> prestamos = new ArrayList<>();
	    String query = "CALL ListarPrestamosPorCliente(?)";

	    try (Connection conn = Conexion.getSQLConexion();
	         PreparedStatement ps = conn.prepareStatement(query)) {

	        ps.setInt(1, clienteId);

	        try (ResultSet rs = ps.executeQuery()) {
	            while (rs.next()) {
	                Prestamos p = new Prestamos();
	                p.setPrestamoId(rs.getInt("prestamo_id"));
	                p.setFecha(rs.getDate("fecha"));
	                p.setMontoPedido(rs.getDouble("monto_pedido"));
	                p.setNroCuotas(rs.getInt("nro_cuotas"));
	                p.setCuentaDestino(rs.getInt("cuenta_destino"));
	                p.setCuotaMensual(rs.getDouble("cuota_mensual"));
	                p.setSaldoRestante(rs.getDouble("saldo_restante"));
	                p.setCuotasPagas(rs.getInt("cuotas_pagas"));
	                p.setEstado(rs.getString("estado"));

	                Cliente c = new Cliente();
	                c.setClienteId(rs.getInt("cliente_id"));
	                p.setClienteId(c);

	                TipoPrestamo tp = new TipoPrestamo();
	                tp.setTipo_prestamo_id(rs.getInt("tipo_prestamo_id"));
	                p.setTipo_prestamo_id(tp);

	                prestamos.add(p);
	            }
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return prestamos;
	}
    
    
	// Obtiene todas las cuotas de un préstamo específico
	@Override
	public List<Cuota> obtenerCuotasPorPrestamo(int prestamoId) {
	    List<Cuota> cuotas = new ArrayList<>();
	    String query = "SELECT * FROM cuotas WHERE prestamo_id = ? ORDER BY numero_cuota ASC";

	    try (Connection conn = Conexion.getSQLConexion();
	         PreparedStatement ps = conn.prepareStatement(query)) {

	        ps.setInt(1, prestamoId);

	        try (ResultSet rs = ps.executeQuery()) {
	            while (rs.next()) {
	                Cuota c = new Cuota();
	                c.setCuotaId(rs.getInt("cuota_id"));
	                c.setNumeroCuota(rs.getInt("numero_cuota"));
	                c.setMonto(rs.getDouble("monto"));
	                c.setFechaVencimiento(rs.getDate("fecha_vencimiento"));
	                c.setFechaPago(rs.getDate("fecha_pago"));
	                c.setEstado(rs.getString("estado"));

	                Prestamos p = new Prestamos();
	                p.setPrestamoId(rs.getInt("prestamo_id"));

	                Cuenta cu = new Cuenta();
	                cu.setCuenta_id(rs.getInt("cuenta_id"));

	                c.setPrestamo(p);
	                c.setCuenta(cu);

	                cuotas.add(c);
	            }
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return cuotas;
	}

	// Busca un préstamo por su ID
	@Override
	public Prestamos obtenerPrestamoPorId(int id) {
	    Prestamos p = null;
	    String query = "SELECT * FROM prestamos WHERE prestamo_id = ?";

	    try (Connection conn = Conexion.getSQLConexion();
	         PreparedStatement ps = conn.prepareStatement(query)) {

	        ps.setInt(1, id);

	        try (ResultSet rs = ps.executeQuery()) {
	            if (rs.next()) {
	                p = new Prestamos();
	                p.setPrestamoId(rs.getInt("prestamo_id"));
	                p.setFecha(rs.getDate("fecha"));
	                p.setMontoPedido(rs.getDouble("monto_pedido"));
	                p.setNroCuotas(rs.getInt("nro_cuotas"));
	                p.setCuentaDestino(rs.getInt("cuenta_destino"));
	                p.setCuotaMensual(rs.getDouble("cuota_mensual"));
	                p.setSaldoRestante(rs.getDouble("saldo_restante"));
	                p.setCuotasPagas(rs.getInt("cuotas_pagas"));
	                p.setEstado(rs.getString("estado"));

	                Cliente c = new Cliente();
	                c.setClienteId(rs.getInt("cliente_id"));
	                p.setClienteId(c);

	                TipoPrestamo tp = new TipoPrestamo();
	                tp.setTipo_prestamo_id(rs.getInt("tipo_prestamo_id"));
	                p.setTipo_prestamo_id(tp);
	            }
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return p;
	}

	// Marca una cuota como pagada
	@Override
	public boolean pagarCuota(int cuotaId, int cuentaId) {
	    String sql = "{CALL PagarCuota(?, ?)}";

	    try (Connection conn = Conexion.getSQLConexion();
	         CallableStatement cs = conn.prepareCall(sql)) {

	        cs.setInt(1, cuotaId);
	        cs.setInt(2, cuentaId);

	        cs.execute();
	        return true;

	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}	
}
