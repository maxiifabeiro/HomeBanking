package negocio;

import java.util.List;

import entidades.TipoMovimiento;

public interface TransferenciaNegocio {
    public boolean transferirPropias(int origen, int destino, double importe, int idTipoMovimiento) throws Exception;
    public boolean transferirTerceros(int origen, String cbuAlias, double importe, int idTipoMovimiento) throws Exception;
    public List<TipoMovimiento> obtenerTipoMovimiento();
}

