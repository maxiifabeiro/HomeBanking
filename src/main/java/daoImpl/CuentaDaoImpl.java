package daoImpl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.CuentaDao;
import entidades.Cliente;
import entidades.Cuenta;
import entidades.TipoCuenta;

public class CuentaDaoImpl implements CuentaDao{
	private static final String agregarCuenta = "CALL AltaCuenta(?,?,?,?,?,?)";
	private static final String eliminarCuenta = "CALL BajaCuenta(?)";
	private static final String modificarCuenta = "CALL ModificarCuenta(?,?,?,?,?,?)";
	private static final String obtenerCuentas = "CALL listarCuentas()";
	private static final String obtenerCuentaPorDni = "CALL listarCuentaPorDni(?)";
	private static final String obtenerTipoCuenta = "SELECT * FROM tipos_cuentas";
	private static final String obtenerCuentaPorId = "CALL ObtenerCuentaPorId(?)";	
	private static final String cuentasPorCliente =
		    "SELECT c.cuenta_id, c.alias, c.cbu, c.saldo, " +
		    "c.tipocuentas_id AS tipoCuenta_id, " +
		    "t.descripcion AS descripcion_tipo " +
		    "FROM cuentas c " +
		    "JOIN tipos_cuentas t ON c.tipocuentas_id = t.tipocuentas_id " +
		    "JOIN clientes cl ON c.cliente_id = cl.cliente_id " +
		    "WHERE cl.usuario_id = ? AND c.estado = 1";

	
	// METODOS PARA ABML CUENTAS

	@Override
	// Este método agrega una nueva cuenta en la base de datos mediante un procedimiento almacenado.
	public boolean agregarCuenta(Cuenta cuenta) throws SQLException {
	    Connection conn = null;
	    CallableStatement stmt = null;

	    try {
	        conn = Conexion.getSQLConexion();
	        stmt = conn.prepareCall(agregarCuenta);

	        stmt.setString(1, cuenta.getCbu());
	        stmt.setInt(2, cuenta.getCliente().getClienteId());
	        stmt.setDate(3, new java.sql.Date(cuenta.getFecha_creacion().getTime()));
	        stmt.setString(4, cuenta.getAlias());
	        stmt.setInt(5, cuenta.getTipoCuenta().getTipoCuenta_id());
	        stmt.setBigDecimal(6, cuenta.getSaldo());

	        stmt.execute();
	        conn.commit();
	        return true;

	    } catch (SQLException ex) {
	        throw ex;
	    }
	}

	@Override
	// Este método elimina una cuenta mediante su ID usando un procedimiento almacenado.
	public boolean eliminarCuenta(int cuentaId) {
	    try (Connection conn = Conexion.getSQLConexion();
	         CallableStatement stmt = conn.prepareCall(eliminarCuenta)) {

	        stmt.setInt(1, cuentaId);
	        stmt.execute();
	        conn.commit();
	        return true;

	    } catch (SQLException e) {
	        e.printStackTrace();
	        try {
	            // rollback si algo falla
	            Connection conn = Conexion.getSQLConexion();
	            if (conn != null) conn.rollback();
	        } catch (SQLException ex) {
	            ex.printStackTrace();
	        }
	        return false;
	    }
	}
	
