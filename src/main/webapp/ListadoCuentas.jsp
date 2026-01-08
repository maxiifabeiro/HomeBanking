<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="entidades.Cuenta" %>
<%@ page import="entidades.TipoCuenta" %>
<%@ page import="entidades.Cliente" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Listado de Cuentas</title>
<style>
body {
        font-family: sans-serif;
        margin: 0;
        padding: 20px;
        background-color: #d9d9d9;
    }

    h1 {
        margin-bottom: 30px;
    }

    .contenedor {
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

    .mensaje {
        color: red;
        margin: 15px 0;
    }

    .tabla-contenedor {
        background: white;
        border: 1px solid #222;
        height: 350px;
        padding: 10px;
        overflow-x: auto;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        table-layout: fixed;
    }

    th, td {
        border: 1px solid #ccc;
        padding: 8px;
        text-align: center;
        word-wrap: break-word;
    }

    th {
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
</style>
</head>
<body>

	<div class="menu-container">
	    <button class="menu-btn">
	    	<img src="https://cdn-icons-png.flaticon.com/512/1828/1828859.png" alt="Menú" class="menu-icono" />
	    </button>
	    <div class="menu-content">
	        <a href="ABMLCuentas.jsp">Volver al menu anterior</a>
	        <a href="ServletCuenta?opc=agregar">Agregar Cuenta</a>
	        <a href="ServletCuenta?opc=eliminar">Eliminar Cuenta</a>
	        <a href="ModificarCuentaMenu.jsp">Modificar Cuenta</a>
	    </div>
	</div>
	
	<div class="contenedor">
	    <h1>Listado de cuentas de los clientes</h1>

	    <br><br>

	    <form class="buscar" method="get" action="ServletCuenta">
	   		<input type="hidden" name="opc" value="listar">
	        <label>Ingrese DNI:</label>
	        <input type="text" name="dniCuenta" maxlength="8" pattern="\d{7,8}">
	        <button type="submit" name="btnFiltrar" class="boton">Filtrar</button>
	        <button type="submit" name="btnTodos" class="boton">Mostrar Todos</button>
	    </form>
	    
	    <br><br>

		<%
			List<Cuenta> Cuentas = (List<Cuenta>) request.getAttribute("Cuentas");
			String error = (String) request.getAttribute("mensajeError");
			int pagina = 1;
			int pageSize = 10;

			if (request.getParameter("page") != null) {
				pagina = Integer.parseInt(request.getParameter("page"));
			}

			if (Cuentas != null && !Cuentas.isEmpty()) {

				int totalCuentas = Cuentas.size();
				int totalPaginas = (int) Math.ceil((double) totalCuentas / pageSize);

				int inicio = (pagina - 1) * pageSize;
				int fin = Math.min(inicio + pageSize, totalCuentas);
		%>

	    <div class="tabla-contenedor">
	        <table>
	            <thead>
	                <tr>
	                    <th>CBU</th>
	                    <th>Nombre Cliente</th>
	                    <th>Apellido Cliente</th>
	                    <th>DNI</th>
	                    <th>Tipo de cuenta</th>
	                    <th>Saldo</th>
	                </tr>
	            </thead>
	            <tbody>

					<%
						for (int i = inicio; i < fin; i++) {
							Cuenta c = Cuentas.get(i);
					%>
					<tr>
						<td><%= c.getCbu() %></td>
						<td><%= c.getCliente().getNombre() %></td>
						<td><%= c.getCliente().getApellido() %></td>
						<td><%= c.getCliente().getDni() %></td>
						<td><%= c.getTipoCuenta().getDescripcion() %></td>
						<td><%= c.getSaldo() %></td>
					</tr>
					<% } %>

	            </tbody>
	        </table>
	    </div>

	    <br>

		<!-- PAGINACIÓN -->
				<div style="margin-top:20px; text-align:center;">
		
			<% if (pagina > 1) { %>
			    <a href="ServletCuenta?opc=listar&btnTodos=1&page=<%= pagina - 1 %>" class="boton">Anterior</a>
			<% } %>
			
			<span style="margin: 0 10px;">
			    Página <%= pagina %> de <%= totalPaginas %>
			</span>
			
			<% if (pagina < totalPaginas) { %>
			    <a href="ServletCuenta?opc=listar&btnTodos=1&page=<%= pagina + 1 %>" class="boton">Siguiente</a>
			<% } %>
			
			</div>

			<%
			    } 
			%>
			
			<%
			    if (error != null) {
			%>
			    <p style="color:red; text-align:center;"><%= error %></p>
			<%
			    }
			%>

	</div>
</body>
</html>
