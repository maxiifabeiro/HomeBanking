package servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import negocioImpl.ClientesNegocioImpl;
import negocioImpl.CuentaNegocioImpl;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import entidades.Cliente;
import entidades.Cuenta;
import entidades.TipoCuenta;



/**
 * Servlet implementation class ServletCuenta
 */
@WebServlet("/ServletCuenta")
public class ServletCuenta extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private CuentaNegocioImpl cNegocio = new CuentaNegocioImpl();
    private ClientesNegocioImpl cliNegocio = new ClientesNegocioImpl();
    public ServletCuenta() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String opc = request.getParameter("opc");

	    if (opc != null && opc.equals("agregar")) {

	        // Si presionó Buscar
	        if (request.getParameter("btnBuscar") != null) {

	            String dni = request.getParameter("dniCliente");
	            Cliente cliente = cliNegocio.obtenerClienteDni(dni);

	            if (cliente != null) {
	                request.setAttribute("nombreCliente", cliente.getNombre());
	                request.setAttribute("apellidoCliente", cliente.getApellido());
	                request.setAttribute("DNICliente", cliente.getDni());
	                request.setAttribute("clienteEncontrado", cliente);
	            } else {
	                request.setAttribute("mensajeError", "No existe cliente con ese DNI.");
	            }
	        }

	        // Cargar tipos de cuenta
	        List<TipoCuenta> tipos = cNegocio.obtenerTipoCuenta();
	        request.setAttribute("tipocuentas", tipos);

	        // Generar CBU automaticamente
	        String cbu = cNegocio.generarCBU();
	        request.setAttribute("cbuGenerado", cbu);
	        
	        // Generar Alias automaticamente
	        String alias = cNegocio.generarAlias();
	        request.setAttribute("aliasGenerado", alias);
	        
	        RequestDispatcher rd = request.getRequestDispatcher("AgregarCuenta.jsp");
	        rd.forward(request, response);
	    }else if (opc != null && opc.equals("listar")) {

	        // Si presiona FILTRAR
	        if (request.getParameter("btnFiltrar") != null) {
	            String dni = request.getParameter("dniCuenta");
	            List<Cuenta> cuenta = cNegocio.obtenerCuentaPorDni(dni);
	            if (cuenta != null && !cuenta.isEmpty()) {
	                request.setAttribute("Cuentas", cuenta);
	            } else {
	                request.setAttribute("mensajeError", "No existe cliente con ese DNI.");
	            }
	        }

	        // Si presiona MOSTRAR TODOS
	        if (request.getParameter("btnTodos") != null) {
	            List<Cuenta> lista = cNegocio.obtenerCuentas();
	            request.setAttribute("Cuentas", lista); 
	        }

	        RequestDispatcher rd = request.getRequestDispatcher("ListadoCuentas.jsp");
	        rd.forward(request, response);
	    }
	  //LISTAR cuentas en ModificarCuentaMenu
	    else if (opc != null && opc.equals("listarModificar")) {

	        // Si presiona FILTRAR
	    	if (request.getParameter("btnFiltrar") != null) {
		        String dni = request.getParameter("dniCuenta");
		        List<Cuenta> cuentas = cNegocio.obtenerCuentaPorDni(dni);
		        if (cuentas != null && !cuentas.isEmpty()) {
		            request.setAttribute("Cuentas", cuentas);
		        } else {
		            request.setAttribute("mensajeError", "No existe cliente con ese DNI.");
		        }
		    }
	    	
	    	// Si presiona MOSTRAR TODOS
		    if (request.getParameter("btnTodos") != null) {
		        List<Cuenta> lista = cNegocio.obtenerCuentas();
		        request.setAttribute("Cuentas", lista);
		    }
		
		    RequestDispatcher rd = request.getRequestDispatcher("ModificarCuentaMenu.jsp");
		    rd.forward(request, response);

	    }
	    
	    //IR A MODIFICAR
	    else if(opc != null && opc.equals("modificar")) {
	    	
	    	String id = request.getParameter("idCuenta");
	    	
	    	if (id != null) {
		    	int idCuenta = Integer.parseInt(id);
		        Cuenta cuenta = cNegocio.obtenerCuentaPorId(idCuenta);
		        if (cuenta != null) {
		            Cliente cliente = cuenta.getCliente();
		            request.setAttribute("nombreCliente", cliente.getNombre());
		            request.setAttribute("apellidoCliente", cliente.getApellido());
		            request.setAttribute("DNICliente", cliente.getDni());
		            request.setAttribute("cbu", cuenta.getCbu());
		            request.setAttribute("alias", cuenta.getAlias());
		            request.setAttribute("saldoCuenta", cuenta.getSaldo());
		            request.setAttribute("fechaCuenta", cuenta.getFecha_creacion());         
		            request.setAttribute("tipocuentas", cNegocio.obtenerTipoCuenta());
		            request.setAttribute("tipoCuentaSeleccionada", cuenta.getTipoCuenta().getTipoCuenta_id());
		            request.setAttribute("idCuenta", idCuenta);
		        } else {
		            request.setAttribute("mensajeError", "No se encontró la cuenta.");
		        }
		    }
	        
		    RequestDispatcher rd = request.getRequestDispatcher("ModificarCuenta.jsp");
		    rd.forward(request, response);

	    }else if(opc.equals("eliminar")) {
	    	
	    	String mensajeError = request.getParameter("mensajeError");
	    	
	    	if(request.getParameter("btnBuscar") != null) {
	    		String dni = request.getParameter("DniCliente");
    			Cliente cliente = cliNegocio.obtenerClienteDni(dni);
    			
	    			if (cliente != null) {
	    				List<Cuenta> listCuentas = cNegocio.obtenerCuentaPorDni(dni);
		    				if (listCuentas != null && !listCuentas.isEmpty()) {
		    					request.setAttribute("cuentas", listCuentas);
		    				}
	    	        } else {
	    	            request.setAttribute("mensajeError", "No existe ese cliente.");
	    	        }
				} 
			RequestDispatcher rd = request.getRequestDispatcher("EliminarCuenta.jsp");
			rd.forward(request, response);
	    }

    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String opc = request.getParameter("opc");
		
		if (request.getParameter("btnAgregar") != null) {

	        try {
	            String dni = request.getParameter("dniCliente");
	            Cliente cliente = cliNegocio.obtenerClienteDni(dni);

	            if (cliente == null) {
	                request.setAttribute("mensajeError", "Debe buscar un cliente valido.");
	            } else {

	                Cuenta cuenta = new Cuenta();
	                cuenta.setCliente(cliente);

	                cuenta.setAlias(request.getParameter("AliasCuenta"));
	                cuenta.setCbu(request.getParameter("CBUCliente"));
	                cuenta.setSaldo(new BigDecimal(request.getParameter("saldoCuenta")));

	                // Fecha
	                String fecha = request.getParameter("fechaCuenta");
	                cuenta.setFecha_creacion(java.sql.Date.valueOf(fecha));

	                // Tipo de cuenta
	                int tipoCuentaId = Integer.parseInt(request.getParameter("tipoCuenta"));
	                TipoCuenta tc = new TipoCuenta();
	                tc.setTipoCuenta_id(tipoCuentaId);
	                cuenta.setTipoCuenta(tc);

	                try {
	                    boolean exito = cNegocio.agregarCuenta(cuenta);

	                    if (exito) {
	                        request.setAttribute("mensajeExito", "Cuenta creada correctamente.");
	                    }

	                } catch (Exception ex) {
	                    request.setAttribute("mensajeError", ex.getMessage());
	                }
	            }

	        } catch (Exception e) {
	            request.setAttribute("mensajeError", "Datos invalidos.");
	        }
	        
	        // Recargar combos y CBU
	        List<TipoCuenta> tipos = cNegocio.obtenerTipoCuenta();
	        request.setAttribute("tipocuentas", tipos);

	        String cbu = cNegocio.generarCBU();
	        request.setAttribute("cbuGenerado", cbu);
	        
	        String alias = cNegocio.generarAlias();
	        request.setAttribute("aliasGenerado", alias);
	        
	        RequestDispatcher rd = request.getRequestDispatcher("AgregarCuenta.jsp");
	        rd.forward(request, response);
		}
		
		//MODIFICAR CUENTA enviar datos modificados
		if (opc != null && opc.equals("guardarModificacion")) {
		    try {
		        int idCuenta = Integer.parseInt(request.getParameter("idCuenta"));
		        Cuenta cuenta = cNegocio.obtenerCuentaPorId(idCuenta);
		
		        if (cuenta != null) {
		            cuenta.setCbu(request.getParameter("CBUCliente"));
		            cuenta.setAlias(request.getParameter("AliasCuenta"));
		            cuenta.setSaldo(new BigDecimal(request.getParameter("saldoCuenta")));
		            
		            // Fecha
	                String fecha = request.getParameter("fechaCuenta");
	                cuenta.setFecha_creacion(java.sql.Date.valueOf(fecha));
		
		            
	                // Tipo de cuenta
	                int tipoCuentaId = Integer.parseInt(request.getParameter("tipoCuenta"));
	                TipoCuenta tc = new TipoCuenta();
	                tc.setTipoCuenta_id(tipoCuentaId);
	                cuenta.setTipoCuenta(tc);
		
	                cNegocio.modificarCuenta(cuenta);
		            request.setAttribute("mensajeExito", "Cuenta modificada correctamente.");
		        } else {
		            request.setAttribute("mensajeError", "No se encontró la cuenta.");
		        }
		    } catch (Exception e) {
		        request.setAttribute("mensajeError", "Error al modificar");
		    }
		    request.getRequestDispatcher("ModificarCuentaMenu.jsp").forward(request, response);
		}else if(opc.equals("eliminar")) {
			if(request.getParameter("btnEliminar") != null) {
				
				int id = Integer.parseInt(request.getParameter("cuentaId").toString());
				boolean resultado = cNegocio.eliminarCuenta(id);
				
				if (resultado) {
		            request.setAttribute("mensajeExito", "Cuenta eliminada exitosamente.");
		        } else {
		            request.setAttribute("mensajeError", "Error al eliminar cuenta.");
		        }
			}
			
			RequestDispatcher rd = request.getRequestDispatcher("EliminarCuenta.jsp");
	        rd.forward(request, response);
		} 
	}
}