	// Este método modifica los datos de una cuenta existente mediante un procedimiento almacenado.
		public boolean modificarCuenta(Cuenta cuenta) {
		    Connection conn = null;
		    CallableStatement stmt = null;

		    try {
		        conn = Conexion.getSQLConexion();
		        stmt = conn.prepareCall(modificarCuenta);

		        stmt.setInt(1, cuenta.getCuenta_id());
		        stmt.setString(2, cuenta.getCbu());
		        stmt.setString(3, cuenta.getAlias());
		        stmt.setInt(4, cuenta.getTipoCuenta().getTipoCuenta_id());
		        stmt.setBigDecimal(5, cuenta.getSaldo());
		        stmt.setDate(6, new java.sql.Date(cuenta.getFecha_creacion().getTime()));

		        stmt.executeUpdate();
		        conn.commit();
		        return true;

		    } catch (SQLException e) {
		        e.printStackTrace();
		        return false;
		    }
	}
	
	
	@Override
	// Este método obtiene todas las cuentas asociadas a un DNI determinado.
	public List<Cuenta> obtenerCuentaPorDni(String dni) {
	    Connection conn = null;
	    CallableStatement stmt = null;
	    List<Cuenta> Listcuentas = new ArrayList<>();

	    try {
	        conn = Conexion.getSQLConexion();
	        stmt = conn.prepareCall(obtenerCuentaPorDni);
	        stmt.setString(1, dni);

	        ResultSet rs = stmt.executeQuery();

	        while (rs.next()) {
	            Cuenta cuentas = new Cuenta();

	            cuentas.setCuenta_id(rs.getInt("cuenta_id"));
	            cuentas.setCbu(rs.getString("cbu"));

	            Cliente cliente = new Cliente();
	            cliente.setNombre(rs.getString("nombre"));
	            cliente.setApellido(rs.getString("apellido"));
	            cliente.setDni(rs.getString("dni"));
	            cuentas.setCliente(cliente);

	            cuentas.setSaldo(rs.getBigDecimal("saldo"));

	            TipoCuenta tipoCuenta = new TipoCuenta();
	            tipoCuenta.setDescripcion(rs.getString("descripcion"));
	            cuentas.setTipoCuenta(tipoCuenta);

	            Listcuentas.add(cuentas);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return Listcuentas;
	}

	// Este método obtiene todas las cuentas existentes en la base de datos.
	@Override
	public List<Cuenta> obtenerCuentas() {
	    Connection conn = null;
	    CallableStatement stmt = null;
	    List<Cuenta> Listcuentas = new ArrayList<>();

	    try {
	        conn = Conexion.getSQLConexion();
	        stmt = conn.prepareCall(obtenerCuentas);
	        ResultSet rs = stmt.executeQuery();

	        while (rs.next()) {
	            Cuenta cuentas = new Cuenta();

	            cuentas.setCbu(rs.getString("cbu"));

	            Cliente cliente = new Cliente();
	            cliente.setNombre(rs.getString("nombre"));
	            cliente.setApellido(rs.getString("apellido"));
	            cliente.setDni(rs.getString("dni"));
	            cuentas.setCliente(cliente);

	            cuentas.setSaldo(rs.getBigDecimal("saldo"));

	            TipoCuenta tipoCuenta = new TipoCuenta();
	            tipoCuenta.setDescripcion(rs.getString("descripcion"));
	            cuentas.setTipoCuenta(tipoCuenta);

	            Listcuentas.add(cuentas);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return Listcuentas;
	}
	
	// Este método obtiene la lista de tipos de cuenta disponibles en la base de datos.
	@Override
	public List<TipoCuenta> obtenerTipoCuenta() {
	    List<TipoCuenta> tipoCuentas = new ArrayList<>();

	    try (Connection conn = Conexion.getSQLConexion();
	         PreparedStatement statement = conn.prepareStatement(obtenerTipoCuenta);
	         ResultSet resultSet = statement.executeQuery()) {

	        while (resultSet.next()) {
	            TipoCuenta tipos = new TipoCuenta();
	            tipos.setTipoCuenta_id(resultSet.getInt("tipocuentas_id"));
	            tipos.setDescripcion(resultSet.getString("descripcion"));
	            tipoCuentas.add(tipos);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return tipoCuentas;
	}



	// METODOS PARA TRANSFERENCIAS

	@Override
	// Este método obtiene el ID de cliente asociado a un usuario dado.
	public int obtenerClienteIdPorUsuario(int usuarioId) throws Exception {
	    int clienteId = -1;
	    PreparedStatement st = null;
	    ResultSet rs = null;

	    try {
	        Connection cn = Conexion.getSQLConexion();
	        st = cn.prepareStatement("SELECT cliente_id FROM clientes WHERE usuario_id = ?");
	        st.setInt(1, usuarioId);

	        rs = st.executeQuery();
	        if (rs.next()) {
	            clienteId = rs.getInt("cliente_id");
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return clienteId;
	}

	@Override
	// Este método obtiene todas las cuentas activas de un cliente según su ID.
	public List<Cuenta> obtenerCuentasPorCliente(int clienteId) throws Exception {
	    List<Cuenta> lista = new ArrayList<>();
	    PreparedStatement st = null;
	    ResultSet rs = null;

	    try {
	        Connection cn = Conexion.getSQLConexion();
	        st = cn.prepareStatement("SELECT * FROM cuentas WHERE cliente_id = ? AND estado = 1");
	        st.setInt(1, clienteId);

	        rs = st.executeQuery();

	        while (rs.next()) {
	            Cuenta c = new Cuenta();
	            c.setCuenta_id(rs.getInt("cuenta_id"));
	            c.setCbu(rs.getString("cbu"));
	            c.setAlias(rs.getString("alias"));
	            lista.add(c);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return lista;
	}

	// Este método obtiene una cuenta específica mediante su ID.
	public Cuenta obtenerCuentaPorId(int id) {

	    Cuenta cuenta = null;
	    Connection conn = null;
	    CallableStatement stmt = null;

	    try {
	        conn = Conexion.getSQLConexion();
	        stmt = conn.prepareCall(obtenerCuentaPorId);
	        stmt.setInt(1, id);

	        ResultSet rs = stmt.executeQuery();

	        if (rs.next()) {
	            cuenta = new Cuenta();

	            cuenta.setCuenta_id(rs.getInt("cuenta_id"));
	            cuenta.setCbu(rs.getString("cbu"));
	            cuenta.setAlias(rs.getString("alias"));
	            cuenta.setFecha_creacion(rs.getDate("fecha_creacion"));
	            cuenta.setSaldo(rs.getBigDecimal("saldo"));

	            // Cliente asociado
	            Cliente cliente = new Cliente();
	            cliente.setClienteId(rs.getInt("cliente_id"));
	            cliente.setNombre(rs.getString("nombre_cliente"));
	            cliente.setApellido(rs.getString("apellido_cliente"));
	            cliente.setDni(rs.getString("dni"));
	            cuenta.setCliente(cliente);

	            // Tipo de cuenta
	            TipoCuenta tipoCuenta = new TipoCuenta();
	            tipoCuenta.setTipoCuenta_id(rs.getInt("tipocuentas_id"));
	            tipoCuenta.setDescripcion(rs.getString("tipos_cuentas"));
	            cuenta.setTipoCuenta(tipoCuenta);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return cuenta;
	}

	// Este método obtiene las cuentas asociadas a un usuario para la sección de movimientos.
	@Override
	public List<Cuenta> obtenerCuentasPorClienteMovimientos(int usuarioId) {
	    List<Cuenta> lista = new ArrayList<>();

	    try (Connection conn = Conexion.getSQLConexion();
	         PreparedStatement ps = conn.prepareStatement(cuentasPorCliente)) {

	        ps.setInt(1, usuarioId);
	        try (ResultSet rs = ps.executeQuery()) {
	            while (rs.next()) {
	                Cuenta c = new Cuenta();
	                c.setCuenta_id(rs.getInt("cuenta_id"));
	                c.setAlias(rs.getString("alias"));
	                c.setCbu(rs.getString("cbu"));
	                c.setSaldo(rs.getBigDecimal("saldo"));

	                TipoCuenta tc = new TipoCuenta();
	                tc.setTipoCuenta_id(rs.getInt("tipoCuenta_id"));
	                tc.setDescripcion(rs.getString("descripcion_tipo"));
	                c.setTipoCuenta(tc);

	                lista.add(c);
	            }
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return lista;
	}

	// Este método obtiene todas las cuentas visibles de un usuario mediante un procedimiento almacenado.
	@Override
	public List<Cuenta> obtenerCuentasPorUsuario(int usuarioId) {
	    List<Cuenta> lista = new ArrayList<>();

	    try (Connection conn = Conexion.getSQLConexion();
		         PreparedStatement ps = conn.prepareStatement(cuentasPorCliente)) {

		        ps.setInt(1, usuarioId);
		        try (ResultSet rs = ps.executeQuery()) {
		            while (rs.next()) {
		                Cuenta c = new Cuenta();
		                c.setCuenta_id(rs.getInt("cuenta_id"));
		                c.setAlias(rs.getString("alias"));
		                c.setCbu(rs.getString("cbu"));
		                c.setSaldo(rs.getBigDecimal("saldo"));

		                TipoCuenta tc = new TipoCuenta();
		                tc.setTipoCuenta_id(rs.getInt("tipoCuenta_id"));
		                tc.setDescripcion(rs.getString("descripcion_tipo"));
		                c.setTipoCuenta(tc);

		                lista.add(c);
		            }
		        }

		    } catch (SQLException e) {
		        e.printStackTrace();
		    }

		    return lista;
	}


}
