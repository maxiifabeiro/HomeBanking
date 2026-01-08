<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="entidades.Prestamos" %>
<%@ page import="entidades.Cuota" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pagar Cuotas</title>
<style>
    body {
        font-family: 'Segoe UI', sans-serif;
        background-color: #f5f5f5;
        margin: 0;
        padding: 20px;
    }
    .container {
        background-color: #fff;
        border: 1px solid #ccc;
        padding: 20px;
        width: 700px;
        margin: auto;
        border-radius: 6px;
    }
    .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    h3 { color: blue; font-size: 30px; }
    .logo { display: flex; align-items: center; gap: 8px; }
    .logo img { width: 60px; height: 60px; }
    .info { font-size: 16px; margin-top: 10px; font-weight: bold; }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
        font-size: 14px;
    }
    th, td {
        border-bottom: 1px solid #ccc;
        padding: 8px;
        text-align: center;
    }
    th { background-color: #eee; }

    .btn-pagar {
        margin-top: 20px;
        background-color: #3ddc84;
        border: none;
        padding: 10px 25px;
        border-radius: 4px;
        font-weight: bold;
        color: #fff;
        cursor: pointer;
    }
    .btn-pagar:hover { background-color: #34c374; }

    .menu-container {
        position: absolute;
        top: 15px;
        right: 15px;
    }
    .menu-btn {
        background-color: white;
        border: 1px solid #444;
        padding: 6px 12px;
        cursor: pointer;
        border-radius: 4px;
    }
    .menu-content {
        display: none;
        position: absolute;
        right: 0;
        background-color: white;
        border: 1px solid #ccc;
        margin-top: 5px;
        border-radius: 4px;
    }
    .menu-content a {
        display: block;
        padding: 8px 12px;
        text-decoration: none;
        color: black;
    }
    .menu-content a:hover { background-color: #eee; }
    .menu-container:hover .menu-content { display: block; }

    .mensaje-ok { color: green; margin-top: 10px; font-weight: bold; }
    .mensaje-error { color: red; margin-top: 10px; font-weight: bold; }
</style>
</head>

<body>

<%
    Prestamos prestamo = (Prestamos) request.getAttribute("Prestamo");
    List<Cuota> cuotas = (List<Cuota>) request.getAttribute("Cuotas");
%>
    <div class="container">
        <div class="header">
            <div class="logo">
                <img src="images/Logo.png" alt="Logo">
                <h3>HomeBanking</h3>
            </div>

            <div class="menu-container">
                <button class="menu-btn">Menu</button>
                <div class="menu-content">
                    <a href="ServletPagarPrestamo?opc=listarPrestamos">Volver Atras</a>
                </div>
            </div>
        </div>

        <div class="info">
            Tabla de cuotas del préstamo N° <%= prestamo.getPrestamoId() %>
        </div>

		<form action="ServletPagarPrestamo" method="post">
		
	    <input type="hidden" name="opc" value="realizarPago">
	    <input type="hidden" name="prestamoId" value="<%= prestamo.getPrestamoId() %>">
	    <input type="hidden" name="cuentaId" value="<%= prestamo.getCuentaDestino() %>">
			
		    <table>
		        <tr>
		            <th>N° de cuota</th>
		            <th>Vencimiento</th>
		            <th>Importe</th>
		            <th>Estado</th>
		            <th>Seleccionar</th>
		        </tr>
		
		        <%
		            if (cuotas != null) {
		                for (Cuota c : cuotas) {
		        %>
		        <tr>
		            <td><%= c.getNumeroCuota() %></td>
		            <td><%= c.getFechaVencimiento() %></td>
		            <td>$ <%= c.getMonto() %></td>
		            <td><%= c.getEstado() %></td>
		            <td>
		                <% if ("pendiente".equals(c.getEstado())) { %>
		                    <input type="checkbox" name="cuotaSeleccionada" value="<%= c.getCuotaId() %>">
		                <% } else { %>
		                    Pagada
		                <% } %>
		            </td>
		        </tr>
		        <%
		                }
		            }
		        %>
		    </table>
		    <p>Progreso: <%= prestamo.getCuotasPagas() %> / <%= prestamo.getNroCuotas() %> cuotas pagadas</p>
		    <button type="submit" class="btn-pagar">Pagar cuotas seleccionadas</button>
		</form>
		<% if (request.getAttribute("error") != null) { %>
		    <div class="mensaje-error"><%= request.getAttribute("error") %></div>
		<% } %>
		
		<% if (request.getAttribute("mensaje") != null) { %>
		    <div class="mensaje-ok"><%= request.getAttribute("mensaje") %></div>
		    <br>
		    <form action="ServletPagarPrestamo" method="get">
		        <input type="hidden" name="opc" value="listarPrestamos">
		        <button type="submit" class="btn-pagar">Volver al listado de préstamos</button>
		    </form>
		<% } %>
    </div>

</body>
</html>
