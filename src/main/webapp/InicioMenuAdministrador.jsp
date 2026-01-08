<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="entidades.Usuario" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Inicio Menu Administrador</title>

<style>
	body {
	    font-family: "Segoe UI", Arial, sans-serif;
	    background-color: #eef1f5;
	    margin: 0;
	}
	
	/* HEADER */
	.header {
	    background-color: white;
	    padding: 15px 30px;
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
	}
	
	.header.admin h2 {
	    color: #2c3e50;
	}
	
	.logo {
	    display: flex;
	    align-items: center;
	}
	
	.logo img {
	    width: 42px;
	    margin-right: 10px;
	}
	
	.logo h2 {
	    margin: 0;
	}
	
	/* MENU */
	.menu {
	    position: relative;
	}
	
	.menu img {
	    width: 40px;
	    cursor: pointer;
	}
	
	.dropdown {
	    display: none;
	    position: absolute;
	    right: 0;
	    top: 50px;
	    background-color: white;
	    border-radius: 10px;
	    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
	    overflow: hidden;
	}
	
	.menu.show .dropdown {
	    display: block;
	}
	
	.dropdown a {
	    display: block;
	    padding: 12px 16px;
	    text-decoration: none;
	    color: #333;
	}
	
	.dropdown a:hover {
	    background-color: #f0f2f7;
	}
	
	/* MAIN */
	.main {
	    max-width: 1100px;
	    margin: 40px auto;
	    padding: 0 20px;
	}
	
	h1 {
	    font-size: 26px;
	    margin-bottom: 5px;
	}
	
	.subtitle {
	    color: #666;
	    margin-bottom: 30px;
	}
	
	/* GRID */
	.grid {
	    display: grid;
	    grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
	    gap: 25px;
	}
	
	/* CARDS */
	.card {
	    background-color: white;
	    border-radius: 14px;
	    padding: 25px;
	    text-decoration: none;
	    color: #333;
	    box-shadow: 0 6px 14px rgba(0,0,0,0.08);
	    transition: transform 0.2s, box-shadow 0.2s;
	}
	
	.card h3 {
	    margin-top: 0;
	}
	
	.card p {
	    margin-bottom: 0;
	    color: #555;
	}
	
	.card:hover {
	    transform: translateY(-4px);
	    box-shadow: 0 10px 20px rgba(0,0,0,0.12);
	}
	
	/* ADMIN COLOR */
	.admin-card h3 {
	    color: #2c3e50;
	}

</style>
</head>

<body>

    <!-- ===== HEADER ===== -->
    <div class="header admin">
        <div class="logo">
            <img src="images/Logo.png" alt="logo">
            <h2>HomeBanking · Admin</h2>
        </div>

        <div class="menu" id="menuUser">
            <img src="https://cdn-icons-png.flaticon.com/512/64/64572.png"
                 onclick="toggleMenu()">
            <div class="dropdown">
                <a href="Login.jsp">Cerrar sesión</a>
            </div>
        </div>
    </div>

    <%
        Usuario u = (Usuario) session.getAttribute("usuarioLogueado");
        if (u == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
    %>

    <!-- ===== MAIN ===== -->
    <div class="main">

        <h1>Bienvenido <%= u.getNombreUsuario() %></h1>
        <p class="subtitle">Panel de administración del sistema</p>

        <!-- ===== GRID ===== -->
        <div class="grid">

            <a href="ABMLMenu.jsp" class="card admin-card">
                <h3>ABML Clientes</h3>
                <p>Alta, baja, modificación y listado de clientes</p>
            </a>

            <a href="ABMLCuentas.jsp" class="card admin-card">
                <h3>ABML Cuentas</h3>
                <p>Gestión completa de cuentas bancarias</p>
            </a>

            <a href="ServletPrestamos" class="card admin-card">
                <h3>Autorizar préstamos</h3>
                <p>Revisión y aprobación de solicitudes</p>
            </a>

            <a href="Reportes.jsp" class="card admin-card">
                <h3>Reportes</h3>
                <p>Estadísticas y reportes del sistema</p>
            </a>

        </div>
    </div>

    <!-- ===== SCRIPT MENU ===== -->
    <script>
        function toggleMenu() {
            document.getElementById("menuUser").classList.toggle("show");
        }

        window.onclick = function(event) {
            if (!event.target.matches('.menu img')) {
                document.getElementById("menuUser").classList.remove("show");
            }
        }
    </script>

</body>

</html>