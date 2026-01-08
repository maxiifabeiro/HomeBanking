package servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import negocioImpl.CuentaNegocioImpl;
import negocioImpl.PrestamosNegocioImpl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import entidades.Cuota;
import entidades.Prestamos;
import entidades.Usuario;

@WebServlet("/ServletPagarPrestamo")
public class ServletPagarPrestamo extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ServletPagarPrestamo() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
    	String opc = request.getParameter("opc");
        PrestamosNegocioImpl pneg = new PrestamosNegocioImpl();

        if (opc == null) {
            response.sendRedirect("ServletPagarPrestamo?opc=listarPrestamos");
            return;
        }

        // Mostrar préstamos del cliente logueado
        if (opc.equals("listarPrestamos")) {
            HttpSession session = request.getSession();
            Usuario u = (Usuario) session.getAttribute("usuarioLogueado");

            if (u == null) {
                response.sendRedirect("Login.jsp");
                return;
            }

            try {
                Integer clienteId = (Integer) session.getAttribute("clienteId");
                List<Prestamos> prestamos = pneg.obtenerPrestamosPorCliente(clienteId);
                
                // Separar en activos y pagados
                List<Prestamos> activos = new ArrayList<>();
                List<Prestamos> pagados = new ArrayList<>();
                for (Prestamos p : prestamos) {
                    if ("pagado".equalsIgnoreCase(p.getEstado())) {
                        pagados.add(p);
                    } else if ("activo".equalsIgnoreCase(p.getEstado()) || "autorizado".equalsIgnoreCase(p.getEstado())) {
                        activos.add(p);
                    }
                }

                request.setAttribute("PrestamosActivos", activos);
                request.setAttribute("PrestamosPagados", pagados);

                String mensaje = (String) session.getAttribute("mensaje");
                if (mensaje != null) {
                    request.setAttribute("mensaje", mensaje);
                    session.removeAttribute("mensaje");
                }

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Error al cargar préstamos del cliente.");
            }

            RequestDispatcher rd = request.getRequestDispatcher("PagoPrestamo.jsp");
            rd.forward(request, response);

        }

        // Mostrar cuotas de un préstamo para poder pagarlas
        else if (opc.equals("pagarCuota")) {
            int prestamoId = Integer.parseInt(request.getParameter("prestamoId"));

            Prestamos p = pneg.obtenerPrestamoPorId(prestamoId);
            List<Cuota> cuotas = pneg.obtenerCuotasPorPrestamo(prestamoId);

            request.setAttribute("Prestamo", p);
            request.setAttribute("Cuotas", cuotas);

            RequestDispatcher rd = request.getRequestDispatcher("PagarCuotas.jsp");
            rd.forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String opc = request.getParameter("opc");
        PrestamosNegocioImpl pneg = new PrestamosNegocioImpl();

        if ("realizarPago".equals(opc)) {

            int prestamoId = Integer.parseInt(request.getParameter("prestamoId"));
            int cuentaId = Integer.parseInt(request.getParameter("cuentaId")); // 🔴 IMPORTANTE
            String[] cuotasSeleccionadas = request.getParameterValues("cuotaSeleccionada");

            if (cuotasSeleccionadas == null) {
                request.setAttribute("error", "Debe seleccionar al menos una cuota para pagar.");

                Prestamos p = pneg.obtenerPrestamoPorId(prestamoId);
                List<Cuota> cuotas = pneg.obtenerCuotasPorPrestamo(prestamoId);

                request.setAttribute("Prestamo", p);
                request.setAttribute("Cuotas", cuotas);

                request.getRequestDispatcher("PagarCuotas.jsp").forward(request, response);
                return;
            }

            try {
                for (String idStr : cuotasSeleccionadas) {
                    int cuotaId = Integer.parseInt(idStr);

                    boolean ok = pneg.pagarCuota(cuotaId, cuentaId);
                    if (!ok) {
                        throw new RuntimeException("Error al pagar la cuota " + cuotaId);
                    }
                }

                request.getSession().setAttribute("mensaje", "¡Pago realizado con éxito!");
                response.sendRedirect("ServletPagarPrestamo?opc=listarPrestamos");

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());

                Prestamos p = pneg.obtenerPrestamoPorId(prestamoId);
                List<Cuota> cuotas = pneg.obtenerCuotasPorPrestamo(prestamoId);

                request.setAttribute("Prestamo", p);
                request.setAttribute("Cuotas", cuotas);

                request.getRequestDispatcher("PagarCuotas.jsp").forward(request, response);
            }
        } else {
            doGet(request, response);
        }
    }

}