package daoImpl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.ClientesDao;
import entidades.Cliente;
import entidades.Localidades;
import entidades.Pais;
import entidades.Pregunta;
import entidades.Provincias;
import entidades.Usuario;

public class ClientesDaoImpl implements ClientesDao {

	private static final String agregarCliente = "CALL AltaCliente(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	private static final String eliminarCliente = "CALL BajaClienteYUsuario(?)";
	private static final String modificarCliente = "CALL ModificarCliente(?,?,?,?,?,?,?,?,?,?,?,?,?)";
	private static final String obtenerClientes = "CALL ListarClientes()";
	private static final String obtenerClientePorDni = "CALL ListarUnCliente(?)";
    private static final String obtenerPais = "SELECT * FROM paises";
    private static final String obtenerPregunta = "SELECT * FROM pregunta";
    
 // Este método agrega un nuevo cliente y su usuario asociado mediante un procedimiento almacenado.
    @Override
    public boolean agregarCliente(Cliente cliente) {

        try (Connection conn = Conexion.getSQLConexion();
             CallableStatement stmt = conn.prepareCall(agregarCliente)) {

            stmt.setString(1, cliente.getDni());
            stmt.setString(2, cliente.getCuil());
            stmt.setString(3, cliente.getNombre());
            stmt.setString(4, cliente.getApellido());
            stmt.setString(5, String.valueOf(cliente.getSexo()));

            // Cambio: ahora se pasa el ID del país
            stmt.setInt(6, cliente.getPais().getPais_id());

            stmt.setDate(7, new java.sql.Date(cliente.getFechaNacimiento().getTime()));
            stmt.setString(8, cliente.getDireccion());

            // Localidad
            stmt.setInt(9, cliente.getLocalidad().getLocalidad_id());

            stmt.setString(10, cliente.getCorreoElectronico());
            stmt.setString(11, cliente.getTelefono());

            // Usuario
            stmt.setString(12, cliente.getUsuario().getNombreUsuario());
            stmt.setString(13, cliente.getUsuario().getClave());

            stmt.setInt(14, cliente.getPregunta_id().getPregunta_id());
            stmt.setString(15, cliente.getUsuario().getRespuesta());
            stmt.setInt(16, cliente.getUsuario().getTipoUsuario().getTipoUsuarioId());

            stmt.execute();

            conn.commit();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

// Este método elimina un cliente según su ID utilizando un procedimiento almacenado.
@Override
    public boolean eliminarCliente(int clienteId) {
        String sql = eliminarCliente;

        try (Connection conn = Conexion.getSQLConexion();
             CallableStatement stmt = conn.prepareCall(sql)) {

            stmt.setInt(1, clienteId);
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

 // Este método modifica los datos de un cliente existente mediante un procedimiento almacenado.
@Override
public boolean modificarCliente(Cliente cliente) {

    try (Connection conn = Conexion.getSQLConexion();
         CallableStatement stmt = conn.prepareCall(modificarCliente)) {

    	stmt.setInt(1, cliente.getClienteId());
    	stmt.setString(2, cliente.getDni());
    	stmt.setString(3, cliente.getCuil());
    	stmt.setString(4, cliente.getNombre());
    	stmt.setString(5, cliente.getApellido());
    	stmt.setString(6, String.valueOf(cliente.getSexo()));
    	stmt.setInt(7, cliente.getPais().getPais_id());
    	stmt.setDate(8, new java.sql.Date(cliente.getFechaNacimiento().getTime()));
    	stmt.setString(9, cliente.getDireccion());
    	stmt.setInt(10, cliente.getLocalidad().getLocalidad_id());
    	stmt.setString(11, cliente.getCorreoElectronico());
    	stmt.setString(12, cliente.getTelefono());

    	stmt.setString(13, cliente.getUsuario().getNombreUsuario());

        stmt.execute();
        conn.commit();
        return true;

    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}



 @Override
 // Este método obtiene una lista completa de clientes desde la base de datos.
 public List<Cliente> obtenerClientes() {
     List<Cliente> clientes = new ArrayList<>();
     Connection conn = null;
     CallableStatement stmt = null;

     try {
         conn = Conexion.getSQLConexion();
         stmt = conn.prepareCall(obtenerClientes);
         ResultSet rs = stmt.executeQuery();

         while (rs.next()) {
             Cliente cliente = new Cliente();

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
             pais.setNombre(rs.getString("nacionalidad"));
             cliente.setPais(pais);

             // Provincia
             Provincias prov = new Provincias();
             prov.setNombre(rs.getString("provincia"));
             cliente.setProvincia(prov);

             // Localidad
             Localidades loc = new Localidades();
             loc.setNombre(rs.getString("localidad"));
             cliente.setLocalidad(loc);

             // Usuario
             Usuario usuario = new Usuario();
             usuario.setNombreUsuario(rs.getString("nombre_usuario"));
             cliente.setUsuario(usuario);

             clientes.add(cliente);
         }

     } catch (SQLException e) {
         e.printStackTrace();
     }

     return clientes;
 }

 @Override
 // Este método obtiene un cliente específico filtrado por su DNI.
 public Cliente obtenerClientePorDni(String dni) {
	 Cliente cliente = null;
	    Connection conn = null;
	    CallableStatement stmt = null;

	    try {
	        conn = Conexion.getSQLConexion();
	        stmt = conn.prepareCall(obtenerClientePorDni);
	        stmt.setString(1, dni);

	        ResultSet rs = stmt.executeQuery();

	        if (rs.next()) {

	            // Localidad
	            Localidades loc = new Localidades();
	            loc.setLocalidad_id(rs.getInt("localidad_id"));
	            loc.setNombre(rs.getString("nombre_localidad"));

	            // Provincia
	            Provincias prov = new Provincias();
	            prov.setProvincia_id(rs.getInt("provincia_id"));
	            prov.setNombre(rs.getString("nombre_provincia"));

	            // País
	            Pais pais = new Pais();
	            pais.setPais_id(rs.getInt("pais_id"));
	            pais.setNombre(rs.getString("nombre_pais"));
	            
	            // Usuario
	            Usuario usuario = new Usuario();
	            usuario.setUsuarioId(rs.getInt("usuario_id"));
	            usuario.setNombreUsuario(rs.getString("nombre_usuario"));
	            
	            // Cliente
	            cliente = new Cliente();
	            cliente.setClienteId(rs.getInt("cliente_id"));
	            cliente.setDni(rs.getString("dni"));
	            cliente.setCuil(rs.getString("cuil"));
	            cliente.setNombre(rs.getString("nombre"));
	            cliente.setApellido(rs.getString("apellido"));
	            cliente.setSexo(rs.getString("sexo").charAt(0));
	            cliente.setFechaNacimiento(rs.getDate("fecha_nacimiento"));
	            cliente.setDireccion(rs.getString("direccion"));
	            cliente.setCorreoElectronico(rs.getString("correo_electronico"));
	            cliente.setTelefono(rs.getString("telefono"));
	            cliente.setLocalidad(loc);
	            cliente.setProvincia(prov);
	            cliente.setPais(pais);
	            cliente.setUsuario(usuario);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return cliente;
 }

 @Override
 public List<Pais> obtenerPais() {
     List<Pais> paises = new ArrayList<>();
     try (Connection conn = Conexion.getSQLConexion();
          PreparedStatement statement = conn.prepareStatement(obtenerPais);
          ResultSet resultSet = statement.executeQuery()) {

         while (resultSet.next()) {
             Pais pais = new Pais();
             pais.setPais_id(resultSet.getInt("pais_id"));
             pais.setNombre(resultSet.getString("nombre"));
             paises.add(pais);
         }

     } catch (SQLException e) {
         e.printStackTrace();
     }
     return paises;
 }

 @Override
 public List<Provincias> obtenerProvinciasPorPais(int paisId) {
     List<Provincias> lista = new ArrayList<>();
     String sql = "SELECT provincia_id, nombre FROM provincias WHERE pais_id = ?";

     try (Connection conn = Conexion.getSQLConexion();
          PreparedStatement st = conn.prepareStatement(sql)) {

         st.setInt(1, paisId);
         try (ResultSet rs = st.executeQuery()) {
             while (rs.next()) {
                 Provincias p = new Provincias();
                 p.setProvincia_id(rs.getInt("provincia_id"));
                 p.setNombre(rs.getString("nombre"));
                 p.setPais_id(paisId);
                 lista.add(p);
             }
         }

     } catch (SQLException e) {
         e.printStackTrace();
     }
     return lista;
 }

 @Override
 public List<Localidades> obtenerLocalidadesPorProvincia(int provinciaId) {
     List<Localidades> lista = new ArrayList<>();
     String sql = "SELECT localidad_id, nombre FROM localidades WHERE provincia_id = ?";

     try (Connection conn = Conexion.getSQLConexion();
          PreparedStatement st = conn.prepareStatement(sql)) {

         st.setInt(1, provinciaId);
         try (ResultSet rs = st.executeQuery()) {
             while (rs.next()) {
                 Localidades l = new Localidades();
                 l.setLocalidad_id(rs.getInt("localidad_id"));
                 l.setNombre(rs.getString("nombre"));
                 l.setProvincia_id(provinciaId);
                 lista.add(l);
             }
         }

     } catch (SQLException e) {
         e.printStackTrace();
     }
     return lista;
 }

 @Override
 public List<Pregunta> obtenerPregunta() {
     List<Pregunta> preguntas = new ArrayList<>();
     try (Connection conn = Conexion.getSQLConexion();
          PreparedStatement statement = conn.prepareStatement(obtenerPregunta);
          ResultSet resultSet = statement.executeQuery()) {

         while (resultSet.next()) {
             Pregunta preg = new Pregunta();
             preg.setPregunta_id(resultSet.getInt("pregunta_id"));
             preg.setDescripcion(resultSet.getString("descripcion"));
             preguntas.add(preg);
         }

     } catch (SQLException e) {
         e.printStackTrace();
     }
     return preguntas;
 }

}


