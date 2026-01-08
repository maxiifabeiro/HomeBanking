package negocioImpl;
import java.util.List;
import daoImpl.ClientesDaoImpl;
import entidades.Cliente;
import entidades.Localidades;
import entidades.Pais;
import entidades.Pregunta;
import entidades.Provincias;
import negocio.ClientesNegocio;

public class ClientesNegocioImpl implements ClientesNegocio {

	private ClientesDaoImpl clientesDao = new ClientesDaoImpl();

    @Override
    public boolean agregarCliente(Cliente agregarCliente) {
        return clientesDao.agregarCliente(agregarCliente);
    }
    @Override
	public boolean eliminarCliente(int clienteId){
		return clientesDao.eliminarCliente(clienteId);
	}
    
	public boolean modificarCliente(Cliente cliente) {
        return clientesDao.modificarCliente(cliente);
	}
	@Override
	public List<Cliente> obtenerClientes() {
		return clientesDao.obtenerClientes();
	}
    @Override
	public Cliente obtenerClienteDni(String buscarPorDni) {
		return clientesDao.obtenerClientePorDni(buscarPorDni);
	}
    @Override
    public List<Pais> obtenerPais() {
        return clientesDao.obtenerPais();
    }

	@Override
	public List<Provincias> obtenerProvinciasPorPais(int paisId) {
		return clientesDao.obtenerProvinciasPorPais(paisId);
	}
	@Override
	public List<Localidades> obtenerLocalidadesPorProvincia(int provinciaId) {
		return clientesDao.obtenerLocalidadesPorProvincia(provinciaId);
	}
    
	@Override
	public List<Pregunta> obtenerPregunta() {
		return clientesDao.obtenerPregunta();
	}

}
