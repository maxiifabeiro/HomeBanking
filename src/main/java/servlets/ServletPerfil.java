package servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import negocio.UsuarioNegocio;
import negocioImpl.UsuarioNegocioImpl;

import java.io.IOException;

import entidades.Cliente;
import entidades.Usuario;

/**
 * Servlet implementation class ServletPerfil
 */
@WebServlet("/ServletPerfil")
public class ServletPerfil extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UsuarioNegocio usuarioNegocio;   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletPerfil() {
        super();
        usuarioNegocio = new UsuarioNegocioImpl();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		
		Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado"); //traigo al usuario logueado
		int idUsuario = usuarioLogueado.getUsuarioId() ; //*Id del usuario logueado
		
		request.setAttribute("usuario", usuarioLogueado);
		
        Cliente cliente = usuarioNegocio.obtenerClientePorIdUsuario(idUsuario);
        
        request.setAttribute("cliente", cliente);


        RequestDispatcher rd = request.getRequestDispatcher("Perfil.jsp");
        rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
