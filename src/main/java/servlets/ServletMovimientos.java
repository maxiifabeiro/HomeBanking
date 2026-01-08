package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import negocioImpl.CuentaNegocioImpl;
import negocioImpl.MovimientosNegocioImpl;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import entidades.Cuenta;
import entidades.Movimientos;
import entidades.Usuario;

/**
 * Servlet implementation class ServletMovimientos
 */
@WebServlet("/ServletMovimientos")
public class ServletMovimientos extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletMovimientos() {
        super();
        // TODO Auto-generated constructor stub
    }

    private MovimientosNegocioImpl mNeg = new MovimientosNegocioImpl();
    private CuentaNegocioImpl cNeg = new CuentaNegocioImpl();

    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Usuario usuario = (Usuario) request.getSession().getAttribute("usuarioLogueado");
        int idCliente = usuario.getUsuarioId();

        // Cuentas del cliente
        List<Cuenta> cuentasCliente = cNeg.obtenerCuentasPorClienteMovimientos(idCliente);
        request.setAttribute("listaCuentas", cuentasCliente);

        // Parametros
        String cuentaIdP = request.getParameter("cuenta");
        String desdeP = request.getParameter("desde");
        String hastaP = request.getParameter("hasta");

        Integer cuentaId = null;
        if (cuentaIdP != null && !cuentaIdP.isEmpty()) {
            cuentaId = Integer.parseInt(cuentaIdP);
        }

        List<Movimientos> movimientos = null;

        boolean hayFechas = (desdeP != null && !desdeP.isEmpty() &&
                             hastaP != null && !hastaP.isEmpty());

        // ---- Filtros ----
        if (cuentaId == null && !hayFechas) {
            movimientos = mNeg.listarMovimientosPorCliente(idCliente);
        } else if (cuentaId != null && !hayFechas) {
            movimientos = mNeg.listarMovimientosPorCuenta(cuentaId);
        } else if (cuentaId == null && hayFechas) {
            Date desde = Date.valueOf(desdeP);
            Date hasta = Date.valueOf(hastaP);
            movimientos = mNeg.listarMovimientosPorFechas(desde, hasta, idCliente);
        }

        request.setAttribute("movimientos", movimientos);
        request.getRequestDispatcher("Movimientos.jsp").forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
