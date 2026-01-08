package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import negocioImpl.MovimientosNegocioImpl;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import daoImpl.MovimientosDaoImpl;
import entidades.Movimientos;
import entidades.Usuario;

@WebServlet("/ServletDescargarMovimientos")
public class ServletDescargarMovimientos extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public ServletDescargarMovimientos() {
        super();
        // TODO Auto-generated constructor stub
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        Usuario usuario = (Usuario) request.getSession().getAttribute("usuarioLogueado");
        int idCliente = usuario.getUsuarioId(); 
        if (accion != null && accion.equalsIgnoreCase("descargar")) {
        	MovimientosNegocioImpl mNeg = new MovimientosNegocioImpl();
            List<Movimientos> lista = mNeg.listarMovimientosPorCliente(idCliente);

            // Configurar el archivo a descargar
            response.setContentType("text/csv");
            response.setHeader("Content-Disposition", "attachment; filename=movimientos.csv");

            PrintWriter writer = response.getWriter();

            // Cabecera del CSV
            writer.println("ID Movimiento,Fecha,Monto,Cuenta Origen,Cuenta Destino,Saldo,Estado");

            // Escribir cada movimiento
            for (Movimientos m : lista) {

                int origen = 0;
                int destino = 0;
                String estado = "-";

                if (m.getTransferenciaId() != null) {
                    origen = m.getTransferenciaId().getCuenta_origen();
                    destino = m.getTransferenciaId().getCuenta_destino();
                    estado = m.getTransferenciaId().getEstado();
                }

                writer.println(
                        m.getMovimientoId() + "," +
                        m.getFecha() + "," +
                        m.getImporte() + "," +
                        origen + "," +
                        destino + "," +
                        (m.getCuentaId() != null ? m.getCuentaId().getSaldo() : "0") + "," +
                        estado
                );
            }

            writer.flush();
            writer.close();
            
            request.setAttribute("movimientos", lista);
            request.getRequestDispatcher("Movimientos.jsp").forward(request, response);
        }
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
