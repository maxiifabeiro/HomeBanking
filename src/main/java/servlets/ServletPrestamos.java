package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import negocio.PrestamosNegocio;
import negocioImpl.PrestamosNegocioImpl;

import java.io.IOException;
import java.util.List;

import entidades.Prestamos;

/**
 * Servlet implementation class ServletPrestamos
 */
@WebServlet("/ServletPrestamos")
public class ServletPrestamos extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletPrestamos() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrestamosNegocio dao = new PrestamosNegocioImpl();

        String dni = request.getParameter("txtBuscar");

        List<Prestamos> lista;

        if (dni != null && !dni.trim().isEmpty()) {
            lista = dao.listarPrestamosPorDni(dni);
        } else {
            lista = dao.listarPrestamos();
        }

        request.setAttribute("dniFiltro", dni);
        request.setAttribute("prestamos", lista);
        request.getRequestDispatcher("AutorizacionPrestamo.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	    PrestamosNegocio pNeg = new PrestamosNegocioImpl();

	    String accion = request.getParameter("accion");

	    if (accion != null) {
	    	boolean resultado = false;
	    	int id = Integer.parseInt(request.getParameter("prestamoId"));

	    	if (accion.equals("autorizar")) {
	    	    resultado = pNeg.actualizarEstadoPrestamo(id, "autorizado");
	    	}

	    	if (accion.equals("rechazar")) {
	    	    resultado = pNeg.actualizarEstadoPrestamo(id, "rechazado");
	    	}

	    	if (resultado) {
	    	    request.setAttribute("mensaje", "Operación realizada con éxito.");
	    	    request.setAttribute("tipoMensaje", "exito");
	    	} else {
	    	    request.setAttribute("mensaje", "Error al realizar la operación.");
	    	    request.setAttribute("tipoMensaje", "error");
	    	}

	        
	        List<Prestamos> lista = pNeg.listarPrestamos();
	        request.setAttribute("prestamos", lista);
	        request.getRequestDispatcher("AutorizacionPrestamo.jsp").forward(request, response);
	        return;
	    }


	    String dni = request.getParameter("txtBuscar");
	    List<Prestamos> lista;

	    if (dni != null && !dni.trim().isEmpty()) {
	        lista = pNeg.listarPrestamosPorDni(dni);
	    } else {
	        lista = pNeg.listarPrestamos();
	    }

	    request.setAttribute("dniFiltro", dni);
	    request.setAttribute("prestamos", lista);
	    request.getRequestDispatcher("AutorizacionPrestamo.jsp").forward(request, response);
	}

}
