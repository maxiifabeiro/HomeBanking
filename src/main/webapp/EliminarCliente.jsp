<%@ page import="entidades.Cliente" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Eliminar cliente</title>
<style>
	body {
    font-family: Serif, sans-serif;
    background-color: #ffffff;
    margin: 0;
    padding: 20px;
	}
	
	.pagina {
	    text-align: center;
	}
	
	.buscar-cuentas {
	    display: inline-flex;
	    gap: 10px;
	    margin-bottom: 30px;
	}
	
	.buscar-cuentas label {
	    font-size: 18px;
	    margin-top: 4px;
	}
	
	.buscar-cuentas .btn {
	    font-size: 15px;
	    width: 20%;
	    height: 18%;
	}
	
	label {
	    font-size: 15px;
	    margin-bottom: 5px;
	}
	
	.seccion {
	    padding: 20px;
	    width: 35%;
	    margin: 0 auto;
	    display: flex;
	    gap: 20px;
	    justify-content: center;
	}
	
	.btn {
	    background-color: #4cc4f0;
	    border-radius: 4px;
	    border-color: #70d0f3;
	    font-weight: bold;
	    font-size: 15px;
	    color: black;
	    padding: 5px 15px;
	    cursor: pointer;
	}
	.btn:hover {
	    background-color: #94dcf6;
	    border-color: #b7e7f9;
	    color: white;
	}
	
	fieldset {
	    padding: 20px 60px;
	    margin-bottom: 15px;
	    border-radius: 15px;
	    background: #f0eaea;
	    border-color: #d8d3d3;
	    width: 120px;
	    height: 250px;
	}
	
	legend {
	    display: inline-table;
	    border-radius: 4px;
	    color: black;
	    font-weight: bold;
	    font-size: 16px;
	    background-color: #4cc4f0;
	    box-shadow: 3px 3px 5px #3d9dc0;
	    padding: 5px 10px;
	}
	
	.menu {
	    position: relative;
	    float: right;
	    margin-right: 60px;
	}
	
	.menu-btn {
	    background-color: #43a8cd;
	    border-radius: 60px;
	    font-weight: bold;
	    font-size: 16px;
	    color: white;
	    border-color: #7bc2dc;
	    width: 130%;
	    height: 130%;
	    cursor: pointer;
	}
	
	.menu-desplegable {
	    display: none;
	    position: absolute;
	    right: 0;
	    background-color: #f0eaea;
	    border: 1px solid #ccc;
	    margin-top: 5px;
	    border-radius: 8px;
	}
	
	.menu-desplegable a {
	    color: black;
	    padding: 12px 16px;
	    text-decoration: none;
	    display: block;
	}
	
	.menu:hover .menu-desplegable {
	    display: block;
	}
	
	.menu-desplegable a:hover {
	    background-color: #ddd;
	}
	
	.msj1 {
	    color: red;
	}
	
	.msj2 {
	    color: green;
	}
</style>
<script>
function confirmarEliminacion() {
    return confirm("¿Está seguro que desea eliminar este cliente?");
}
</script>
</head>
<body>

	<div class="menu">
		<button class="menu-btn" >Menu</button>
		<div class="menu-desplegable">
			<a href="ABMLMenu.jsp">Volver al menu anterior</a>
			<a href="ServletCliente?opc=agregar">Agregar Cliente</a>
			<a href="ServletCliente?opc=modificar">Modificar Cliente</a>
			<a href="ServletCliente?opc=listar">Listado de Clientes</a>
	    </div>
	</div>
	
		<h2>Eliminar Cliente</h2>
	
	<form action="ServletCliente" method="get">
		<input type="hidden" name="opc" value="eliminar">
	    DNI:
	    <input type="text" name="dniBuscar" maxlength="8" pattern="\d{7,8}" required>
	    <input type="submit" name="btnBuscar" value="Buscar" class="btn">
	    
	</form>
	
	<%
	    Cliente cli = (Cliente) request.getAttribute("clienteEncontrado");
	
	    String mensajeExito = request.getParameter("mensajeExito");
	    String mensajeError = request.getParameter("mensajeError");
	%>  
		<% if(mensajeExito != null){ %>
		    <p class="msj2"><%= mensajeExito %></p>
		<% } %>
		
		<% if(mensajeError != null){ %>
		    <p class="msj1"><%= mensajeError %></p>
		<% } %>
	    
	  <%  if(cli != null){ %>
	
	
	    <h3>Datos del Cliente</h3>
	    <table>
	        <tr><th>DNI</th><td><%= cli.getDni() %></td></tr>
	        <tr><th>Nombre</th><td><%= cli.getNombre() %></td></tr>
	        <tr><th>Apellido</th><td><%= cli.getApellido() %></td></tr>
	    </table>
	
	    <form action="ServletCliente" method="post" onsubmit="return confirmarEliminacion()">
	    	<input type="hidden" name="opc" value="eliminar">
	        <input type="hidden" name="clienteId" value="<%= cli.getClienteId() %>">
	        <input type="submit" name="btnEliminar" value="Eliminar Cliente" class="btn">
	       
		<% } %>
	    </form>
	
	
		
</body>
</html>