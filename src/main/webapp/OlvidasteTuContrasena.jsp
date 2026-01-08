<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Olvidaste Tu Contraseña</title>
<style>
    body {
        font-family: 'Segoe UI', Tahoma, sans-serif;
        background: linear-gradient(135deg, #f0f4f8, #d9e4ec);
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }
    .contenedor {
        background: #fff;
        padding: 35px;
        border-radius: 12px;
        box-shadow: 0 6px 18px rgba(0,0,0,0.1);
        text-align: center;
        width: 420px;
    }
    h1 {
        color: #2c3e50;
        font-size: 28px;
        margin-bottom: 10px;
    }
    img {
        margin-bottom: 20px;
    }
    label {
        font-weight: 600;
        font-size: 14px;
        display: block;
        margin-bottom: 6px;
        color: #34495e;
        text-align: left;
    }
    input {
        width: 100%;
        padding: 9px;
        margin-bottom: 12px;
        border: 1px solid #ccc;
        border-radius: 6px;
        font-size: 14px;
        transition: border-color 0.3s;
    }
    input:focus {
        border-color: #3498db;
        outline: none;
    }
    .boton {
        background-color: #3498db;
        color: white;
        border: none;
        padding: 8px 16px;
        cursor: pointer;
        border-radius: 6px;
        font-size: 13px;
        font-weight: 600;
        margin-bottom: 10px;
        transition: background-color 0.3s;
    }
    .boton:hover {
        background-color: #2980b9;
    }
    .btn-volver {
        display: inline-block;
        padding: 8px 16px;
        background-color: #95a5a6;
        color: white;
        border-radius: 6px;
        text-decoration: none;
        font-size: 13px;
        margin-top: 6px;
        transition: background-color 0.3s;
    }
    .btn-volver:hover {
        background-color: #7f8c8d;
    }
    .mensaje {
        font-weight: bold;
        margin-bottom: 18px;
        padding: 10px;
        border-radius: 6px;
    }
    .mensaje.exito{
        background-color: #d4edda; 
    	color: #155724;    

    }
    .mensaje.error{
        background-color: #f8d7da;
  		color: #721c24;   
    }
</style>
</head>
<body>
	<div class="contenedor">
	
	    <h1>HomeBanking</h1>
	    <img src="images/Logo.png" width="65">
	
	    <form action="ServletRecuperarContrasena" method="post">
	
	        <% if(request.getAttribute("mensaje") != null){ %>
	            <div class="mensaje <%= (request.getAttribute("verificado") != null) ? "exito" : "error" %>">
	                <%= request.getAttribute("mensaje") %>
	            </div>
	        <% } %>
	
	        <!-- USUARIO -->
	        <label>Usuario</label>
	        <input type="text" name="usuario"
	               value="<%= request.getAttribute("usuario") != null 
	                    ? request.getAttribute("usuario") 
	                    : (request.getParameter("usuario") != null 
	                        ? request.getParameter("usuario") 
	                        : "") %>" required>
	
	        <button class="boton" type="submit" name="accion" value="verificar">
	            Verificar usuario
	        </button>
	
	        <!-- PREGUNTA -->
	        <label>Pregunta secreta</label>
	        <input type="text" name="pregunta"
	               value="<%= request.getAttribute("preguntaSecreta") != null ? request.getAttribute("preguntaSecreta") : "" %>"
	               readonly>
	
	        <!-- RESPUESTA -->
	        <label>Respuesta</label>
	        <input type="text" name="respuesta"
	               <%= (request.getAttribute("preguntaSecreta") == null ? "disabled" : "") %> required>
	
	        <!-- Reenvío oculto del usuario para la validación -->
	        <input type="hidden" name="usuario"
	               value="<%= request.getAttribute("usuario") != null ? request.getAttribute("usuario") : "" %>">
	
	        <button class="boton" type="submit" name="accion" value="responder"
	                <%= (request.getAttribute("preguntaSecreta") == null ? "disabled" : "") %>>
	            Verificar respuesta
	        </button>
	
	    </form>
	
	    <a href="Login.jsp" class="btn-volver">Volver Atrás</a>
	</div>
</body>
</html>