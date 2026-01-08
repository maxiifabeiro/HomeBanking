package dao;

import java.util.List;

import entidades.Cuota;
import entidades.Prestamos;
import entidades.TipoPrestamo;

public interface PrestamosDao {
	public boolean actualizarEstadoPrestamo(int id, String estado);
	public List<Prestamos> listarPrestamos();
	public List<Prestamos> listarPrestamosPorDni(String dni);
	public List<TipoPrestamo> obtenerTipoPrestamos();
	public boolean crearPrestamo(Prestamos prestamo);
	
	public List<Prestamos> obtenerPrestamosPorCliente(int clienteId);
	List<Cuota> obtenerCuotasPorPrestamo(int prestamoId);
	Prestamos obtenerPrestamoPorId(int id);
	public boolean pagarCuota(int cuotaId,int cuentaId);
}
