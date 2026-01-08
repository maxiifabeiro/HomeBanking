package daoImpl;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Connection;
import dao.UsuarioDao;
import entidades.Cliente;
import entidades.Localidades;
import entidades.Pais;
import entidades.Provincias;
import entidades.TipoUsuario;
import entidades.Usuario;


public class UsuarioDaoImpl implements UsuarioDao{
	
	public Usuario buscarUsuario(String nombreUsuario, String clave) {
	    Usuario user = null;

	    try {
	    	Connection cn = Conexion.getSQLConexion();
	        PreparedStatement ps = cn.prepareStatement(
	            "SELECT u.usuario_id, u.nombre_usuario, u.clave, u.estado, u.respuesta, " +
	            "t.tipoUsuario_id, t.descripcion " +
	            "FROM usuarios u " +
	            "JOIN tipoUsuarios t ON u.tipoUsuario_id = t.tipoUsuario_id " +
	            "WHERE u.nombre_usuario = ? AND u.clave = ? AND u.estado = 1"
	        );

	        ps.setString(1, nombreUsuario);
	        ps.setString(2, clave);

	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            user = new Usuario();

	            user.setUsuarioId(rs.getInt("usuario_id"));
	            user.setNombreUsuario(rs.getString("nombre_usuario"));
	            user.setClave(rs.getString("clave"));
	            user.setEstado(rs.getBoolean("estado"));
	            user.setRespuesta(rs.getString("respuesta"));

	            TipoUsuario tipo = new TipoUsuario();
	            tipo.setTipoUsuarioId(rs.getInt("tipoUsuario_id"));
	            tipo.setDescripcion(rs.getString("descripcion"));

	            user.setTipoUsuario(tipo);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return user;
	}
	
	public String obtenerPreguntaSecreta(String usuario) {
	    String pregunta = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;
	    Connection con = null;

	    try {
	        con = Conexion.getSQLConexion();
	        String sql = "SELECT p.descripcion FROM usuarios u " +
	                     "INNER JOIN pregunta p ON u.pregunta_id = p.pregunta_id " +
	                     "WHERE u.nombre_usuario = ?";
	        ps = con.prepareStatement(sql);
	        ps.setString(1, usuario);
	        rs = ps.executeQuery();

	        if (rs.next()) {
	            pregunta = rs.getString("descripcion");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try { if (rs != null) rs.close(); } catch (Exception e) {}
	        try { if (ps != null) ps.close(); } catch (Exception e) {}
	    }
	    return pregunta;
	}

	public boolean validarRespuesta(String usuario, String respuesta) {
	    boolean valido = false;
	    PreparedStatement ps = null;
	    ResultSet rs = null;

	    try {
	        Connection con = Conexion.getSQLConexion();
	        String sql = "SELECT * FROM usuarios WHERE nombre_usuario = ? AND respuesta = ?";
	        ps = con.prepareStatement(sql);
	        ps.setString(1, usuario);
	        ps.setString(2, respuesta);
	        rs = ps.executeQuery();

	        valido = rs.next();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return valido;
	}


	public boolean cambiarContrasena(String usuario, String nuevaPass) {
	    boolean actualizado = false;

	    try {
	        Connection con = Conexion.getSQLConexion();
	        String sql = "UPDATE usuarios SET clave = ? WHERE nombre_usuario = ?";
	        PreparedStatement ps = con.prepareStatement(sql);
	        ps.setString(1, nuevaPass);
	        ps.setString(2, usuario);

	        if (ps.executeUpdate() > 0) {
	            con.commit();
	            actualizado = true;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return actualizado;
	}

	/*Obtener informacion personal del cliente para el perfil por idUsuario*/
	public Cliente obtenerClientePorIdUsuario(int idUsuario) {
	    Cliente cliente = null;
	    String consulta = "SELECT c.dni, c.cuil, c.nombre, c.apellido, c.sexo, " +
	                      "pa.pais_id, pa.nombre AS pais_nombre, " +
	                      "c.fecha_nacimiento, c.direccion, " +
	                      "l.localidad_id, l.nombre AS localidad_nombre, " +
	                      "p.provincia_id, p.nombre AS provincia_nombre, " +
	                      "c.correo_electronico, c.telefono " +
	                      "FROM clientes c " +
	                      "JOIN localidades l ON c.localidad_id = l.localidad_id " +
	                      "JOIN provincias p ON l.provincia_id = p.provincia_id " +
	                      "JOIN paises pa ON c.pais_id = pa.pais_id " +
	                      "WHERE c.usuario_id = ?";

	    try (Connection cn = Conexion.getSQLConexion();
	         PreparedStatement ps = cn.prepareStatement(consulta)) {

	        ps.setInt(1, idUsuario);
	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            cliente = new Cliente();
	            cliente.setDni(rs.getString("dni"));
	            cliente.setCuil(rs.getString("cuil"));
	            cliente.setNombre(rs.getString("nombre"));
	            cliente.setApellido(rs.getString("apellido"));
	            cliente.setSexo(rs.getString("sexo").charAt(0));
	            cliente.setFechaNacimiento(rs.getDate("fecha_nacimiento"));
	            cliente.setDireccion(rs.getString("direccion"));
	            cliente.setCorreoElectronico(rs.getString("correo_electronico"));
	            cliente.setTelefono(rs.getString("telefono"));

	            // País
	            Pais pais = new Pais();
	            pais.setPais_id(rs.getInt("pais_id"));
	            pais.setNombre(rs.getString("pais_nombre"));
	            cliente.setPais(pais);

	            // Localidad
	            Localidades loc = new Localidades();
	            loc.setLocalidad_id(rs.getInt("localidad_id"));
	            loc.setNombre(rs.getString("localidad_nombre"));
	            cliente.setLocalidad(loc);

	            // Provincia
	            Provincias prov = new Provincias();
	            prov.setProvincia_id(rs.getInt("provincia_id"));
	            prov.setNombre(rs.getString("provincia_nombre"));
	            cliente.setProvincia(prov);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return cliente;
	}

}
