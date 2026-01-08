<%@page import="entidades.TipoCuenta"%>
<%@ page import="java.util.List" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

    .contenedor{
        width: 70%;
        margin: 40px auto;
    }

    h1{
        font-size: 28px;
        margin-bottom: 10px;
        text-align: center;
    }

    h3{
        margin-top: 30px;
        margin-bottom: 10px;
    }

	/* formulario */
    form{
        display: flex;
        flex-direction: column;
    }

    .form-row{
        display: flex;
        justify-content: space-between;
        margin-bottom: 15px;
    }

    .form-group{
        display: flex;
        flex-direction: column;
        width: 48%;
    }

    label{
        font-size: 14px;
        margin-bottom: 5px;
    }

    input, select{
        padding: 6px;
        width: 60%;
        border: 1px solid #555;
        background: white;
    }

    /* Boton general */
    .boton {
    	font-size: 15px;
    	font-family: "Segoe UI", Arial, sans-serif;
        background: #6ed6e8;
        font-weight: bold;
        color: black;
        border: none;
        padding: 10px;
        width: 170px;
        margin: 30px auto 0 auto;
        cursor: pointer;
        border-radius: 4px;
    }

    .boton:hover {
        background: #8F9ADD;
    }

	/* menú */
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
	    <br><br>
	
	    <form action="ServletCuenta" method="post">
	      
            <input type="hidden" name="opc" value="guardarModificacion">
            <input type="hidden" name="idCuenta" value= "<%= request.getParameter("idCuenta") %>" >
	    
	
	        <div class="form-row">
	            <div class="form-group">
	                <label>Nombre Cliente</label>
	                <input type="text" readonly value="<%= request.getAttribute("nombreCliente")%>">
	            </div>
	            <div class="form-group">
	                <label>Apellido Cliente</label>
	                <input type="text" readonly value="<%= request.getAttribute("apellidoCliente")%>">
	            </div>
	        </div>
	
	        <div class="form-row">
	            <div class="form-group">
	                <label>DNI Cliente</label>
	                <input type="text" name="dniCliente" readonly value="<%= request.getAttribute("DNICliente")%>">
	            </div>
	            <div class="form-group">
	                <label for="tipoDeCuentas">Tipo de cuenta</label>
	                
					<select name="tipoCuenta" required>
                        <option value="">-- Seleccione un tipo de cuenta --</option>
                        <%
                            List<TipoCuenta> tipos = (List<TipoCuenta>) request.getAttribute("tipocuentas");
                            Integer tipoSeleccionado = (Integer) request.getAttribute("tipoCuentaSeleccionada");
                            if (tipos != null) {
                                for (TipoCuenta t : tipos) {
                        %>
                            <option value="<%= t.getTipoCuenta_id() %>" <%= (tipoSeleccionado != null && tipoSeleccionado == t.getTipoCuenta_id()) ? "selected" : "" %>>
                                <%= t.getDescripcion() %>
                            </option>
                        <%      }
                            }
                        %>
                    </select>

	            </div>
	        </div>
	
	        <div class="form-row">
	            <div class="form-group">
	                <label>CBU</label>
	                <input type="text" maxlength="22" pattern="\d{22}" name="CBUCliente" value="<%= request.getAttribute("cbu")%>" readonly>
	            </div>
	            
           		<div class="form-group">
                	<label>Alias</label>
                	<input type="text" name="AliasCuenta" pattern="[a-zA-Z0-9._-]{6,30}"  value="<%= request.getAttribute("alias") %>">
            	</div>
	            <div class="form-group">
	                <label>Saldo</label>
	                <input type="number" name="saldoCuenta" step="0.01" min="0.01" value="<%= request.getAttribute("saldoCuenta") %>">
	            </div>
	        </div>
	        <div class="form-group">
                <label>Fecha</label>
                <input type="date" name="fechaCuenta" value="<%= request.getAttribute("fechaCuenta") %>">
            </div>
	        
	        <br><br>
	        <input type="submit" value="Modificar" name="btnModificar" class="boton">
	
	    </form>
	    
		
	</div>
</body>
</html>