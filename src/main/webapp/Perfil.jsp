<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="entidades.Usuario"%>
<%@page import="entidades.Cliente"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<title>Perfil Cliente</title>
<style>
    body {
    font-family: "Segoe UI", Arial, sans-serif;
    background-color: #eef1f5;
    margin: 0;
	}
	
	.contenedor {
	    max-width: 700px;
	    background: white;
	    margin: 40px auto;
	    padding: 30px;
	    border-radius: 14px;
	    box-shadow: 0 6px 14px rgba(0,0,0,0.1);
	}
	
	.perfil-header {
	    text-align: center;
	    margin-bottom: 25px;
	}
	
	.perfil-header img {
	    width: 130px;
	    border-radius: 50%;
	    border: 4px solid #4b75f5;
	    margin-bottom: 10px;
	}
	
	.perfil-header h1 {
	    font-size: 24px;
	    color: #333;
	    margin-bottom: 5px;
	}
	
	.informacion {
	    font-size: 15px;
	}
	
	.fila {
	    display: flex;
	    justify-content: space-between;
	    padding: 10px 0;
	    border-bottom: 1px solid #eee;
	}
	
	.fila span {
	    color: #666;
	}
	
	.btn-volver {
	    margin-top: 25px;
	    background-color: #4b75f5;
	    color: white;
	    padding: 10px 20px;
	    border-radius: 10px;
	    text-decoration: none;
	    display: inline-block;
	}
	
	.btn-volver:hover {
	    background-color: #3a5edc;
	}

</style>

</head>

<body class="bg-light">
	<%
	    Cliente cliente = (Cliente) request.getAttribute("cliente");
		Usuario usuario = (Usuario) request.getAttribute("usuario");
	
	%>
	<div class="contenedor">
	
	    <div class="perfil-header">
	        <img src="images/foto-perfil.png" alt="Foto perfil">
	        <h1>
	            <%= (cliente != null) ? cliente.getNombre() + " " + cliente.getApellido() : "Usuario" %>
	        </h1>
	    </div>
	
	    <% if (cliente != null && usuario != null) { %>
	
	    <div class="informacion">
	        <div class="fila"><strong>Usuario</strong><span><%= usuario.getNombreUsuario() %></span></div>
	        <div class="fila"><strong>DNI</strong><span><%= cliente.getDni() %></span></div>
	        <div class="fila"><strong>CUIL</strong><span><%= cliente.getCuil() %></span></div>
	        <div class="fila"><strong>Sexo</strong>
	            <span>
	                <%= cliente.getSexo() == 'M' ? "Masculino" :
	                    cliente.getSexo() == 'F' ? "Femenino" : "Sin género" %>
	            </span>
	        </div>
	        <div class="fila"><strong>Fecha de nacimiento</strong><span><%= cliente.getFechaNacimiento() %></span></div>
	        <div class="fila"><strong>Email</strong><span><%= cliente.getCorreoElectronico() %></span></div>
	        <div class="fila"><strong>Teléfono</strong><span><%= cliente.getTelefono() %></span></div>
	        <div class="fila"><strong>Dirección</strong><span><%= cliente.getDireccion() %></span></div>
	        <div class="fila"><strong>Localidad</strong><span><%= cliente.getLocalidad().getNombre() %></span></div>
	        <div class="fila"><strong>Provincia</strong><span><%= cliente.getProvincia().getNombre() %></span></div>
	    </div>
	
	    <% } else { %>
	        <div class="alert alert-danger">No se encontró información del cliente</div>
	    <% } %>
	
	    <div style="text-align:center;">
	        <a href="InicioMenuCliente.jsp" class="btn-volver">Volver al menú</a>
	    </div>
	</div>
</body>
</html>