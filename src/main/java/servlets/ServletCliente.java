package servlets;

import entidades.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import negocio.ClientesNegocio;
import negocioImpl.ClientesNegocioImpl;

import java.io.IOException;
import java.util.List;

@WebServlet("/ServletCliente")
public class ServletCliente extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ClientesNegocio clientesNegocio;

    public ServletCliente() {
        clientesNegocio = new ClientesNegocioImpl();
    }

    // ============================
    //           GET
    // ============================
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String opc = request.getParameter("opc");

        // ------------------------
        // ABRIR FORM AGREGAR
        // ------------------------
        if ("agregar".equals(opc)) {

            List<Pais> paises = clientesNegocio.obtenerPais();
            List<Pregunta> preguntas = clientesNegocio.obtenerPregunta();

            request.setAttribute("paises", paises);
            request.setAttribute("pregunta", preguntas);

            RequestDispatcher rd = request.getRequestDispatcher("AgregarCliente.jsp");
            rd.forward(request, response);
        }

        // ------------------------
        // AJAX - PROVINCIAS
        // ------------------------
        else if ("provincias".equals(opc)) {

            int paisId = Integer.parseInt(request.getParameter("paisId"));
            List<Provincias> provincias =
                    clientesNegocio.obtenerProvinciasPorPais(paisId);

            request.setAttribute("provincias", provincias);

            RequestDispatcher rd = request.getRequestDispatcher("AjaxProvincias.jsp");
            rd.forward(request, response);
        }

        // ------------------------
        // AJAX - LOCALIDADES
        // ------------------------
        else if ("localidades".equals(opc)) {

            int provinciaId = Integer.parseInt(request.getParameter("provinciaId"));
            List<Localidades> localidades =
                    clientesNegocio.obtenerLocalidadesPorProvincia(provinciaId);

            request.setAttribute("localidades", localidades);

            RequestDispatcher rd = request.getRequestDispatcher("AjaxLocalidades.jsp");
            rd.forward(request, response);
        }

        // ------------------------
        // ELIMINAR
        // ------------------------
        else if ("eliminar".equals(opc)) {

            if (request.getParameter("btnBuscar") != null) {

                String dni = request.getParameter("dniBuscar");
                Cliente cliente = clientesNegocio.obtenerClienteDni(dni);

                if (cliente != null) {
                    request.setAttribute("clienteEncontrado", cliente);
                } else {
                    request.setAttribute("mensaje", "No existe el cliente");
                }
            }

            RequestDispatcher rd = request.getRequestDispatcher("EliminarCliente.jsp");
            rd.forward(request, response);
        }

        // ------------------------
        // LISTAR
        // ------------------------
        else if ("listar".equals(opc)) {

            if (request.getParameter("btnFiltrar") != null) {
                String dni = request.getParameter("dniCliente");
                Cliente cliente = clientesNegocio.obtenerClienteDni(dni);

                if (cliente != null)
                    request.setAttribute("Clientes", List.of(cliente));
            }

            if (request.getParameter("btnTodos") != null) {
                List<Cliente> lista = clientesNegocio.obtenerClientes();
                request.setAttribute("Clientes", lista);
            }
            
            

            RequestDispatcher rd = request.getRequestDispatcher("ListarCliente.jsp");
            rd.forward(request, response);
        }

        // ------------------------
        // ABRIR MODIFICAR
        // ------------------------
        else if ("modificar".equals(opc)) {

        	List<Pais> paises = clientesNegocio.obtenerPais();
            request.setAttribute("paises", paises);

            if (request.getParameter("btnBuscar") != null) {

                String dni = request.getParameter("dniCliente");
                Cliente cliente = clientesNegocio.obtenerClienteDni(dni);

                if (cliente != null) {
                    request.setAttribute("cliente", cliente);
                } else {
                    request.setAttribute("mensajeError", "No existe el cliente con ese DNI.");
                }
            }

            RequestDispatcher rd =
                    request.getRequestDispatcher("ModificarCliente.jsp");

            rd.forward(request, response);
        }
    }


    // ============================
    //           POST
    // ============================
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String opc = request.getParameter("opc");

        // ------------------------
        // AGREGAR CLIENTE
        // ------------------------
        if ("agregar".equals(opc)) {

            String dni = request.getParameter("txtDNI");
            String cuil = request.getParameter("txtCUIT");
            String nombre = request.getParameter("txtNombre");
            String apellido = request.getParameter("txtApellido");
            char sexo = request.getParameter("txtSexo").charAt(0);

            String fechaNacimientoStr = request.getParameter("txtFechaNacimiento");
            java.sql.Date fechaNacimiento =
                    java.sql.Date.valueOf(fechaNacimientoStr);

            String direccion = request.getParameter("txtDireccion");
            int provinciaId = Integer.parseInt(request.getParameter("txtProvincia"));
            int localidadId = Integer.parseInt(request.getParameter("txtLocalidad"));
            String telefono = request.getParameter("txtTelefono");
            String email = request.getParameter("txtEmail");

            String nombreUsuario = request.getParameter("txtNombreUsuario");
            String clave = request.getParameter("txtContraseña");
            String respuesta = request.getParameter("txtRespuesta");

            int preguntaId =
                    Integer.parseInt(request.getParameter("txtPregunta"));

            // Objetos
            Provincias provincia = new Provincias();
            provincia.setProvincia_id(provinciaId);

            Localidades localidad = new Localidades();
            localidad.setLocalidad_id(localidadId);

            int paisId = Integer.parseInt(request.getParameter("txtPais"));
            Pais pais = new Pais();
            pais.setPais_id(paisId);
            
            TipoUsuario tipoUsuario = new TipoUsuario();
            tipoUsuario.setTipoUsuarioId(1);

            Usuario usuario = new Usuario();
            usuario.setNombreUsuario(nombreUsuario);
            usuario.setClave(clave);
            usuario.setRespuesta(respuesta);
            usuario.setTipoUsuario(tipoUsuario);

            Pregunta pregunta = new Pregunta();
            pregunta.setPregunta_id(preguntaId);

            Cliente cliente = new Cliente();
            cliente.setDni(dni);
            cliente.setCuil(cuil);
            cliente.setNombre(nombre);
            cliente.setApellido(apellido);
            cliente.setSexo(sexo);
            cliente.setPais(pais);
            cliente.setFechaNacimiento(fechaNacimiento);
            cliente.setDireccion(direccion);
            cliente.setProvincia(provincia);
            cliente.setLocalidad(localidad);
            cliente.setTelefono(telefono);
            cliente.setCorreoElectronico(email);
            cliente.setUsuario(usuario);
            cliente.setPregunta_id(pregunta);

            boolean ok = clientesNegocio.agregarCliente(cliente);

            if(ok)
                request.setAttribute("mensajeExito","Cliente agregado correctamente");
            else
                request.setAttribute("mensajeError","Error al agregar");

            request.setAttribute("paises", clientesNegocio.obtenerPais());
            request.setAttribute("pregunta", clientesNegocio.obtenerPregunta());

            RequestDispatcher rd =
                request.getRequestDispatcher("AgregarCliente.jsp");

            rd.forward(request,response);
        }


        // ------------------------
        // ELIMINAR CLIENTE
        // ------------------------
        else if ("eliminar".equals(opc)
            && request.getParameter("btnEliminar") != null) {

            int id =
              Integer.parseInt(request.getParameter("clienteId"));

            boolean ok = clientesNegocio.eliminarCliente(id);

            if(ok)
                response.sendRedirect(
                    "EliminarCliente.jsp?mensajeExito=Cliente eliminado");
            else
                response.sendRedirect(
                    "EliminarCliente.jsp?mensajeError=Error al eliminar");
        }


        // ------------------------
        // MODIFICAR CLIENTE
        // ------------------------
        else if("modificar".equals(opc) && request.getParameter("btnModificar") != null) {

            int clienteId = Integer.parseInt(request.getParameter("clienteId"));
            int usuarioId = Integer.parseInt(request.getParameter("usuarioId"));

            String dni = request.getParameter("txtDNI");
            String cuil = request.getParameter("txtCUIT");
            String nombre = request.getParameter("txtNombre");
            String apellido = request.getParameter("txtApellido");
            char sexo = request.getParameter("txtSexo").charAt(0);

            java.sql.Date fechaNacimiento = java.sql.Date.valueOf(request.getParameter("txtFechaNacimiento"));
            String direccion = request.getParameter("txtDireccion");
            String telefono = request.getParameter("txtTelefono");
            String email = request.getParameter("txtEmail");

            int provinciaId = Integer.parseInt(request.getParameter("txtProvincia"));
            int localidadId = Integer.parseInt(request.getParameter("txtLocalidad"));
            int paisId = Integer.parseInt(request.getParameter("txtPais"));
            String nombreUsuario = request.getParameter("txtNombreUsuario");

            // Objetos
            Provincias p = new Provincias();
            p.setProvincia_id(provinciaId);

            Localidades l = new Localidades();
            l.setLocalidad_id(localidadId);

            Pais pais = new Pais();
            pais.setPais_id(paisId);

            Usuario u = new Usuario();
            u.setUsuarioId(usuarioId);
            u.setNombreUsuario(nombreUsuario);

            Cliente c = new Cliente();
            c.setClienteId(clienteId);
            c.setDni(dni);
            c.setCuil(cuil);
            c.setNombre(nombre);
            c.setApellido(apellido);
            c.setSexo(sexo);
            c.setPais(pais);
            c.setFechaNacimiento(fechaNacimiento);
            c.setDireccion(direccion);
            c.setTelefono(telefono);
            c.setCorreoElectronico(email);
            c.setProvincia(p);
            c.setLocalidad(l);
            c.setUsuario(u);

            boolean ok = clientesNegocio.modificarCliente(c);

            if (ok)
                request.setAttribute("mensajeExito", "Cliente modificado correctamente");
            else
                request.setAttribute("mensajeError", "Error al modificar");

            Cliente clienteActualizado = clientesNegocio.obtenerClienteDni(dni);
            request.setAttribute("cliente", clienteActualizado);

            // listas
            request.setAttribute("paises", clientesNegocio.obtenerPais());
            request.setAttribute("provincias",
                    clientesNegocio.obtenerProvinciasPorPais(paisId));
            request.setAttribute("localidades",
                    clientesNegocio.obtenerLocalidadesPorProvincia(provinciaId));

            RequestDispatcher rd =
                request.getRequestDispatcher("ModificarCliente.jsp");
            rd.forward(request, response);

        }
    }
}
