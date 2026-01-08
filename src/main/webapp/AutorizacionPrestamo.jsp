<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="entidades.Prestamos"%>
<%@page import="entidades.Cliente"%>
<%@page import="entidades.TipoPrestamo"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Autorizacion de Prestamo</title>

<style>
body{
	    font-family: sans-serif;
        margin: 0;
        padding: 20px;
        background-color: #d9d9d9;
	}
	
	h1{
	    margin-bottom: 30px;
	}
	
	.contenedor{
	    width: 90%;
	    margin: 0 auto;
	}
	
    .buscar {
        display: flex;
        align-items: center;
        gap: 10px;
        justify-content: center;
        margin-bottom: 20px;
    }

    .buscar label {
        font-size: 16px;
    }

    .buscar input[type="text"] {
        padding: 6px;
        width: 200px;
        border: 1px solid #555;
        border-radius: 4px;
    }
	
    .boton {
    	font-size: 15px;
    	font-family: "Segoe UI", Arial, sans-serif;
        background: #6ed6e8;
        font-weight: bold;
        color: black;
        border: none;
        padding: 10px;
        width: 150px;
        cursor: pointer;
        border-radius: 4px;
    }

    .boton:hover {
        background: #8F9ADD;
    }
	
	.mensaje{
	    color: red;
	    margin: 15px 0;
	}
	
	.tabla-contenedor{
	    background: white;
	    border: 1px solid #222;
	    height: 350px;
	    padding: 10px;
	}
	
	table{
	    width: 100%;
	    border-collapse: collapse;
	}
	
	th, td{
	    border: 1px solid #ccc;
	    padding: 8px;
	    text-align: center;
	}
	
	th{
	    background: #e5e5e5;
	}
	
    .menu-container {
        position: relative;
        float: right;
        margin-right: 30px;
    }

    .menu-btn {
        border: 2px solid gray;
        background: #6ed6e8;
        padding: 6px 20px;
        cursor: pointer;
        border-radius: 15%;

    }
       
    .menu-icono {
        width: 30px;
        height: 30px;
    }
    

    .menu-content {
        display: none;
        position: absolute;
        right: 0;
        background-color: white;
        min-width: 160px;
        box-shadow: 0px 8px 16px rgba(0,0,0,0.2);
        z-index: 10;
    }

    .menu-container:hover .menu-content {
        display: block;
    }

    .menu-content a {
        color: black;
        padding: 12px 16px;
        text-decoration: none;
        display: block;
    }

    .menu-content a:hover {
        background-color: #ddd;
    }
    
    .mensaje {
    padding: 10px;
    margin-bottom: 15px;
    border-radius: 4px;
    font-weight: bold;
	}
	
	.mensaje.exito {
	    background: #d4edda;
	    color: #155724;
	    border: 1px solid #c3e6cb;
	}
	
	.mensaje.error {
	    background: #f8d7da;
	    color: #721c24;
	    border: 1px solid #f5c6cb;
	}
</style>
</head>

<body>

	<div class="menu-container">
	    <button class="menu-btn">
	    	<img src="https://cdn-icons-png.flaticon.com/512/1828/1828859.png" alt="Menú" class="menu-icono" />
	    </button>
	    <div class="menu-content">
	        <a href="InicioMenuAdministrador.jsp">Volver al menu anterior</a>
	        <a href="ABMLMenu.jsp">Menu Clientes</a>
	        <a href="ABMLCuentas.jsp">Menu Cuentas</a>
			<a href="Reportes.jsp">Reportes</a>
	    </div>
	</div>
	
	<div class="contenedor">
	    <h1>Autorizacion de Prestamos</h1>
		
		<br><br>

			<!-- Buscar por DNI -->
		<form action="ServletPrestamos" method="get">
		    <div class="buscar">
		        <label>Ingrese DNI del cliente:</label>
		        <input type="text" name="txtBuscar" maxlength="8" pattern="\d{7,8}">
		
		        <button type="submit" name="accion" value="filtrar" class="boton">Filtrar</button>
		        <button type="submit" name="accion" value="listar" class="boton">Mostrar todos</button>
		    </div>
		</form>



	    <br><br>

<%
	List<Prestamos> prestamos = (List<Prestamos>) request.getAttribute("prestamos");


    int pagina = 1;
    int pageSize = 10;

    if (request.getParameter("page") != null) {
        pagina = Integer.parseInt(request.getParameter("page"));
    }

    if (prestamos != null && !prestamos.isEmpty()) {

        int totalPrestamos = prestamos.size();
        int totalPaginas = (int) Math.ceil((double) totalPrestamos / pageSize);

        int inicio = (pagina - 1) * pageSize;
        int fin = Math.min(inicio + pageSize, totalPrestamos);
%>

<form action="ServletPrestamos" method="post">
    <div class="tabla-contenedor">
	    <%
		    String msg = (String) request.getAttribute("mensaje");
		    String tipo = (String) request.getAttribute("tipoMensaje");
		
		    if (msg != null) {
		%>
		    <div class="mensaje <%= tipo %>">
		        <%= msg %>
		    </div>
		<%
		    }
		%>
		    
        <table>
            <thead>
                <tr>
                    <th>Aceptar/Rechazar</th>
                    <th>Nro Préstamo</th>
                    <th>Nombre Cliente</th>
                    <th>Apellido Cliente</th>
                    <th>Cuenta Destino</th>
                    <th>Monto Solicitado</th>
                    <th>Cant. Cuotas</th>
                    <th>Cuota Mensual</th>
                    <th>Saldo Restante</th>
                    <th>Fecha Solicitud</th>
                    <th>Tipo de Préstamo</th>
                    <th>Estado</th>
                </tr>
            </thead>

            <tbody>
                <%
                    for (int i = inicio; i < fin; i++) {
                        Prestamos p = prestamos.get(i);
                %>
                <tr>
                    <td>
                        <input type="radio" name="prestamoId" value="<%= p.getPrestamoId() %>">
                    </td>
                    <td><%= p.getPrestamoId() %></td>
                    <td><%= p.getClienteId().getNombre() %></td>
                    <td><%= p.getClienteId().getApellido() %></td>
                    <td><%= p.getCuentaDestino() %></td>
                    <td>$ <%= p.getMontoPedido() %></td>
                    <td><%= p.getNroCuotas() %></td>
                    <td>$ <%= p.getCuotaMensual() %></td>
                    <td>$ <%= p.getSaldoRestante() %></td>
                    <td><%= p.getFecha() %></td>
                    <td><%= p.getTipo_prestamo_id().getDescripcion() %></td>
                    <td><%= p.getEstado() %></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>

    <div class="buscar">
        <button type="submit" name="accion" value="autorizar" class="boton">Autorizar</button>
        <button type="submit" name="accion" value="rechazar" class="boton">Rechazar</button>
    </div>
</form>


	<br><br>


<%
    } else {
%>

	<p class="mensaje">No se encontraron préstamos.</p>

<%
    }
%>

	</div>
</body>
</html>
