<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="entidades.TipoCuenta"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Agregar Cuenta</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f7f9fc;
        margin: 0;
        padding: 0;
    }

    /* --- Contenedor general --- */
    .pagina {
        max-width: 900px;
        margin: 60px auto 40px auto;
        background: white;
        padding: 30px 40px;
        border-radius: 12px;
        box-shadow: 0px 0px 12px rgba(0,0,0,0.15);
        text-align: center;
    }

    h1 {
        margin-bottom: 25px;
    }

    /* --- Botón general --- */
    .boton {
        background-color: #4cc4f0;
        border-radius: 6px;
        border: none;
        padding: 10px 25px;
        font-weight: bold;
        font-size: 15px;
        cursor: pointer;
        transition: 0.2s;
    }
    .boton:hover {
        background-color: #2fb4e1;
        color: #fff;
    }

    /* --- Formulario --- */
    .seccion {
        width: 100%;
        margin-top: 20px;
    }

    .form-row {
        display: flex;
        justify-content: center;
        gap: 40px;
        margin-bottom: 20px;
        flex-wrap: wrap;
    }

    .form-group {
        display: flex;
        flex-direction: column;
        width: 260px;
        text-align: left;
    }

    label {
        font-size: 16px;
        margin-bottom: 6px;
        font-weight: bold;
    }

    input, select {
        padding: 9px;
        border-radius: 6px;
        border: 1px solid #ccc;
        font-size: 15px;
    }

    input[readonly] {
        background-color: #ececec;
        cursor: not-allowed;
    }

    /* --- MENÚ SUPERIOR --- */
    .menu {
        position: absolute;
        top: 20px;
        right: 40px;
    }

    .menu button {
        background-color: #43a8cd;
        border-radius: 20px;
        padding: 10px 20px;
        font-weight: bold;
        color: white;
        border: none;
        cursor: pointer;
    }

    .menu-desplegable {
        display: none;
        position: absolute;
        right: 0;
        background-color: #ffffff;
        border: 1px solid #ccc;
        margin-top: 5px;
        border-radius: 8px;
        width: 200px;
        box-shadow: 0px 4px 10px rgba(0,0,0,0.15);
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
        background-color: #e8e8e8;
    }

    /* --- Mensajes --- */
    .msg-exito {
        color: green;
        font-weight: bold;
        margin-top: 20px;
    }

    .msg-error {
        color: red;
        font-weight: bold;
        margin-top: 20px;
    }
</style>
</head>
<body>

	<div class="menu">
		<button class="menu-btn" >Menu</button>
		<div class="menu-desplegable">
	        <a href="ABMLCuentas.jsp">Volver al menu anterior</a>
	        <a href="ServletCuenta?opc=eliminar">Eliminar Cuenta</a>
	        <a href="ModificarCuentaMenu.jsp">Modificar Cuenta</a>
	        <a href="ServletCuenta?opc=listar">Listar Cuenta</a>
	    </div>
	</div>
	<div class="pagina">
		<h1> Agregar Cuenta</h1>

	    <form action="ServletCuenta" method="get">
	        <input type="hidden" name="opc" value="agregar">
	
	        <p>Ingrese DNI del cliente:</p> 
	        <input type="text" name="dniCliente" maxlength="8" pattern="\d{7,8}" class="cajaTexto">
	        <input type="submit" value="Buscar" name="btnBuscar" class="boton">
	    </form>
	    <br>
		<form action="ServletCuenta" method="post">
		    <section class="seccion">
		
		        <!-- Datos cargados por el servlet -->
		        <div class="form-row">
		            <div class="form-group">
		                <label>Nombre</label>
		                <input type="text" readonly
		                    value="<%= request.getAttribute("nombreCliente") != null ? request.getAttribute("nombreCliente") : "" %>">
		            </div>
		
		            <div class="form-group">
		                <label>Apellido</label>
		                <input type="text" readonly
		                    value="<%= request.getAttribute("apellidoCliente") != null ? request.getAttribute("apellidoCliente") : "" %>">
		            </div>
		        </div>
		
		        <div class="form-row">
		            <div class="form-group">
		                <label>DNI</label>
		                <input type="text" name="dniCliente" readonly
		                    value="<%= request.getAttribute("DNICliente") != null ? request.getAttribute("DNICliente") : "" %>">
		            </div>
		
		            <div class="form-group">
		                <label>Tipo de cuenta</label> 
		                <select name="tipoCuenta">
		                    <option value="">-- Seleccione un tipo de cuenta --</option>
		                    <%
		                        List<TipoCuenta> tipos = (List<TipoCuenta>) request.getAttribute("tipocuentas");
		                        if (tipos != null) {
		                            for (TipoCuenta t : tipos) {
		                    %>
		                        <option value="<%= t.getTipoCuenta_id() %>"><%= t.getDescripcion() %></option>
		                    <%      }
		                        }
		                    %>
		                </select>
		            </div>
		        </div>
		
		        <div class="form-row">
		            <div class="form-group">
		                <label>CBU</label>
		                <input type="text" readonly maxlength="22" name="CBUCliente"
		                    value="<%= request.getAttribute("cbuGenerado") != null ? request.getAttribute("cbuGenerado") : "" %>">
		            </div>
		
		            <div class="form-group">
		                <label>Alias</label>
		                <input type="text" name="AliasCuenta" readonly
  						value="<%= request.getAttribute("aliasGenerado") != null ? request.getAttribute("aliasGenerado") : "" %>">
		            </div>
		        </div>
		
		        <div class="form-row">
		            <div class="form-group">
		                <label>Saldo</label>
		                <input type="number" name="saldoCuenta" step="0.01" min="0" required>
		            </div>
		
		            <div class="form-group">
		                <label>Fecha</label>
		                <input type="date" name="fechaCuenta" required>
		            </div>
		        </div>
		
		        <input type="submit" value="Agregar" name="btnAgregar" class="boton">
		
		    </section>
		    </form>
		    <% if (request.getAttribute("mensajeExito") != null) { %>
		    <div style="color: green; font-weight: bold; margin: 10px;">
		        <%= request.getAttribute("mensajeExito") %>
		    </div>
			<% } %>
			
			<% if (request.getAttribute("mensajeError") != null) { %>
			    <div style="color: red; font-weight: bold; margin: 10px;">
			        <%= request.getAttribute("mensajeError") %>
			    </div>
			<% } %>
	</div>
</body>
</html>