<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="entidades.Cuenta" %>
<%@page import="entidades.TipoCuenta"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Eliminar Cuenta</title>
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
	
	.buscar-cuentas{
		display: inline-flex;
		gap: 10px;
        margin-bottom: 30px;
    }
	
	.buscar-cuentas label {
		font-size: 18px;
		margin-top: 4px;
	}
	
	.buscar-cuentas .boton {
		font-size: 15px;
		width: 20%;	
		height: 18%;
	}
	
	label{
        font-size: 15px;
        margin-bottom: 5px;
    }
	
	.seccion{
        padding: 20px;
        width: 35%;
        margin: 0 auto;
        display: flex;
        gap: 20px;
        justify-content: center;
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
	}
	.boton:hover{
		background-color: #94dcf6;
		border-color: #b7e7f9;
		color: white;
	}
	
	fieldset{
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
	  	border-radius: 4px ;
	  	color: black;
	  	font-weight: bold;
	  	font-size: 16px;
	  	background-color: #4cc4f0;
	  	box-shadow: 3px 3px 5px #3d9dc0;
	  	padding: 5px 10px;
	}
	
	.menu{
		position: relative;
		float: right;
		margin-right: 60px;
	}
	
	button{
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
	        <a href="ServletCuenta?opc=agregar">Agregar Cuenta</a>
	        <a href="ServletCuenta?opc=listarModificar">Modificar Cuenta</a>
	        <a href="ServletCuenta?opc=listar">Listar Cuenta</a>
	       	<a href="ABMLCuentas.jsp">Volver al menu anterior</a>
	    </div>
	</div>
	
	<% List<Cuenta> cuentas = (List<Cuenta>) request.getAttribute("cuentas"); 
		String mensajeError = request.getParameter("mensajeError");
	    
		int inicio = 0;
		int fin = 0;
		
	    if(cuentas != null){
	    	fin = cuentas.size();
	    }			
	    	%>
	
	<div class="pagina">
		<h1> Eliminar Cuenta</h1> 
		
		<form action="ServletCuenta" method="get">
			
			<input type="hidden" name= "opc" value= "eliminar">
			<div class="buscar-cuentas">
				<label>Ingrese su DNI: </label> 
				<input type="text" name="DniCliente" maxlength="8" pattern="\d{7,8}" required> 
				<input type="submit" value="Buscar" name="btnBuscar" class="boton">
			</div>
		
		</form>
	    	
	    	<div class="seccion">
	    	
	    	<% if(mensajeError != null){ %>
			    <p class="msj1"><%= mensajeError %></p>
			<% } %>
	    	
	    	<%
                    if (cuentas != null) {
                        for (int i = inicio; i < fin; i++) {

                            Cuenta c = cuentas.get(i);
                %>
		<div class="cuenta">
			<fieldset>
			<legend> Cuenta <%= c.getCuenta_id() %></legend>
				<table>
			        <tr><th>Cliente:</th><td><%= c.getCliente().getNombre() %>
			        <%= c.getCliente().getApellido() %></td></tr>
			        <tr><th>CBU:</th><td><%= c.getCbu() %></td></tr>
			        <tr><th>Saldo:</th><td>$<%= c.getSaldo() %></td></tr>
			        <tr><th>Tipo cuenta:</th><td><%= c.getTipoCuenta().getDescripcion() %></td></tr>
		    	</table>
			</fieldset>
			
			<form action="ServletCuenta" method="post" onsubmit="return confirmarEliminacion()">
				<input type="hidden" name="opc" value="eliminar">
				<input type="hidden" name="cuentaId" value="<%= c.getCuenta_id() %>">
				<input type="submit" value="Eliminar" name="btnEliminar" class="boton">
			</form>
		<%  } 
            }    
	    	%>
	    	
		    	<div style="color: red;">
				    <%= request.getAttribute("mensajeError") != null ? request.getAttribute("mensajeError") : "" %>
				</div>
				
				<div style="color: green;">
				    <%= request.getAttribute("mensajeExito") != null ? request.getAttribute("mensajeExito") : "" %>
				</div>

	    	</div>
		</div>
		
	</div>
</body>
</html>