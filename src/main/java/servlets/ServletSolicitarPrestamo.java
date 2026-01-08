package servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import negocioImpl.CuentaNegocioImpl;
import negocioImpl.PrestamosNegocioImpl;

import java.io.IOException;
import java.util.List;

import entidades.Cliente;
import entidades.Cuenta;
import entidades.Prestamos;
import entidades.TipoPrestamo;
import entidades.Usuario;

/**
 * Servlet implementation class ServletSolicitarPrestamo
 */
@WebServlet("/ServletSolicitarPrestamo")
public class ServletSolicitarPrestamo extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PrestamosNegocioImpl pNegocio = new PrestamosNegocioImpl();
	private CuentaNegocioImpl cNeg = new CuentaNegocioImpl();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletSolicitarPrestamo() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String opc = request.getParameter("opc");

	    if(opc != null && opc.equals("solicitarPrestamo")) {
	    	
	        // Obtener el usuario logueado
	        Usuario u = (Usuario) request.getSession().getAttribute("usuarioLogueado");
	        if (u == null) {
	            response.sendRedirect("Login.jsp");
	            return;
	        }
	        
	        // Obtener cuentas del cliente
	        List<Cuenta> listaCuentas = cNeg.obtenerCuentasPorUsuario(u.getUsuarioId());
	        List<TipoPrestamo> tipoPrestamo = pNegocio.obtenerTipoPrestamos();
	        
	        // Enviar la lista al JSP
	        request.setAttribute("listaCuentas", listaCuentas);
	        request.setAttribute("tiposPrestamo", tipoPrestamo);
	        // Forward al JSP
	        RequestDispatcher rd = request.getRequestDispatcher("SolicitarPrestamo.jsp");
	        rd.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (request.getParameter("btnSolicitarPrestamo") != null) {

	        try {
	        	int clienteId = Integer.parseInt(request.getParameter("cliente_id"));
	        	int monto = Integer.parseInt(request.getParameter("monto"));
	        	int cuotas = Integer.parseInt(request.getParameter("cuotas"));
	        	int tipoPrestamoId = Integer.parseInt(request.getParameter("TipoPrestamo"));
	        	int cuentaId = Integer.parseInt(request.getParameter("cuenta_id"));

	        	Prestamos prestamo = new Prestamos();
	        	prestamo.setMontoPedido(monto);
	        	prestamo.setNroCuotas(cuotas);

	        	double cuotaMensual = (double) monto / cuotas;
	        	prestamo.setCuotaMensual(cuotaMensual);
	        	prestamo.setCuentaDestino(cuentaId);

	        	Cliente cli = new Cliente();
	        	cli.setClienteId(clienteId);
	        	prestamo.setClienteId(cli);

	        	TipoPrestamo tp = new TipoPrestamo();
	        	tp.setTipo_prestamo_id(tipoPrestamoId);
	        	prestamo.setTipo_prestamo_id(tp);

	        	boolean ok = pNegocio.crearPrestamo(prestamo);

	        	Usuario u = (Usuario) request.getSession().getAttribute("usuarioLogueado");

	        	List<Cuenta> listaCuentas = cNeg.obtenerCuentasPorUsuario(u.getUsuarioId());
	        	List<TipoPrestamo> tipoPrestamo = pNegocio.obtenerTipoPrestamos();

	        	request.setAttribute("listaCuentas", listaCuentas);
	        	request.setAttribute("tiposPrestamo", tipoPrestamo);

	            if (ok) {
	                request.setAttribute("mensajeExito", "Prestamo solicitado con exito.");
	                RequestDispatcher rd = request.getRequestDispatcher("SolicitarPrestamo.jsp");
	                rd.forward(request, response);
	            } else {
	                request.setAttribute("mensajeError", "Error al solicitar préstamo.");
	                RequestDispatcher rd = request.getRequestDispatcher("SolicitarPrestamo.jsp");
	                rd.forward(request, response);
	            }

	        } catch (Exception ex) {
	            ex.printStackTrace();
	            request.setAttribute("mensaje", "Ocurrio un error inesperado.");
	            RequestDispatcher rd = request.getRequestDispatcher("SolicitarPrestamo.jsp");
	            rd.forward(request, response);
	        }
	    }
	}

}
