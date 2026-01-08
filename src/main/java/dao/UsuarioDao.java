package dao;

import entidades.Cliente;
import entidades.Usuario;

public interface UsuarioDao {
	public Usuario buscarUsuario(String nombreUsuario, String clave);
	public String obtenerPreguntaSecreta(String usuario);
	public boolean validarRespuesta(String usuario, String respuesta);
	public boolean cambiarContrasena(String usuario, String nuevaPass);
	public Cliente obtenerClientePorIdUsuario(int idUsuario);
}
