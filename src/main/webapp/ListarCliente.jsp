<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="entidades.Cliente" %>
<%@ page import="entidades.Localidades" %>
<%@ page import="entidades.Provincias" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Listar Cliente</title>
<style>

	body{
		font-family: Serif, sans-serif;
		background-color: #ffffff;
		margin: 0;
		padding: 20px;
	}
	
	.pagina{
		text-align: center;
	}
	
	.filtrar{
		display: inline-flex;
		gap: 10px;
		margin-bottom: 8px;
	}
	
	.filtrar label {
		font-size: 18px;
		margin-top: 4px;
	}
	
	.boton{
		background-color: #4cc4f0;
		border-radius: 4px;
		border-color: #70d0f3;
		font-weight: bold;
		font-size: 15px;
		color: black;
		padding: 5px 15px;
		cursor: pointer;
		text-decoration: none;
	}
	
	.boton:hover{
		background-color: #94dcf6;
		border-color: #b7e7f9;
		color: white;
	}
	
	.tabla-cliente{
		background-color: #f0eaea;
		border: 1px hidden #c0bbbb;
		border-radius: 6px;
		height: auto;
		padding: 10px;
		margin-top: 30px;
	}
	
	table{
		width: 100%;
		border-collapse: collapse;
	}
	
	th, td{
		padding: 10px;
		text-align: center;
		border: 1px solid #3589a8;
		font-size: 18px;
		color: #173b48;
	}
	
	th{
		background-color: #44b0d8;
	}
	
	.menu{
		position: relative;
		float: right;
		margin-right: 60px;
	}
	
	.menu-btn{
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

	.menu-desplegable{
		display: none;
		position: absolute;
		right: 0;
		background-color: #f0eaea;
		border: 1px solid #ccc;
		margin-top: 5px;
		border-radius: 8px;
	}
	
	.menu-desplegable a{
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
	   
</style>
</head>
<body>

<div class="menu">
		<button class="menu-btn">Menu</button>
		<div class="menu-desplegable">
			<a href="ABMLMenu.jsp">Volver al menu anterior</a>
			<a href="ServletCliente?opc=agregar">Agregar Cliente</a>
			<a href="ServletCliente?opc=eliminar">Eliminar Cliente</a>
			<a href="ServletCliente?opc=modificar">Modificar Cliente</a>
		</div>
	</div>
	
	<div class="pagina">
		<h1> Listado de Clientes</h1> 
		
		<form action="ServletCliente" method="get">
		    <input type="hidden" name="opc" value="listar">
		
		    <div class="filtrar">
		        <label>Ingrese DNI:</label> 
		        <input type="text" name="dniCliente" maxlength="8" pattern="\d{7,8}" class="cajaTexto">
		
		        <button type="submit" name="btnFiltrar" class="boton">Filtrar</button>
		
		        <button type="submit" name="btnTodos" class="boton">Mostrar Todos</button>
		    </div>
		</form>

		<%
			List<Cliente> clientes = (List<Cliente>) request.getAttribute("Clientes");

			// PAGINACIÓN -------------------------------
			int pagina = 1;
			int pageSize = 10;

			if (request.getParameter("page") != null) {
				pagina = Integer.parseInt(request.getParameter("page"));
			}

			if (clientes != null && !clientes.isEmpty()) {

				int totalClientes = clientes.size();
				int totalPaginas = (int) Math.ceil((double) totalClientes / pageSize);

				int inicio = (pagina - 1) * pageSize;
				int fin = Math.min(inicio + pageSize, totalClientes);
		%>

		<div class="tabla-cliente">
			<table>
				<thead> 
				    <tr> 
				        <th>DNI</th>
				        <th>CUIL</th>
				        <th>Nombre</th>
				        <th>Apellido</th>
				        <th>Sexo</th>
				        <th>País</th>
				        <th>Fecha Nacimiento</th>
				        <th>Dirección</th>
				        <th>Localidad</th>
				        <th>Provincia</th>
				        <th>Correo</th>
				        <th>Teléfono</th>
				    </tr>
				</thead>
				<tbody>
				    <%
				        for (int i = inicio; i < fin; i++) {
				            Cliente c = clientes.get(i);
				    %>
				    <tr>
				        <td><%= c.getDni() %></td>
				        <td><%= c.getCuil() %></td>
				        <td><%= c.getNombre() %></td>
				        <td><%= c.getApellido() %></td>
				        <td><%= c.getSexo() %></td>
				        <td><%= c.getPais().getNombre() %></td> 
				        <td><%= c.getFechaNacimiento() %></td>
				        <td><%= c.getDireccion() %></td>
				        <td><%= c.getLocalidad().getNombre() %></td>
				        <td><%= c.getProvincia().getNombre() %></td>
				        <td><%= c.getCorreoElectronico() %></td>
				        <td><%= c.getTelefono() %></td>
				    </tr>
				    <% } %>
				</tbody>
			</table>
		</div>

		<!-- PAGINACIÓN -->
		<div style="margin-top:20px; text-align:center;">
		
		<% if (pagina > 1) { %>
		    <a href="ServletCliente?opc=listar&btnTodos=1&page=<%= pagina - 1 %>" class="boton">Anterior</a>
		<% } %>
		
		<span style="margin: 0 10px;">
		    Página <%= pagina %> de <%= totalPaginas %>
		</span>
		
		<% if (pagina < totalPaginas) { %>
		    <a href="ServletCliente?opc=listar&btnTodos=1&page=<%= pagina + 1 %>" class="boton">Siguiente</a>
		<% } %>
		
		</div>


		<%
			} else if (request.getParameter("clienteFiltrado") != null) {
		%>

		<p>No se encontraron clientes con ese DNI.</p>

		<% } %>
		
	</div>
</body>
</html>