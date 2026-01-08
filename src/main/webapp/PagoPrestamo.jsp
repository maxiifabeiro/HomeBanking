<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="entidades.Prestamos" %>
<%@ page import="entidades.Usuario" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pago Prestamo</title>
<style>
    body {
        font-family: Arial, sans-serif;
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

	h3{
		color: blue;
		font-size: 30px;
	}

    .logo {
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .logo img {
        width: 60px;
        height: 60px;
    }

	/* Botones estándar */
	.btn {
	    background-color: #6ed6e8;
	    border: none;
	    padding: 8px 18px;
	    border-radius: 5px;
	    font-weight: 500;
	    cursor: pointer;
	    color: black;
	    transition: 0.2s ease-in-out;
	}
	
	.btn:hover {
	    background-color: #8fe4f2;
	}
	
	/* Botones principales del menú superior */
	.buttons a,
	.buttons button {
	    background-color: #6ed6e8;
	    border: none;
	    padding: 8px 18px;
	    border-radius: 5px;
	    margin-right: 10px;
	    font-weight: 500;
	    cursor: pointer;
	    text-decoration: none;
	    color: black;
	    transition: 0.2s ease-in-out;
	}
	
	.buttons a,
    .buttons button {
        background-color: #6ed6e8;
        border: none;
        padding: 8px 18px;
        border-radius: 5px;
        margin-right: 10px;
        font-weight: 500;
        cursor: pointer;
        text-decoration: none;
        color: black;
    }

    .buttons .active {
        background-color: #8e93ec;
    }
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

    th {
        background-color: #eee;
    }

    .info {
        font-size: 14px;
        margin-top: 10px;
    }

    .menu-container{
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

    .menu-content{
        display: none;
        position: absolute;
        right: 0;
        background-color: white;
        border: 1px solid #ccc;
        margin-top: 5px;
        border-radius: 4px;
    }

    .menu-content a{
        display: block;
        padding: 8px 12px;
        text-decoration: none;
        color: black;
    }

    .menu-content a:hover{
        background-color: #eee;
    }

    .menu-container:hover .menu-content{
        display: block;
    }
</style>
</head>
<body>
<div class="container">

    <!-- Encabezado -->
    <div class="header">
        <div class="logo">
            <img src="images/Logo.png" alt="Logo">
            <h3>HomeBanking</h3>
        </div>
        <div class="menu-container">
            <button class="menu-btn">Menu</button>
            <div class="menu-content">
                <a href="InicioMenuCliente.jsp">Volver Atrás</a>
            </div>
        </div>
    </div>
	    <div class="buttons">
            <a class="active" href="ServletMovimientos">Ver movimientos</a>
    		<a class="active" href="ServletTransferencia?accion=accion">Transferir dinero</a>
        	<a class="active" href="ServletSolicitarPrestamo?opc=solicitarPrestamo">Solicitud de préstamo</a>
    </div>
    <% 
        Usuario u = (Usuario) session.getAttribute("usuarioLogueado");
        if (u == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
    %>

    <h1>Hola <%= u.getNombreUsuario() %></h1>

    <div class="info">
        <strong>Pagar préstamo:</strong>
    </div>

    <%
        List<Prestamos> activos = (List<Prestamos>) request.getAttribute("PrestamosActivos");
        List<Prestamos> pagados = (List<Prestamos>) request.getAttribute("PrestamosPagados");
    %>

    <!-- Tabla de préstamos activos -->
    <h2>Préstamos activos</h2>
    <% if (activos != null && !activos.isEmpty()) { %>
    <table>
        <thead>
            <tr>
                <th>ID Prestamo</th>
                <th>Fecha de alta</th>
                <th>Monto total</th>
                <th>Cuotas totales</th>
                <th>Cuotas pagas</th>
                <th>Estado</th>
                <th>Acción</th>
            </tr>
        </thead>
        <tbody>
            <% for (Prestamos p : activos) { %>
            <tr>
                <td><%= p.getPrestamoId() %></td>
                <td><%= p.getFecha() %></td>
                <td>$ <%= p.getMontoPedido() %></td>
                <td><%= p.getNroCuotas() %></td>
                <td><%= p.getCuotasPagas() %></td>
                <td><%= p.getEstado() %></td>
                <td>
                    <form action="ServletPagarPrestamo" method="get">
                        <input type="hidden" name="opc" value="pagarCuota">
                        <input type="hidden" name="prestamoId" value="<%= p.getPrestamoId() %>">
                        <button class="btn" type="submit">Pagar</button>
                    </form>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
    <% } else { %>
        <p>No tenés préstamos activos en este momento.</p>
    <% } %>

    <!-- Tabla de préstamos pagados -->
    <h2>Préstamos pagados</h2>
    <% if (pagados != null && !pagados.isEmpty()) { %>
    <table class="tabla-pagados">
        <thead>
            <tr>
                <th>ID Prestamo</th>
                <th>Fecha de alta</th>
                <th>Monto total</th>
                <th>Cuotas totales</th>
                <th>Cuotas pagas</th>
                <th>Estado</th>
            </tr>
        </thead>
        <tbody>
            <% for (Prestamos p : pagados) { %>
            <tr>
                <td><%= p.getPrestamoId() %></td>
                <td><%= p.getFecha() %></td>
                <td>$ <%= p.getMontoPedido() %></td>
                <td><%= p.getNroCuotas() %></td>
                <td><%= p.getCuotasPagas() %></td>
                <td><%= p.getEstado() %></td>
            </tr>
            <% } %>
        </tbody>
    </table>
    <% } else { %>
        <p>No tenés préstamos finalizados.</p>
    <% } %>

    <% if (session.getAttribute("mensaje") != null) { %>
        <div class="mensaje-ok"><%= session.getAttribute("mensaje") %></div>
        <% session.removeAttribute("mensaje"); %>
    <% } %>

</div>
</body>

</html>
