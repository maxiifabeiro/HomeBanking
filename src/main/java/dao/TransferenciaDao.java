package dao;

import java.util.List;

import entidades.TipoMovimiento;


public interface TransferenciaDao {
    boolean transferirEntrePropias(int origen, int destino, int idMotivo, double importe) throws Exception;
    boolean transferirATerceros(int origen, String cbuAlias, int idMotivo, double importe) throws Exception;
    List<TipoMovimiento> obtenerTipoMovimiento();
}

