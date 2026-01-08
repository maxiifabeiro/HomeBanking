package negocio;
import java.util.List;

import entidades.Cliente;
import entidades.Pais;
import entidades.Pregunta;
import entidades.Provincias;
import entidades.Localidades;

public interface ClientesNegocio {
	
	public boolean agregarCliente(Cliente agregarCliente);
	public boolean eliminarCliente(int clienteId);
	public boolean modificarCliente(Cliente cliente);
	public List<Cliente> obtenerClientes();
	public Cliente obtenerClienteDni(String buscarDni);
    public List<Pais> obtenerPais();
    public List<Provincias> obtenerProvinciasPorPais(int paisId);
    public List<Localidades> obtenerLocalidadesPorProvincia(int provinciaId);
    public List<Pregunta> obtenerPregunta();
}
