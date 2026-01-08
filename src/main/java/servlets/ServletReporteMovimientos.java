package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import negocioImpl.ReporteNegocioImpl;
import negocio.ReporteNegocio;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

import entidades.Movimientos;
import entidades.Reportes;

/**
 * Servlet implementation class ServletReporteMovimientos
 */
@WebServlet("/ServletReporteMovimientos")
public class ServletReporteMovimientos extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletReporteMovimientos() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("ReporteDeMovimientos.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String dniCliente = request.getParameter("dniCliente");
        String desdeStr = request.getParameter("desde");
        String hastaStr = request.getParameter("hasta");

        if (dniCliente == null || dniCliente.isEmpty() ||
            desdeStr == null || desdeStr.isEmpty() ||
            hastaStr == null || hastaStr.isEmpty()) {

            request.setAttribute("mensaje", "Debe completar cliente y fechas.");
            request.getRequestDispatcher("ReporteDeMovimientos.jsp").forward(request, response);
            return;
        }

        try {
            String dni = dniCliente;
            Date desde = Date.valueOf(desdeStr);
            Date hasta = Date.valueOf(hastaStr);

            ReporteNegocio negocio = new ReporteNegocioImpl();

            Reportes resumen = negocio.obtenerResumen(dni, desde, hasta);

            if (resumen == null) {
                resumen = new Reportes();
            }

            request.setAttribute("totalMovimientos", resumen.getTotalTransacciones());
            request.setAttribute("montoTotal", resumen.getMontoTotal());
            request.setAttribute("promedio", resumen.getPromedio());

            request.setAttribute("dniCliente", dniCliente);
            request.setAttribute("desde", desde);
            request.setAttribute("hasta", hasta);

            request.getRequestDispatcher("ReporteDeMovimientos.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("mensaje", "El número de cliente ingresado no es válido.");
            request.getRequestDispatcher("ReporteDeMovimientos.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("mensaje", "Ocurrió un error al procesar la solicitud.");
            request.getRequestDispatcher("ReporteDeMovimientos.jsp").forward(request, response);
        }
	}

}
