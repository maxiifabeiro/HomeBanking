<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="entidades.Usuario" %>
<%@ page import="entidades.Cuenta" %>
<%@ page import="entidades.TipoPrestamo" %>
<%@ page import="negocioImpl.CuentaNegocioImpl" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HomeBanking</title>
	<style>
		body {
		    font-family: "Segoe UI", Arial, sans-serif;
		    background-color: #eef1f5;
		    margin: 0;
		    padding: 0;
		}

		/* ===== HEADER ===== */
		.header {
		    background-color: #ffffff;
		    padding: 15px 30px;
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		    box-shadow: 0 2px 6px rgba(0,0,0,0.1);
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
		    color: #4b75f5;
		    margin: 0;
		}
		
		/* ===== USER MENU ===== */
		.menu img {
		    width: 42px;
		    border-radius: 50%;
		    background-color: #f1f1f1;
		    padding: 6px;
		    cursor: pointer;
		}
		
		.dropdown {
		    display: none;
		    position: absolute;
		    right: 30px;
		    top: 70px;
		    background-color: #ffffff;
		    min-width: 180px;
		    box-shadow: 0 4px 10px rgba(0,0,0,0.15);
		    border-radius: 8px;
		    overflow: hidden;
		}
		
		.dropdown a {
		    padding: 12px 16px;
		    display: block;
		    text-decoration: none;
		    color: #333;
		    font-size: 14px;
		}
		
		.dropdown a:hover {
		    background-color: #f0f2f7;
		}
		
		.menu.show .dropdown {
		    display: block;
		}
		
		/* ===== MAIN CONTAINER ===== */
		.main {
		    max-width: 1000px;
		    margin: 30px auto;
		    padding: 0 20px;
		}
		
		/* ===== ACTION BUTTONS ===== */
		.buttons {
		    display: flex;
		    gap: 15px;
		    margin-bottom: 30px;
		}
		
		.buttons a {
		    background-color: #4b75f5;
		    color: #ffffff;
		    padding: 10px 20px;
		    border-radius: 8px;
		    text-decoration: none;
		    font-weight: 500;
		    transition: background 0.2s;
		}
		
		.buttons a:hover {
		    background-color: #3a5edc;
		}
		
		/* ===== CARD ===== */
		.card {
		    background-color: #ffffff;
		    border-radius: 12px;
		    padding: 25px;
		    box-shadow: 0 4px 10px rgba(0,0,0,0.08);
		}
		
		/* ===== FORM ===== */
		.card h3 {
		    margin-top: 0;
		    margin-bottom: 20px;
		    color: #333;
		}
		
		ul {
		    list-style: none;
		    padding: 0;
		}
		
		li {
		    margin-bottom: 18px;
		    display: flex;
		    flex-direction: column;
		    font-weight: 500;
		    color: #444;
		}
		
		select {
		    margin-top: 6px;
		    padding: 10px;
		    border-radius: 8px;
		    border: 1px solid #ccc;
		    font-size: 14px;
		}
		
		select:focus {
		    outline: none;
		    border-color: #4b75f5;
		}
		
		/* ===== BUTTON ===== */
		.search-btn {
		    background-color: #4b75f5;
		    color: #ffffff;
		    border: none;
		    padding: 12px 25px;
		    border-radius: 8px;
		    font-size: 15px;
		    cursor: pointer;
		    margin-top: 10px;
		}
		
		.search-btn:hover {
		    background-color: #3a5edc;
		}
		
		/* ===== MESSAGES ===== */
		.error {
		    margin-top: 15px;
		    color: #d32f2f;
		    font-weight: 500;
		}
		
		.success {
		    margin-top: 15px;
		    color: #2e7d32;
		    font-weight: 500;
		}
				
	</style>
</head>
<body>

