<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="entidades.Usuario" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Informes / Reportes</title>
<style>
    body{
        font-family: Arial, sans-serif;
        background-color: #f2f2f2;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }

    .contenedor{
        text-align: center;
        width: 400px;
    }

    h1{
        margin-bottom: 10px;
        font-size: 28px;
        font-weight: bold;
    }

    p{
        margin-bottom: 30px;
        font-size: 14px;
    }

    .boton{
        display: block;
        width: 100%;
        padding: 12px;
        margin: 10px 0;
        border: 1px solid #444;
        border-radius: 4px;
        background-color: white;
        cursor: pointer;
        text-decoration: none;
        color: black;
        font-size: 14px;
        transition: 0.2s;
        text-align: center;
    }

    .boton:hover{
        background-color: #e6e6e6;
    }

    .menu-container{
        position: absolute;
        top: 15px;
        right: 15px;
    }

    .menu-btn {
        background-color: white;
        border: 1px solid #444;
        padding: 6px 12px;
        cursor: pointer;
        border-radius: 4px;
    }

    .menu-content{
        display: none;
        position: absolute;
        right: 0;
        background-color: white;
        border: 1px solid #ccc;
        margin-top: 5px;
        border-radius: 4px;
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
<%
    Usuario u = (Usuario) session.getAttribute("usuarioLogueado");
    if (u == null) {
        response.sendRedirect("Login.jsp");
        return; // Evita seguir renderizando la página
    }
%>

<div class="menu-container">
    <button class="menu-btn">Menu</button>
    <div class="menu-content">
        <a href="InicioMenuAdministrador.jsp">Volver atrás</a>
        <a href="ABMLMenu.jsp">ABML Clientes</a>
        <a href="ABMLCuentas.jsp">ABML Cuentas</a>
        <a href="ServletPrestamos">Autorización de Préstamo</a>
    </div>
</div>

<div class="contenedor">
    <h1>Bienvenido <%= u.getNombreUsuario() %></h1>
    <p>Bienvenido/a al menú de Informes y Reportes</p>

    <a class="boton" href="ServletReporteMovimientos">Informe de movimientos</a>
    <a class="boton" href="ServletReportesUsuarios">Informe de usuarios</a>
</div>
</body>
</html>
