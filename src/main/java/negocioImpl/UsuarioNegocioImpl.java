package negocioImpl;

import dao.UsuarioDao;
import daoImpl.UsuarioDaoImpl;
import entidades.Cliente;
import entidades.Usuario;
import negocio.UsuarioNegocio;

public class UsuarioNegocioImpl implements UsuarioNegocio{
	private UsuarioDao uDao = new UsuarioDaoImpl();

    public Usuario buscarUsuario(String nombreUsuario, String clave) {
        if (nombreUsuario == null || clave == null ||
            nombreUsuario.isEmpty() || clave.isEmpty()) {
            return null;
        }

        return uDao.buscarUsuario(nombreUsuario, clave);
    }

	@Override
	public String obtenerPreguntaSecreta(String usuario) {
		return uDao.obtenerPreguntaSecreta(usuario);
	}

	@Override
	public boolean validarRespuesta(String usuario, String respuesta) {
		return uDao.validarRespuesta(usuario, respuesta);
	}

	@Override
	public boolean cambiarContrasena(String usuario, String nuevaPass) {
		return uDao.cambiarContrasena(usuario, nuevaPass);
	}
    
	public Cliente obtenerClientePorIdUsuario(int idUsuario) {
		return uDao.obtenerClientePorIdUsuario(idUsuario);
	}

}
