package negocio;

import java.util.List;

import entidades.Cuota;
import entidades.Prestamos;
import entidades.TipoPrestamo;

public interface PrestamosNegocio {
	public List<Prestamos> listarPrestamos();
	public List<Prestamos> listarPrestamosPorDni(String dni);
	public boolean actualizarEstadoPrestamo(int id, String estado);
	public boolean crearPrestamo(Prestamos prestamo);
	public List<TipoPrestamo> obtenerTipoPrestamos();
	
	public List<Prestamos> obtenerPrestamosPorCliente(int clienteId);
	List<Cuota> obtenerCuotasPorPrestamo(int prestamoId);
	Prestamos obtenerPrestamoPorId(int id);
	public boolean pagarCuota(int cuotaId, int cuentaId);
}
