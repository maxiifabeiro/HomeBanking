<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="entidades.Usuario" %>
<%@ page import="entidades.Cuenta" %>
<%@ page import="entidades.TipoMovimiento" %>
<%
    Usuario u = (Usuario) session.getAttribute("usuarioLogueado");
    if (u == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>

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
	    color: #4b75f5;
	    margin: 0;
	}
	
	/* ===== USER MENU ===== */
	.menu {
	    position: relative;
	}
	
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
	    right: 0;
	    top: 60px;
	    background-color: #ffffff;
	    min-width: 180px;
	    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
	    border-radius: 10px;
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
	
	/* ===== MAIN ===== */
	.main {
	    max-width: 1100px;
	    margin: 30px auto;
	    padding: 0 20px;
	}
	
	h1 {
	    margin-top: 0;
	    font-size: 26px;
	    color: #333;
	}
	
	/* ===== ACTION BUTTONS ===== */
	.buttons {
	    display: flex;
	    flex-wrap: wrap;
	    gap: 15px;
	    margin: 20px 0 30px;
	}
	
	.buttons a {
	    background-color: #4b75f5;
	    color: #ffffff;
	    padding: 10px 22px;
	    border-radius: 10px;
	    text-decoration: none;
	    font-weight: 500;
	    transition: background 0.2s;
	}
	
	.buttons a:hover {
	    background-color: #3a5edc;
	}
	
	/* ===== MESSAGES ===== */
	.msg-ok {
	    background: #e6f7ec;
	    border-left: 5px solid #2e7d32;
	    padding: 12px;
	    border-radius: 6px;
	    margin-bottom: 20px;
	}
	
	.msg-error {
	    background: #fdecea;
	    border-left: 5px solid #d32f2f;
	    padding: 12px;
	    border-radius: 6px;
	    margin-bottom: 20px;
	}
	
	/* ===== CARDS ===== */
	.container {
	    display: grid;
	    grid-template-columns: repeat(auto-fit, minmax(420px, 1fr));
	    gap: 30px;
	}
	
	.card {
	    background-color: #ffffff;
	    border-radius: 14px;
	    padding: 25px;
	    box-shadow: 0 6px 14px rgba(0,0,0,0.08);
	}
	
	.card h3 {
	    margin-top: 0;
	    margin-bottom: 20px;
	    color: #333;
	}
	
	/* ===== FORM ===== */
	label {
	    font-weight: 500;
	    color: #444;
	}
	
	input,
	select {
	    width: 100%;
	    padding: 11px;
	    margin: 6px 0 15px;
	    border-radius: 8px;
	    border: 1px solid #ccc;
	    font-size: 14px;
	}
	
	input:focus,
	select:focus {
	    outline: none;
	    border-color: #4b75f5;
	}
	
	/* ===== BUTTON ===== */
	.btn {
	    width: 100%;
	    background-color: #4b75f5;
	    color: #ffffff;
	    border: none;
	    padding: 12px;
	    border-radius: 10px;
	    font-size: 15px;
	    font-weight: 600;
	    cursor: pointer;
	}
	
	.btn:hover {
	    background-color: #3a5edc;
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
            <img 
                src="https://cdn-icons-png.flaticon.com/512/64/64572.png"
                alt="user"
                onclick="toggleMenu()">

            <div class="dropdown">
                <a href="Perfil.jsp">Perfil</a>
                <a href="Login.jsp">Cerrar sesión</a>
            </div>
        </div>

    </div>

    <!-- ===== MAIN ===== -->
    <div class="main">

        <h1>Hola <%= u.getNombreUsuario() %></h1>

        <!-- ===== BOTONES ===== -->
        <div class="buttons">
            <a href="ServletMovimientos">Ver movimientos</a>
            <a href="ServletTransferencia?accion=accion">Transferir dinero</a>
            <a href="ServletSolicitarPrestamo?opc=solicitarPrestamo">Solicitud de préstamo</a>
            <a href="ServletPagarPrestamo?opc=listarPrestamos">Pago de Préstamo</a>
        </div>

        <!-- ===== MENSAJES ===== -->
        <% if (request.getAttribute("mensaje") != null) { %>
            <div class="msg-ok"><%= request.getAttribute("mensaje") %></div>
        <% } %>

        <% if (request.getAttribute("error") != null) { %>
            <div class="msg-error"><%= request.getAttribute("error") %></div>
        <% } %>

        <!-- ===== FORMULARIOS ===== -->
        <div class="container">

            <!-- CUENTAS PROPIAS -->
            <div class="card">
                <h3>Transferencias entre cuentas propias</h3>

                <form action="ServletTransferencia" method="post">
                    <input type="hidden" name="accion" value="propias">

                    <label>Cuenta origen</label>
                    <select name="cuentaOrigen" required>
                        <option value="">Seleccione origen...</option>
                        <% 
                            List<Cuenta> listaCuentas = (List<Cuenta>) request.getAttribute("listaCuentas");
                            if (listaCuentas != null) {
                                for (Cuenta c : listaCuentas) { 
                        %>
                            <option value="<%= c.getCuenta_id() %>">
                                <%= c.getAlias() %> - <%= c.getCbu() %>
                            </option>
                        <% 
                                }
                            }
                        %>
                    </select>

                    <label>Cuenta destino</label>
                    <select name="cuentaDestino" required>
                        <option value="">Seleccione destino...</option>
                        <% 
                            if (listaCuentas != null) {
                                for (Cuenta c : listaCuentas) {
                        %>
                            <option value="<%= c.getCuenta_id() %>">
                                <%= c.getAlias() %> - <%= c.getCbu() %>
                            </option>
                        <% 
                                }
                            }
                        %>
                    </select>

                    <label>Monto</label>
                    <input type="number" name="importe" step="0.01" required>

                    <label>Motivo / Detalle</label>
                    <select name="Motivo" required>
                        <option value="">Seleccione un motivo</option>
                        <% 
                            List<TipoMovimiento> tipoMov = (List<TipoMovimiento>) request.getAttribute("tiposMovimientos");
                            if (tipoMov != null) {
                                for (TipoMovimiento t : tipoMov) { 
                        %>
                            <option value="<%= t.getTipoMovimiento_id() %>">
                                <%= t.getDescripcion() %>
                            </option>
                        <% 
                                }
                            }
                        %>
                    </select>

                    <button class="btn" type="submit">
                        Enviar transferencia
                    </button>
                </form>
            </div>

            <!-- TERCEROS -->
            <div class="card">
                <h3>Transferencias a terceros</h3>

                <form action="ServletTransferencia" method="post">
                    <input type="hidden" name="accion" value="terceros">

                    <label>Cuenta origen</label>
                    <select name="cuentaOrigen" required>
                        <option value="">Seleccione origen...</option>
                        <% 
                            if (listaCuentas != null) {
                                for (Cuenta c : listaCuentas) { 
                        %>
                            <option value="<%= c.getCuenta_id() %>">
                                <%= c.getAlias() %> - <%= c.getCbu() %>
                            </option>
                        <% 
                                }
                            }
                        %>
                    </select>

                    <label>CBU o Alias destino</label>
                    <input type="text" name="cbuAlias"
                           pattern="[a-zA-Z0-9._-]{6,30}" required>

                    <label>Monto</label>
                    <input type="number" name="importe" step="0.01" required>

                    <label>Motivo / Detalle</label>
                    <select name="Motivo" required>
                        <option value="">Seleccione un motivo</option>
                        <% 
                            if (tipoMov != null) {
                                for (TipoMovimiento t : tipoMov) { 
                        %>
                            <option value="<%= t.getTipoMovimiento_id() %>">
                                <%= t.getDescripcion() %>
                            </option>
                        <% 
                                }
                            }
                        %>
                    </select>

                    <button class="btn" type="submit">
                        Enviar transferencia
                    </button>
                </form>
            </div>

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
