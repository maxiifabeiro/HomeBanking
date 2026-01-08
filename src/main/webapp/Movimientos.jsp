<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="entidades.Usuario" %>
<%@ page import="entidades.TipoCuenta" %>
<%@ page import="entidades.Movimientos" %>
<%@ page import="entidades.Cuenta" %>
<%@ page import="entidades.Transferencia" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Movimientos</title>

<style>
	body {
	    font-family: "Segoe UI", Arial, sans-serif;
	    background-color: #d9d9d9;
	}
	
	.container {
	    max-width: 1200px;
	    margin: 30px auto;
	    background-color: #f7f7f7;
	    padding: 25px;
	    border-radius: 12px;
	    box-shadow: 0 3px 10px rgba(0,0,0,0.15);
	}
	
	.header {
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	}
	
	.logo {
	    display: flex;
	    align-items: center;
	    gap: 10px;
	}
	
	.logo img {
	    width: 40px;
	}
	
	.saludo {
	    margin: 15px 0;
	}
	
	.buttons {
	    display: flex;
	    gap: 10px;
	    flex-wrap: wrap;
	    margin-bottom: 20px;
	}
	
	.buttons a {
	    background-color: #6ed6e8;
	    padding: 8px 16px;
	    border-radius: 6px;
	    text-decoration: none;
	    color: #000;
	    font-weight: 600;
	}
	
	.buttons a:hover {
	    background-color: #5ac3d6;
	}
	
	.filters {
	    display: flex;
	    align-items: center;
	    gap: 12px;
	    flex-wrap: wrap;
	    margin-bottom: 20px;
	}
	
	.filters input,
	.filters select {
	    padding: 6px 10px;
	    border-radius: 5px;
	    border: 1px solid #aaa;
	}
	
	.search-btn {
	    background-color: #4b75f5;
	    color: white;
	    border: none;
	    padding: 7px 14px;
	    border-radius: 6px;
	    cursor: pointer;
	}
	
	.search-btn:hover {
	    background-color: #3a63d1;
	}
	
	table {
	    width: 100%;
	    border-collapse: collapse;
	    background-color: white;
	}
	
	th {
	    background-color: #4b75f5;
	    color: white;
	}
	
	th, td {
	    padding: 10px;
	    border-bottom: 1px solid #ddd;
	    text-align: center;
	}
	
	tbody tr:hover {
	    background-color: #f0f4ff;
	}
	
	.sin-datos {
	    text-align: center;
	    font-weight: 600;
	    margin-top: 20px;
	}
	
	/* MENU */
	.menu {
	    position: relative;
	}
	
	.menu img {
	    width: 45px;
	    cursor: pointer;
	}
	
	.dropdown {
	    display: none;
	    position: absolute;
	    right: 0;
	    background-color: #f2f2f2;
	    border-radius: 6px;
	    box-shadow: 0 2px 6px rgba(0,0,0,0.2);
	}
	
	.menu.show .dropdown {
	    display: block;
	}
	
	.dropdown a {
	    display: block;
	    padding: 10px 16px;
	    text-decoration: none;
	    color: black;
	}
	
	.dropdown a:hover {
	    background-color: #ddd;
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
                <a href="InicioMenuCliente.jsp">Volver atrás</a>
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
    <div class="container">

        <h1>Hola <%= u.getNombreUsuario() %></h1>

        <!-- ===== BOTONES ===== -->
        <div class="buttons">
            <a href="ServletMovimientos">Ver movimientos</a>
            <a href="ServletTransferencia?accion=accion">Transferir dinero</a>
            <a href="ServletSolicitarPrestamo?opc=solicitarPrestamo">Solicitud de préstamo</a>
            <a href="ServletPagarPrestamo?opc=listarPrestamos">Pago de préstamo</a>
            <a href="ServletDescargarMovimientos?accion=descargar">Descargar resumen</a>
        </div>

        <!-- ===== FILTROS ===== -->
        <div class="card">
            <h3>Filtrar movimientos</h3>

            <form action="ServletMovimientos" method="GET" class="filters">
                <label>Desde</label>
                <input type="date" name="desde">

                <label>Hasta</label>
                <input type="date" name="hasta">

                <button class="search-btn" type="submit">Buscar</button>

                <%
                    List<Cuenta> listaCuentas = (List<Cuenta>) request.getAttribute("listaCuentas");
                    if (listaCuentas != null) {
                %>
                    <select name="cuenta" onchange="this.form.submit()">
                        <option value="">-- Todas las cuentas --</option>
                        <% for (Cuenta c : listaCuentas) { %>
                            <option value="<%= c.getCuenta_id() %>">
                                <%= c.getTipoCuenta().getDescripcion() %> - <%= c.getAlias() %>
                            </option>
                        <% } %>
                    </select>
                <% } %>

                <button type="submit" class="search-btn">
                    Todos los movimientos
                </button>
            </form>
        </div>

        <!-- ===== TABLA MOVIMIENTOS ===== -->
        <div class="card" style="margin-top:25px;">
            <h3>Historial de movimientos</h3>

            <%
                List<Movimientos> movimientos = (List<Movimientos>) request.getAttribute("movimientos");
                int pagina = (request.getParameter("page") != null)
                        ? Integer.parseInt(request.getParameter("page")) : 1;
                int pageSize = 10;

                if (movimientos != null && !movimientos.isEmpty()) {
                    int totalMovimientos = movimientos.size();
                    int totalPaginas = (int) Math.ceil((double) totalMovimientos / pageSize);
            %>

            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Fecha</th>
                        <th>Importe</th>
                        <th>Saldo</th>
                        <th>Origen</th>
                        <th>Destino</th>
                        <th>Estado</th>
                    </tr>
                </thead>
                <tbody>
                <% for (Movimientos m : movimientos) { %>
                    <tr>
                        <td><%= m.getMovimientoId() %></td>
                        <td><%= m.getFecha() %></td>
                        <td>$ <%= m.getImporte() %></td>
                        <td>$ <%= m.getSaldo().setScale(2) %></td>
                        <td><%= m.getTransferenciaId() != null ? m.getTransferenciaId().getAliasOrigen() : "-" %></td>
                        <td><%= m.getTransferenciaId() != null ? m.getTransferenciaId().getAliasDestino() : "-" %></td>
                        <td><%= m.getTransferenciaId() != null ? m.getTransferenciaId().getEstado() : "-" %></td>
                    </tr>
                <% } %>
                </tbody>
            </table>

            <!-- ===== PAGINACIÓN ===== -->
            <div style="margin-top:20px; text-align:center;">
                <% if (pagina > 1) { %>
                    <a href="?page=<%= pagina - 1 %>" class="search-btn">Anterior</a>
                <% } %>

                <span style="margin:0 15px;">
                    Página <%= pagina %> de <%= totalPaginas %>
                </span>

                <% if (pagina < totalPaginas) { %>
                    <a href="?page=<%= pagina + 1 %>" class="search-btn">Siguiente</a>
                <% } %>
            </div>

            <% } else { %>
                <p class="sin-datos">No se encontraron movimientos.</p>
            <% } %>
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
