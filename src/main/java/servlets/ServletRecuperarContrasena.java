package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import negocioImpl.UsuarioNegocioImpl;

import java.io.IOException;


@WebServlet("/ServletRecuperarContrasena")
public class ServletRecuperarContrasena extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UsuarioNegocioImpl negocio = new UsuarioNegocioImpl();

    public ServletRecuperarContrasena() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String accion = request.getParameter("accion");
        String usuario = request.getParameter("usuario");

        try {
            switch (accion) {

                case "verificar":
                    String pregunta = negocio.obtenerPreguntaSecreta(usuario);

                    if (pregunta != null) {
                        request.setAttribute("preguntaSecreta", pregunta);
                        request.setAttribute("usuario", usuario);
                        request.setAttribute("verificado", true);
                        request.setAttribute("mensaje", "Usuario encontrado");
                    } else {
                        request.setAttribute("mensaje", "Usuario no encontrado");
                    }
                    request.getRequestDispatcher("OlvidasteTuContrasena.jsp").forward(request, response);
                    break;


                case "responder":
                    String respuesta = request.getParameter("respuesta");

                    if (negocio.validarRespuesta(usuario, respuesta)) {
                        HttpSession session = request.getSession();
                        session.setAttribute("usuarioVerificado", usuario);

                        request.getRequestDispatcher("CambiarContrasena.jsp").forward(request, response);
                    } else {
                        request.setAttribute("mensaje", "Respuesta incorrecta");
                        request.setAttribute("usuario", usuario);
                        request.setAttribute("preguntaSecreta",
                                negocio.obtenerPreguntaSecreta(usuario));
                        request.getRequestDispatcher("OlvidasteTuContrasena.jsp").forward(request, response);
                    }
                    break;


                case "cambiar":
                    String nuevaPass = request.getParameter("nuevaPass");
                    HttpSession session = request.getSession();
                    usuario = (String) session.getAttribute("usuarioVerificado");

                    if (usuario != null && negocio.cambiarContrasena(usuario, nuevaPass)) {
                        request.setAttribute("mensaje", "Contraseña actualizada con éxito");
                    } else {
                        request.setAttribute("mensaje", "Error al actualizar la contraseña");
                    }
                    request.getRequestDispatcher("CambiarContrasena.jsp").forward(request, response);
                    break;
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("mensaje", "Error interno");
            request.getRequestDispatcher("OlvidasteTuContrasena.jsp").forward(request, response);
        }
    }
}

