package daoImpl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import dao.MovimientosDao;
import entidades.Cuenta;
import entidades.Movimientos;
import entidades.TipoCuenta;
import entidades.Transferencia;

public class MovimientosDaoImpl implements MovimientosDao{
	private static final String obtenerMovimientos = "{CALL listarMovimientos()}";
    private static final String movimientosPorFecha = "{CALL listarMovimientosPorFechas(?, ?, ?)}";
    private static final String obtenerTipoCuenta = "SELECT * FROM tipos_cuentas";
    private static final String movimientosPorCliente = "{CALL listarMovimientosPorCliente(?)}";
    private static final String movimientosPorCuenta = "{CALL listarMovimientosPorCuenta(?)}";

    @Override
 // Este método obtiene todos los movimientos registrados en el sistema
 public List<Movimientos> obtenerMovimientos() {
     List<Movimientos> lista = new ArrayList<>();

     try (Connection conn = Conexion.getSQLConexion();
          CallableStatement statement = conn.prepareCall(obtenerMovimientos);
          ResultSet rs = statement.executeQuery()) {

         while (rs.next()) {
             Movimientos mov = new Movimientos();
             mov.setMovimientoId(rs.getInt("movimientoId"));
             mov.setFecha(rs.getDate("fecha"));
             mov.setImporte(rs.getDouble("monto"));
             mov.setSaldo(rs.getBigDecimal("saldo"));

             int cuentaOrigen = rs.getInt("cuentaOrigen");
             int cuentaDestino = rs.getInt("cuentaDestino");

             if (cuentaOrigen != 0 || cuentaDestino != 0) {
                 Transferencia t = new Transferencia();
                 t.setCuenta_origen(cuentaOrigen);
                 t.setCuenta_destino(cuentaDestino);
                 t.setEstado(rs.getString("Estado"));
                 mov.setTransferenciaId(t);
             }

             lista.add(mov);
         }

     } catch (SQLException e) {
         e.printStackTrace();
     }

     return lista;
 }

 @Override
 // Este método lista los movimientos filtrados por un rango de fechas y un cliente específico
 public List<Movimientos> listarMovimientosPorFechas(Date desde, Date hasta, int nrocliente) {
     List<Movimientos> lista = new ArrayList<>();

     try (Connection conn = Conexion.getSQLConexion();
          CallableStatement statement = conn.prepareCall(movimientosPorFecha)) {

         statement.setDate(1, desde);
         statement.setDate(2, hasta);
         statement.setInt(3, nrocliente);

         try (ResultSet rs = statement.executeQuery()) {
             while (rs.next()) {
            	 Movimientos mov = new Movimientos();
            	 mov.setMovimientoId(rs.getInt("movimiento_id"));
            	 mov.setFecha(rs.getDate("fecha"));
            	 mov.setImporte(rs.getDouble("importe"));
            	 mov.setSaldo(rs.getBigDecimal("saldo"));

            	 String aliasOrigen = rs.getString("alias_origen");
            	 String aliasDestino = rs.getString("alias_destino");

            	 if (aliasOrigen != null || aliasDestino != null) {
            	     Transferencia t = new Transferencia();
            	     t.setAliasOrigen(aliasOrigen);
            	     t.setAliasDestino(aliasDestino);
            	     t.setEstado(rs.getString("estado"));
            	     mov.setTransferenciaId(t);
            	 }

                 lista.add(mov);
             }
         }

     } catch (SQLException e) {
         e.printStackTrace();
     }

     return lista;
 }

 @Override
 // Este método lista los movimientos asociados a un usuario específico
 public List<Movimientos> listarMovimientosPorCliente(int usuarioId) {
     List<Movimientos> lista = new ArrayList<>();

     try (Connection conn = Conexion.getSQLConexion();
          CallableStatement stmt = conn.prepareCall(movimientosPorCliente)) {

         stmt.setInt(1, usuarioId);

         try (ResultSet rs = stmt.executeQuery()) {
             while (rs.next()) {
                 Movimientos mov = new Movimientos();
                 mov.setMovimientoId(rs.getInt("movimiento_id"));
                 mov.setFecha(rs.getDate("fecha"));
                 mov.setImporte(rs.getDouble("importe"));
                 mov.setDetalle(rs.getString("detalle"));
                 mov.setSaldo(rs.getBigDecimal("saldo"));
                 
                 Cuenta cuenta = new Cuenta();
                 cuenta.setCuenta_id(rs.getInt("cuenta_id"));
                 cuenta.setAlias(rs.getString("cuenta_alias"));
                 cuenta.setCbu(rs.getString("cuenta_cbu"));
                 cuenta.setSaldo(rs.getBigDecimal("saldo"));
                 mov.setCuentaId(cuenta);

                 String aliasOrigen = rs.getString("alias_origen");
                 String aliasDestino = rs.getString("alias_destino");

                 if (aliasOrigen != null || aliasDestino != null) {
                     Transferencia t = new Transferencia();
                     t.setAliasOrigen(aliasOrigen);
                     t.setAliasDestino(aliasDestino);
                     t.setEstado(rs.getString("estado"));
                     mov.setTransferenciaId(t);
                 }


                 lista.add(mov);
             }
         }

     } catch (SQLException e) {
         e.printStackTrace();
     }

     return lista;
 }

 @Override
 // Este método obtiene la lista de tipos de cuenta disponibles en la base de datos
 public List<TipoCuenta> obtenerTipoCuenta() {
     List<TipoCuenta> tipoCuentas = new ArrayList<>();

     try (Connection conn = Conexion.getSQLConexion();
          CallableStatement statement = conn.prepareCall(obtenerTipoCuenta);
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

 @Override
 // Este método lista los movimientos pertenecientes a una cuenta específica
 public List<Movimientos> listarMovimientosPorCuenta(int cuentaId) {
     List<Movimientos> lista = new ArrayList<>();

     try (Connection conn = Conexion.getSQLConexion();
          CallableStatement stmt = conn.prepareCall(movimientosPorCuenta)) {

         stmt.setInt(1, cuentaId);

         try (ResultSet rs = stmt.executeQuery()) {
             while (rs.next()) {
                 Movimientos mov = new Movimientos();
                 mov.setMovimientoId(rs.getInt("movimiento_id"));
                 mov.setFecha(rs.getDate("fecha"));
                 mov.setImporte(rs.getDouble("importe"));
                 mov.setSaldo(rs.getBigDecimal("saldo"));
                 mov.setDetalle(rs.getString("detalle"));

                 Cuenta cuenta = new Cuenta();
                 cuenta.setCuenta_id(rs.getInt("cuenta_id"));
                 mov.setCuentaId(cuenta);

                 String aliasOrigen = rs.getString("alias_origen");
                 String aliasDestino = rs.getString("alias_destino");

                 if (aliasOrigen != null || aliasDestino != null) {
                     Transferencia t = new Transferencia();
                     t.setAliasOrigen(aliasOrigen);
                     t.setAliasDestino(aliasDestino);
                     t.setEstado(rs.getString("estado"));
                     mov.setTransferenciaId(t);
                 }


                 lista.add(mov);
             }
         }

     } catch (SQLException e) {
         e.printStackTrace();
     }

     return lista;
 }
 
}
