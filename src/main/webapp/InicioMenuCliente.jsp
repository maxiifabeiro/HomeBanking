<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="entidades.Usuario" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Inicio Menu Cliente</title>
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
	    color: #4b75f5;
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
	    color: #4b75f5;
	}
	
	.card p {
	    margin-bottom: 0;
	    color: #555;
	}
	
	.card:hover {
	    transform: translateY(-4px);
	    box-shadow: 0 10px 20px rgba(0,0,0,0.12);
	}

</style>
</head>

<body>

    <!-- ===== HEADER ===== -->
    <div class="header">
        <div class="logo">
            <img src="images/Logo.png" alt="logo">
            <h2>HomeBanking</h2>
        </div>

        <div class="menu" id="menuUser">
            <img src="https://cdn-icons-png.flaticon.com/512/64/64572.png"
                 onclick="toggleMenu()">
            <div class="dropdown">
                <a href="Perfil.jsp">Perfil</a>
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

        <h1>Hola <%= u.getNombreUsuario() %></h1>
        <p class="subtitle">¿Qué operación querés realizar hoy?</p>

        <!-- ===== GRID DE ACCIONES ===== -->
        <div class="grid">

            <a href="ServletPerfil" class="card">
                <h3>Perfil</h3>
                <p>Ver y editar tus datos personales</p>
            </a>

            <a href="ServletMovimientos" class="card">
                <h3>Movimientos</h3>
                <p>Consultá tus movimientos y saldos</p>
            </a>

            <a href="ServletTransferencia?accion=accion" class="card">
                <h3>Transferencias</h3>
                <p>Enviar dinero entre cuentas o a terceros</p>
            </a>

            <a href="ServletSolicitarPrestamo?opc=solicitarPrestamo" class="card">
                <h3>Solicitar préstamo</h3>
                <p>Pedí un préstamo en pocos pasos</p>
            </a>

            <a href="ServletPagarPrestamo?opc=listarPrestamos" class="card">
                <h3>Pago de préstamo</h3>
                <p>Consultá y pagá tus cuotas</p>
            </a>

        </div>
    </div>

    <!-- ===== MENU SCRIPT ===== -->
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