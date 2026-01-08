
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
<title>Modificar Cuenta</title>


<style>
    body {
        font-family: sans-serif;
        margin: 0;
        padding: 20px;
        background-color: #d9d9d9;
    }

    .contenedor {
        width: 80%;
        margin: 40px auto;
    }

    h1 {
        font-size: 28px;
        margin-bottom: 20px;
        text-align: center;
    }

    .carta-contenedor {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
        justify-content: center;
        margin-top: 30px;
    }

    .carta {
        background: white;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        width: 250px;
        padding: 20px;
        text-align: center;
    }

    .carta h3 {
        margin-bottom: 10px;
        font-size: 18px;
    }

    .carta p {
        font-size: 14px;
        color: #555;
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

    .buscar {
        display: flex;
        align-items: center;
        gap: 10px;
        justify-content: center;
        margin-bottom: 20px;
    }

    .buscar input[type="text"] {
        padding: 6px;
        width: 200px;
        border: 1px solid #555;
        border-radius: 4px;
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
    
     /* Mensajes */
    .mensajeExitoso{
    	color: green; 
    	font-weight: bold;
    }
    
    .mensajeError{
    	color: red; 
    	font-weight: bold;
    }
</style>

</head>
<body>
		<%
	List<Cuenta> Cuentas = (List<Cuenta>) request.getAttribute("Cuentas");
	
	int inicio = 0;
	int fin = 0;
	
	if (Cuentas != null) {
	    fin = Cuentas.size();
	}
	%>

	
	<div class="menu-container">
	    <button class="menu-btn">
	    	<img src="https://cdn-icons-png.flaticon.com/512/1828/1828859.png" 
                 alt="Menú" 
                 class="menu-icono" />
	    </button>

	    <div class="menu-content">
	        <a href="InicioMenuAdministrador.jsp">Inicio</a>
	        <a href="ServletCuenta?opc=agregar">Agregar Cuenta</a>
    		<a href="ServletCuenta?opc=eliminar">Eliminar Cuenta</a>
    		<a href="ModificarCuentaMenu.jsp">Modificar Cuenta</a>
    		<a href="ServletCuenta?opc=listar">Listar Cuenta</a>
	       	<a href="ABMLCuentas.jsp">Volver al menu anterior</a>
	    </div>
	</div>

    
	<div class="contenedor">
	    <h1>Modificar Cuenta</h1>
	
	    <!-- Formulario de búsqueda -->
	    <form action="ServletCuenta" method="get">
	        <input type="hidden" name="opc" value="listarModificar">
	        <div class="buscar">
	            <label>Buscar por DNI:</label>
	            <input type="text" name="dniCuenta" maxlength="8" pattern="\d{7,8}" required>
	            <input type="submit" value="Buscar" name="btnFiltrar" class="boton">
	        </div>
	    </form>
	
	    <br><br><br>
	
	    <!-- Tarjetas -->
	    <div class="carta-contenedor">
	        <% if (Cuentas != null && !Cuentas.isEmpty()) { %>
	            <% for (Cuenta c : Cuentas) { %>
	                <div class="carta">
	                    <h3>CBU: <%= c.getCbu() %></h3>
	                    <p><strong><%= c.getCliente().getNombre() %> <%= c.getCliente().getApellido() %></strong></p>
	                    <p>DNI: <%= c.getCliente().getDni() %></p>
	                    <p>Tipo: <%= c.getTipoCuenta().getDescripcion() %></p>
	                    <p>Saldo: $<%= c.getSaldo() %></p>
	
	                    <!-- Form para modificar -->
	                    <form action="ServletCuenta" method="get">
	                        <input type="hidden" name="opc" value="modificar">
	                        <input type="hidden" name="idCuenta" value="<%= c.getCuenta_id() %>">
	                        <button type="submit" class="boton">Ir a modificar</button>
	                    </form>
	                </div>
	            <% } %>
	        <% } %>
	        
		  	<!-- Mensajes -->
			<% if (request.getAttribute("mensajeExito") != null) { %>
			    <div class="mensajeExitoso">
			        <%= request.getAttribute("mensajeExito") %>
			    </div>
			<% } else if (request.getAttribute("mensajeError") != null) { %>
			    <div class="mensajeError">
			        <%= request.getAttribute("mensajeError") %>
			    </div>
			<% } %>
	    </div>
	</div>

</body>
</html>