<%
    Usuario u = (Usuario) session.getAttribute("usuarioLogueado");
    CuentaNegocioImpl Cni = new CuentaNegocioImpl();

    if (u == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    int clienteId = Cni.obtenerClientePorUsuario(u.getUsuarioId());

    List<Cuenta> listaCuentas = (List<Cuenta>) request.getAttribute("listaCuentas");
    List<TipoPrestamo> tipoPrestamo = (List<TipoPrestamo>) request.getAttribute("tiposPrestamo");

%>

<%
    String url = request.getRequestURI();
%>

    <div class="header">
        <div class="logo">
            <img src="images/Logo.png" alt="logo">
            <h2 style="color:#4b75f5;">HomeBanking</h2>
        </div>

        <div class="menu" id="menuUser">
            <img src="https://cdn-icons-png.flaticon.com/512/64/64572.png" alt="user" onclick="toggleMenu()">
            <div class="dropdown" id="dropdownMenu">
                <a href="Perfil.jsp">Perfil</a>
                <a href="InicioMenuCliente.jsp">Volver atras</a>
            </div>
        </div>
    </div>

    <div class="main">

    <p>Hola <strong><%= u.getNombreUsuario() %></strong></p>

    <div class="buttons">
        <a href="ServletMovimientos">Ver movimientos</a>
        <a href="ServletTransferencia?accion=accion">Transferir dinero</a>
        <a href="ServletPagarPrestamo?opc=listarPrestamos">Pago de Préstamo</a>
    </div>

    <div class="card">
        <h3>Solicitar Préstamo</h3>

        <form action="ServletSolicitarPrestamo" method="post">
            <input type="hidden" name="cliente_id" value="<%= clienteId %>">

		<ul>
			    <li>
			        Monto a solicitar 
			        <select name="monto">
			            <option value="1000000">$1.000.000</option>
			            <option value="2000000">$2.000.000</option>
			            <option value="3000000">$3.000.000</option>
			        </select>
			    </li>
			
			    <li>
			        Cantidad de cuotas 
			        <select name="cuotas">
			            <option value="3">3</option>
			            <option value="6">6</option>
			            <option value="9">9</option>
			            <option value="12">12</option>
			        </select>
			    </li>
			
			    <li>
			        Tipo de préstamo 
					<select name="TipoPrestamo">
					<option value="">-- Seleccione un tipo de prestamo --</option>
					<% for (TipoPrestamo p : tipoPrestamo) { %>
					    <option value="<%= p.getTipo_prestamo_id() %>">
					        <%= p.getDescripcion()%>
					    </option>
					<% } %>
					</select>
			    </li>
			
			    <!-- SELECTOR DE CUENTAS DEL USUARIO -->
			    <li>
			        Seleccionar cuenta 
					<select name="cuenta_id">
					<option value="">-- Seleccione una cuenta --</option>
					<% for (Cuenta c : listaCuentas) { %>
					    <option value="<%= c.getCuenta_id() %>">
					        <%= c.getTipoCuenta().getDescripcion() %>
					    </option>
					<% } %>
					</select>
			    </li>
			
			</ul>

            <button type="submit" class="search-btn">
                Solicitar Préstamo
            </button>

            <div class="error">
                <%= request.getAttribute("mensajeError") != null ? request.getAttribute("mensajeError") : "" %>
            </div>

            <div class="success">
                <%= request.getAttribute("mensajeExito") != null ? request.getAttribute("mensajeExito") : "" %>
            </div>
        </form>
    </div>

</div>

	
	<script>
	function toggleMenu() {
	    document.getElementById("menuUser").classList.toggle("show");
	}
	
	window.onclick = function(event) {
	    if (!event.target.matches('.menu img')) {
	        var dropdowns = document.getElementsByClassName("menu");
	        for (var i = 0; i < dropdowns.length; i++) {
	            var openDropdown = dropdowns[i];
	            openDropdown.classList.remove('show');
	        }
	    }
	}
	</script>

</body>
</html>
