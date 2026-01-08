package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import negocioImpl.CuentaNegocioImpl;
import negocioImpl.TransferenciaNegocioImpl;

import java.io.IOException;
import java.util.List;

import entidades.Cuenta;
import entidades.TipoMovimiento;
import entidades.Usuario;


@WebServlet("/ServletTransferencia")
public class ServletTransferencia extends HttpServlet {
	private static final long serialVersionUID = 1L;

    // Instancias de las capas de negocio
    private CuentaNegocioImpl cuentaNegocio = new CuentaNegocioImpl();
    private TransferenciaNegocioImpl transferenciaNegocio = new TransferenciaNegocioImpl();

    public ServletTransferencia() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {

    	String accion = request.getParameter("accion");

        if (accion.equals("accion")) {

        	// Obtengo el usuario logeado de la session
        	Usuario u = (Usuario) request.getSession().getAttribute("usuarioLogueado");

            if (u == null) {
                response.sendRedirect("Login.jsp");
                return;
            }

            try {
                // Obtengo el id del cliente usando el id del usuario
                int usuarioId = u.getUsuarioId();
                int clienteId = cuentaNegocio.obtenerClientePorUsuario(usuarioId);

                // Cargo la lista de cuentas y los tipos de movimientos
                List<Cuenta> listaCuentas = cuentaNegocio.obtenerCuentasPorCliente(clienteId);
                List<TipoMovimiento> tiposMovimiento = transferenciaNegocio.obtenerTipoMovimiento();

                // Envio los datos al JSP
                request.setAttribute("listaCuentas", listaCuentas);
                request.setAttribute("tiposMovimientos", tiposMovimiento);

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Error al cargar cuentas del cliente.");
            }
        }

        request.getRequestDispatcher("Transferencias.jsp").forward(request, response);
    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String accion = request.getParameter("accion");

        try {
            // Transferencia entre cuentas propias
            if (accion.equals("propias")) {

                int origen = Integer.parseInt(request.getParameter("cuentaOrigen"));
                int destino = Integer.parseInt(request.getParameter("cuentaDestino"));
                double importe = Double.parseDouble(request.getParameter("importe"));
                int motivo = Integer.parseInt(request.getParameter("Motivo"));

                // Ejecuto a negocio
                transferenciaNegocio.transferirPropias(origen, destino, importe, motivo);

                request.setAttribute("mensaje", "Transferencia realizada con éxito");

            // Transferencia a terceros
            }else if(accion.equals("terceros")) {

            	int origen = Integer.parseInt(request.getParameter("cuentaOrigen"));
            	String cbuAlias = request.getParameter("cbuAlias");
                double importe = Double.parseDouble(request.getParameter("importe"));
                int motivo = Integer.parseInt(request.getParameter("Motivo"));

                transferenciaNegocio.transferirTerceros(origen, cbuAlias, importe, motivo);

                request.setAttribute("mensaje", "Transferencia realizada con éxito");
            }

        } catch (Exception e) {
            // Si algo falla muestro el error en pantalla
            request.setAttribute("error", e.getMessage());
        }

        // Luego de la transferencia vuelvo a cargar las cuentas actualizadas
        try {
            Usuario u = (Usuario) request.getSession().getAttribute("usuarioLogueado");
            int clienteId = cuentaNegocio.obtenerClientePorUsuario(u.getUsuarioId());

            List<Cuenta> listaCuentas = cuentaNegocio.obtenerCuentasPorCliente(clienteId);
            List<TipoMovimiento> tiposMovimiento = transferenciaNegocio.obtenerTipoMovimiento();

            request.setAttribute("listaCuentas", listaCuentas);
            request.setAttribute("tiposMovimientos", tiposMovimiento);

        } catch (Exception e) {
            request.setAttribute("error", "Error al cargar cuentas luego de la transferencia.");
        }

        // Redirige al JSP con los datos actualizados
        request.getRequestDispatcher("Transferencias.jsp").forward(request, response);
    }
}
