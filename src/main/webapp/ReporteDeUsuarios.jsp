<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="entidades.Usuario" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reporte De Usuarios</title>
<style>
    body {
        font-family: "Segoe UI", Arial, sans-serif;
        margin: 0;
        padding: 20px;
        background-color: #f8f8f8;
        display: flex;
        justify-content: center;
    }

    .page-wrapper {
        width: 100%;
        max-width: 900px;
    }

    h3 {
        margin-top: 0;
    }

    .container {
        display: block; 
        width: 100%;
    }

    .card {
        background: #fff;
        border-radius: 12px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        padding: 20px;
        width: 100%;
        max-width: 800px;
        margin: 0 auto 25px auto;
    }

    label {
        font-weight: 500;
        display: block;
        margin-bottom: 5px;
    }

    .field {
        margin-bottom: 15px;
    }

    input[type="text"],
    input[type="date"] {
        padding: 8px;
        width: 100%;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-sizing: border-box;
    }

    button {
        margin-top: 10px;
        background-color: #ccc;
        border: none;
        padding: 8px 15px;
        border-radius: 5px;
        cursor: pointer;
    }

    button:hover {
        background-color: #bbb;
    }
    
	.menu-container{
	    position: fixed;     
	    top: 20px;
	    right: 20px;         
	    z-index: 999;
	}
	
	.menu-btn{
	    padding: 8px 15px;
	    border: none;
	    background: #ccc;
	    border-radius: 5px;
	    cursor: pointer;
	}
	
	.menu-content{
	    display: none;
	    position: absolute;
	    top: 40px;
	    right: 0;
	    background-color: white;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	    min-width: 150px;
	}
	
	.menu-content a{
	    display: block;
	    padding: 8px 12px;
	    text-decoration: none;
	    color: black;
	}
	
	.menu-content a:hover{
	    background-color: #eee;
	}
	
	.menu-container:hover .menu-content{
	    display: block;
	}

</style>
</head>
<body>
	<div class="menu-container">
	    <button class="menu-btn">Menu</button>
	    <div class="menu-content">
	    	<a href="ServletReporteMovimientos">Reporte de Movimientos</a>
	        <a href="InicioMenuAdministrador.jsp">Volver atrás</a>
	    </div>
	</div>
	
	<div class="page-wrapper">
	
	   <%
	        Usuario u = (Usuario) session.getAttribute("usuarioLogueado");
	        if (u != null) {
	        %>
	            <h1>Bienvenido <%= u.getNombreUsuario() %></h1>
	        <%
	        } else {
	            response.sendRedirect("Login.jsp");
	        }
	    %>
	
	<form action="ServletReportesUsuarios" method="post">
	
	    <div class="container">
	        <div class="card">
	            <h3>Informe de Usuarios Activos</h3>
	
	            <div class="field">
	                <label>Desde:</label>
	                <input type="date" name="desdeUsuarios" value="${desdeUsuarios}">
	            </div>
	
	            <div class="field">
	                <label>Hasta:</label>
	                <input type="date" name="hastaUsuarios" value="${hastaUsuarios}">
	            </div>
	
	            <button type="submit">Buscar</button>
	        </div>
	    </div>
	
	    <!-- Resultados Usuarios -->
	    <div class="container">
	        <div class="card">
	            <h3>Resultados</h3>
	
	            <div class="field">
	                <label>Total de cuentas registradas:</label>
	                <input type="text" name="totalUsuarios" value="${totalUsuarios}" readonly>
	            </div>
	
	            <div class="field">
	                <label>Nuevas cuentas en el período:</label>
	                <input type="text" name="nuevosUsuarios" value="${nuevosUsuarios}" readonly>
	            </div>
	        </div>
	    </div>
	
	</form>
	
	</div> 
</body>
</html>