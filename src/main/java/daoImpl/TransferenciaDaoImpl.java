package daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.CallableStatement;
import Excepciones.SaldoInsuficienteExcepcion;
import Excepciones.TransferenciaInvalidaException;
import dao.TransferenciaDao;
import entidades.TipoMovimiento;

public class TransferenciaDaoImpl implements TransferenciaDao {

    private static final String transferenciasPropias = "CALL TransferirEntrePropias(?,?,?,?)";

    private static final String transferenciasTerceros = "CALL TransferirATerceros(?,?,?,?)";

    private static final String obtenerTipoMovimiento = "SELECT * FROM TipoMovimientos";
    
 // Este metodo lo uso para las transferencias de cuentas propias
    @Override
    public boolean transferirEntrePropias(int origen, int destino, int idMotivo, double importe)
            throws TransferenciaInvalidaException, Exception {

    	try (Connection conn = Conexion.getSQLConexion();
    	         CallableStatement stmt = conn.prepareCall(transferenciasPropias)) {

    	        stmt.setInt(1, origen);
    	        stmt.setInt(2, destino);
    	        stmt.setInt(3, idMotivo);
    	        stmt.setDouble(4, importe);

    	        stmt.execute();
    	        conn.commit();
    	        return true;

    	    } catch (SQLException e) {
    	        // rollback en caso de error
    	        try (Connection conn = Conexion.getSQLConexion()) {
    	            conn.rollback();
    	        } catch (SQLException ex) {
    	            ex.printStackTrace();
    	        }

    	        if (e.getMessage().contains("Saldo insuficiente")) {
    	            throw new TransferenciaInvalidaException("Saldo insuficiente para realizar la transferencia.");
    	        }

    	        throw new Exception("Error en transferencia: " + e.getMessage());
    	    }

    }


 // Este metodo lo uso para transferencia a cuentas de terceros mediante CBU/Alias
 @Override
 public boolean transferirATerceros(int origen, String cbuAlias, int idMotivo, double importe)
         throws SaldoInsuficienteExcepcion,TransferenciaInvalidaException, Exception {
	 try (Connection conn = Conexion.getSQLConexion();
	         CallableStatement stmt = conn.prepareCall(transferenciasTerceros)) {

	        stmt.setInt(1, origen);
	        stmt.setString(2, cbuAlias);
	        stmt.setInt(3, idMotivo);
	        stmt.setDouble(4, importe);

	        stmt.execute();
	        conn.commit();
	        return true;

	    } catch (SQLException e) {
	        // rollback en caso de error
	        try (Connection conn = Conexion.getSQLConexion()) {
	            conn.rollback();
	        } catch (SQLException ex) {
	            ex.printStackTrace();
	        }

	        String msg = e.getMessage();

	        if (msg.contains("Saldo insuficiente")) {
	            throw new SaldoInsuficienteExcepcion("Saldo insuficiente para realizar la transferencia.");
	        }

	        if (msg.contains("La cuenta destino no existe")) {
	            throw new TransferenciaInvalidaException("La cuenta destino no existe.");
	        }

	        throw new Exception("Error inesperado: " + msg);
	    }

 }


 @Override
 // En este metodo obtengo la lista de tipos de movimientos disponibles
 public List<TipoMovimiento> obtenerTipoMovimiento() {
     List<TipoMovimiento> tiposM = new ArrayList<>();
     try (Connection conn = Conexion.getSQLConexion();
             PreparedStatement statement = conn.prepareStatement(obtenerTipoMovimiento);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                TipoMovimiento tipos = new TipoMovimiento();
                tipos.setTipoMovimiento_id(resultSet.getInt("tipoMovimiento_id"));
                tipos.setDescripcion(resultSet.getString("descripcion"));
                tiposM.add(tipos);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return tiposM;

 }

}
