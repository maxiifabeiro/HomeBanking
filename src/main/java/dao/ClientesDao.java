package dao;

import java.util.List;

import entidades.Cliente;
import entidades.Pais;
import entidades.Pregunta;
import entidades.Provincias;
import entidades.Localidades;

public interface ClientesDao {

	public boolean agregarCliente(Cliente agregarCliente);
	public boolean eliminarCliente(int clienteId);
	public boolean modificarCliente(Cliente cliente) ;
	List<Cliente> obtenerClientes();
	Cliente obtenerClientePorDni(String dni);
    public List<Pais> obtenerPais();
    public List<Provincias> obtenerProvinciasPorPais(int paisId);
    public List<Localidades> obtenerLocalidadesPorProvincia(int provinciaId);
    public List<Pregunta> obtenerPregunta();
}
