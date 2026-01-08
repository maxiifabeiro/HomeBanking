package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import negocioImpl.ReporteNegocioImpl;

import java.io.IOException;
import java.sql.Date;

@WebServlet("/ServletReportesUsuarios")
public class ServletReportesUsuarios extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ServletReportesUsuarios() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	request.getRequestDispatcher("ReporteDeUsuarios.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String desdeUsuario = request.getParameter("desdeUsuarios");
        String hastaUsuario = request.getParameter("hastaUsuarios");

        if (desdeUsuario == null || desdeUsuario.isEmpty() ||
        		hastaUsuario == null || hastaUsuario.isEmpty()) {

            request.setAttribute("mensaje", "Debe completar las fechas.");
            request.getRequestDispatcher("ReporteDeUsuarios.jsp").forward(request, response);
            return;
        }

        try {
            Date desde = Date.valueOf(desdeUsuario);
            Date hasta = Date.valueOf(hastaUsuario);

            ReporteNegocioImpl negocio = new ReporteNegocioImpl();

            int totalUsuarios = negocio.obtenerTotalUsuarios();
            int nuevosUsuarios = negocio.obtenerNuevosUsuarios(desde, hasta);

            request.setAttribute("totalUsuarios", totalUsuarios);
            request.setAttribute("nuevosUsuarios", nuevosUsuarios);

            request.setAttribute("desdeUsuarios", desdeUsuario);
            request.setAttribute("hastaUsuarios", hastaUsuario);

            request.getRequestDispatcher("ReporteDeUsuarios.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("mensaje", "Ocurrió un error al procesar la solicitud.");
            request.getRequestDispatcher("ReporteDeUsuarios.jsp").forward(request, response);
        }
    }
}
