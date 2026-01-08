package negocioImpl;

import java.util.List;

import daoImpl.PrestamosDaoImpl;
import entidades.Cuota;
import entidades.Prestamos;
import entidades.TipoPrestamo;
import negocio.PrestamosNegocio;

public class PrestamosNegocioImpl implements PrestamosNegocio{
	private PrestamosDaoImpl pDao = new PrestamosDaoImpl();
	
	@Override
	public boolean crearPrestamo(Prestamos prestamo) {
		return this.pDao.crearPrestamo(prestamo);
	}
	
	@Override
	public List<Prestamos> listarPrestamos() {
		return pDao.listarPrestamos();
	}

	@Override
	public List<Prestamos> listarPrestamosPorDni(String dni) {
		return pDao.listarPrestamosPorDni(dni);
	}

	@Override
	public boolean actualizarEstadoPrestamo(int id, String estado) {
		return pDao.actualizarEstadoPrestamo(id, estado);
	}

	@Override
	public List<TipoPrestamo> obtenerTipoPrestamos() {
		return pDao.obtenerTipoPrestamos();
	}

    // Devuelve la lista completa de préstamos
	public List<Prestamos> obtenerPrestamosPorCliente(int clienteId) {
        return pDao.obtenerPrestamosPorCliente(clienteId);
    }

    @Override
    // Obtiene todas las cuotas asociadas a un préstamo
    public List<Cuota> obtenerCuotasPorPrestamo(int prestamoId) {
        return pDao.obtenerCuotasPorPrestamo(prestamoId);
    }

    @Override
    // Busca un prestamo por su ID
    public Prestamos obtenerPrestamoPorId(int id) {
        return pDao.obtenerPrestamoPorId(id);
    }

    @Override
    // Marca una cuota como pagada
    public boolean pagarCuota(int cuotaId, int cuentaId) {
        return pDao.pagarCuota(cuotaId,cuentaId);
    }
	
}
