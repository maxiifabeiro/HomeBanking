package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import negocioImpl.CuentaNegocioImpl;
import negocioImpl.UsuarioNegocioImpl;

import java.io.IOException;

import entidades.Usuario;


@WebServlet("/ServletUsuario")
public class ServletUsuario extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ServletUsuario() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String usuario = request.getParameter("txtUsuario");
        String pass = request.getParameter("txtContraseña");

        CuentaNegocioImpl cNeg = new CuentaNegocioImpl();
        
        UsuarioNegocioImpl negocio = new UsuarioNegocioImpl();
        Usuario user = negocio.buscarUsuario(usuario, pass);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("usuarioLogueado", user);
            int usuarioId = user.getUsuarioId();

            try {
                int clienteId = cNeg.obtenerClientePorUsuario(usuarioId);
                session.setAttribute("clienteId", clienteId);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Error al obtener cliente.");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
                return;
            }

            int tipo = user.getTipoUsuario().getTipoUsuarioId();
            if (tipo == 1) {
                response.sendRedirect("InicioMenuAdministrador.jsp");
            } else if (tipo == 2) {
                response.sendRedirect("InicioMenuCliente.jsp");
            }
        } else {
            request.setAttribute("error", "Usuario o contraseña incorrectos");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }

	}

}
