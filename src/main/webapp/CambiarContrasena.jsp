<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String usuario = (String) session.getAttribute("usuarioVerificado");
    if(usuario == null){
        response.sendRedirect("OlvidasteTuContrasena.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cambiar Contraseña</title>
<style>
	body{
	    font-family: Arial, sans-serif;
	    background-color: #e9f0f7;
	    display: flex;
	    justify-content: center;
	    align-items: center;
	    height: 100vh;
	    margin: 0;
	}
	
	.contenedor{
	    background: white;
	    width: 450px;
	    padding: 40px;
	    border-radius: 12px;
	    box-shadow: 0 4px 20px rgba(0,0,0,0.15);
	    text-align: center;
	}
	
	h1{
	    color: #0d4ea6;
	    font-size: 32px;
	    margin-bottom: 10px;
	}
	
	label{
	    font-weight: bold;
	    font-size: 14px;
	    display: block;
	    margin-bottom: 5px;
	    text-align: left;
	}
	
	input{
	    width: 100%;
	    padding: 10px;
	    margin-bottom: 15px;
	    border: 1px solid #ccc;
	    border-radius: 6px;
	    font-size: 14px;
	}
	
	.boton{
	    background-color: #2d8be7;
	    color: white;
	    border: none;
	    padding: 10px 15px;
	    cursor: pointer;
	    margin-top: 8px;
	    border-radius: 6px;
	    width: 100%;
	    font-size: 15px;
	    transition: background-color .2s ease;
	}
	
	.boton:hover{
	    background-color: #176ac2;
	}
	
	.btn-volver{
	    display: inline-block;
	    margin-top: 25px;
	    padding: 10px 20px;
	    background-color: #7d8b92;
	    color: white;
	    border-radius: 6px;
	    text-decoration: none;
	    font-size: 14px;
	    transition: background-color .2s ease;
	}
	
	.btn-volver:hover{
	    background-color: #4f5a60;
	}
	
	.mensaje{
	    font-weight: bold;
	    margin-bottom: 15px;
	    padding: 10px;
	    border-radius: 6px;
	}
	
	.mensaje.exito{
	    color: #0d6b1f;
	    background: #d8f5dd;
	}
	
	.mensaje.error{
	    color: #b40000;
	    background: #ffd9d9;
	}

</style>
</head>
	<body>
		<div class="contenedor">
	<h1>Cambiar contraseña</h1>
	<h3>Usuario: <%= usuario %></h3>
	
	<% if(request.getAttribute("mensaje") != null){ %>
	    <div class="mensaje <%= request.getAttribute("verificado") != null ? "exito" : "" %>">
	        <%= request.getAttribute("mensaje") %>
	    </div>
	<% } %>
	
	<form action="ServletRecuperarContrasena" method="post">
	    <label>Nueva contraseña</label>
	    <input type="password" name="nuevaPass" pattern="(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}" required>
	    <label>Confirmar contraseña</label>
	    <input type="password" name="confirmarPass" id="txtConfirmarContraseña" pattern="(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}" required>
	    <button class="boton" type="submit" name="accion" value="cambiar" >Cambiar contraseña</button>
	    
	    <div>
	    	 <a href="Login.jsp" class="btn-volver">Volver Atras</a>
	    </div>
	</form>
	</div>
</body>
<script>
document.getElementById("txtConfirmarContraseña").addEventListener("input", function () {
    const pass = document.getElementById("txtContraseña").value;
    const confirm = this.value;

    if (confirm !== pass) {
        this.setCustomValidity("Las contraseñas no coinciden");
    } else {
        this.setCustomValidity("");
    }
});
</script>

</html>
