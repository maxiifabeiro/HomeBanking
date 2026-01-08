package negocioImpl;

import java.util.List;

import dao.TransferenciaDao;
import daoImpl.TransferenciaDaoImpl;
import entidades.TipoMovimiento;
import negocio.TransferenciaNegocio;

public class TransferenciaNegocioImpl implements TransferenciaNegocio {

    TransferenciaDao dao = new TransferenciaDaoImpl();

    @Override
    public boolean transferirPropias(int origen, int destino, double importe, int idTipoMovimiento) throws Exception {

        // Validacion para que no se transfiera monto menor a 0
        if (importe <= 0)
            throw new Exception("El importe debe ser mayor a cero");

        // No transfiera a la misma cuenta
        if (origen == destino)
            throw new Exception("Las cuentas deben ser distintas");

        // Llamo al DAO para ejecutar el sp
        return dao.transferirEntrePropias(origen, destino, idTipoMovimiento, importe);
    }

    @Override
    public boolean transferirTerceros(int origen, String cbuAlias, double importe, int idTipoMovimiento) throws Exception {

        // Valido el importe
        if (importe <= 0)
            throw new Exception("El importe debe ser mayor a cero");

        // Ejecuto transferencia terceros
        return dao.transferirATerceros(origen, cbuAlias, idTipoMovimiento, importe);
    }

    @Override
    public List<TipoMovimiento> obtenerTipoMovimiento() {
        // Devuelve la lista detipos de movimiento para usar en la vista
        return dao.obtenerTipoMovimiento();
    }
}
