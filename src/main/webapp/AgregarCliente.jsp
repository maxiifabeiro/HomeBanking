<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="entidades.Pais"%>
<%@page import="entidades.Provincias"%>
<%@page import="entidades.Localidades"%>
<%@page import="entidades.Pregunta"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Agregar Cliente</title>
</head>

<style>
     /* ===== RESET ===== */
	* {
	    box-sizing: border-box;
	    font-family: "Segoe UI", Arial, sans-serif;
	}
	
	body {
	    margin: 0;
	    background-color: #d9d9d9;
	}
	
	/* ===== HEADER ===== */
	.header {
	    background-color: #2f3e9e;
	    color: white;
	    padding: 12px 30px;
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	}
	
	.header.admin {
	    background-color: #2f3e9e;
	}
	
	.logo {
	    display: flex;
	    align-items: center;
	    gap: 10px;
	}
	
	.logo img {
	    width: 40px;
	    height: 40px;
	}
	
	.logo h2 {
	    margin: 0;
	    font-size: 22px;
	}
	
	/* ===== MENU USUARIO ===== */
	.menu {
	    position: relative;
	}
	
	.menu img {
	    width: 35px;
	    cursor: pointer;
	}
	
	.menu .dropdown {
	    display: none;
	    position: absolute;
	    right: 0;
	    top: 45px;
	    background: white;
	    border-radius: 6px;
	    min-width: 180px;
	    box-shadow: 0 4px 10px rgba(0,0,0,0.2);
	}
	
	.menu.show .dropdown {
	    display: block;
	}
	
	.menu .dropdown a {
	    display: block;
	    padding: 12px;
	    color: black;
	    text-decoration: none;
	}
	
	.menu .dropdown a:hover {
	    background-color: #eee;
	}
	
	/* ===== CONTENIDO ===== */
	.main {
	    max-width: 1100px;
	    margin: 40px auto;
	    padding: 0 20px;
	}
	
	h1 {
	    text-align: center;
	    margin-bottom: 5px;
	}
	
	.subtitle {
	    text-align: center;
	    color: #444;
	    margin-bottom: 30px;
	}
	
	/* ===== FORMULARIO ===== */
	.form-card {
	    background: white;
	    padding: 35px;
	    border-radius: 10px;
	    box-shadow: 0 5px 15px rgba(0,0,0,0.15);
	}
	
	.form-card h3 {
	    margin-top: 30px;
	    border-bottom: 2px solid #2f3e9e;
	    padding-bottom: 5px;
	    color: #2f3e9e;
	}
	
	/* filas */
	.form-row {
	    display: flex;
	    gap: 20px;
	    margin-top: 20px;
	    flex-wrap: wrap;
	}
	
	/* grupos */
	.form-group {
	    flex: 1;
	    min-width: 250px;
	    display: flex;
	    flex-direction: column;
	}
	
	.form-group label {
	    font-size: 14px;
	    margin-bottom: 5px;
	    font-weight: 600;
	}
	
	/* inputs */
	.form-group input,
	.form-group select {
	    padding: 8px;
	    border-radius: 5px;
	    border: 1px solid #999;
	    font-size: 14px;
	}
	
	.form-group input:focus,
	.form-group select:focus {
	    outline: none;
	    border-color: #2f3e9e;
	}
	
	/* ===== BOTÓN ===== */
	.primary-btn {
	    margin: 40px auto 0 auto;
	    display: block;
	    padding: 12px 30px;
	    background-color: #e60000;
	    color: white;
	    font-weight: bold;
	    border: none;
	    border-radius: 6px;
	    cursor: pointer;
	    font-size: 16px;
	}
	
	.primary-btn:hover {
	    background-color: #b00000;
	}
	
	/* ===== MENSAJES ===== */
	.error {
	    margin-top: 15px;
	    text-align: center;
	    color: red;
	    font-weight: bold;
	}
	
	.success {
	    margin-top: 15px;
	    text-align: center;
	    color: green;
	    font-weight: bold;
	}

</style>

</head>
<body>

<!-- HEADER -->
<div class="header admin">
    <div class="logo">
        <img src="images/Logo.png" alt="logo">
        <h2>HomeBanking</h2>
    </div>

    <div class="menu" id="menuUser">
        <img src="https://cdn-icons-png.flaticon.com/512/64/64572.png"
             onclick="toggleMenu()">
        <div class="dropdown">
            <a href="ABMLMenu.jsp">Volver al menú</a>
            <a href="Login.jsp">Cerrar sesión</a>
        </div>
    </div>
</div>

<div class="main">

    <h1>Nuevo Cliente</h1>
    <p class="subtitle">Carga de datos personales y usuario</p>

    <form action="ServletCliente" method="post" class="form-card">
        <input type="hidden" name="opc" value="agregar">

        <h3>Datos Personales</h3>

        <div class="form-row">
            <div class="form-group">
                <label>Nombre</label>
                <input type="text" name="txtNombre" required>
            </div>
            <div class="form-group">
                <label>Apellido</label>
                <input type="text" name="txtApellido" required>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>DNI</label>
                <input type="text" name="txtDNI" maxlength="8" required>
            </div>
            <div class="form-group">
                <label>CUIT</label>
                <input type="text" name="txtCUIT" maxlength="11" required>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>Sexo</label>
                <select name="txtSexo" required>
                    <option value="">Seleccione</option>
                    <option value="M">Masculino</option>
                    <option value="F">Femenino</option>
                    <option value="X">X</option>
                </select>
            </div>

            <div class="form-group">
                <label>País</label>
                <select name="txtPais" id="cboPais" onchange="cargarProvincias()" required>
                    <option value="">Seleccione país</option>
                    <% 
                        List<Pais> paises = (List<Pais>) request.getAttribute("paises");
                        if (paises != null) {
                            for (Pais p : paises) {
                    %>
                        <option value="<%= p.getPais_id() %>"><%= p.getNombre() %></option>
                    <% } } %>
                </select>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>Fecha de nacimiento</label>
                <input type="date" name="txtFechaNacimiento" required>
            </div>
        </div>

        <h3>Contacto</h3>

        <div class="form-row">
            <div class="form-group">
                <label>Dirección</label>
                <input type="text" name="txtDireccion" required>
            </div>

            <div class="form-group">
                <label>Provincia</label>
                <select id="txtProvincia" name="txtProvincia" onchange="cargarLocalidades()" required>
                    <option value="">Seleccione provincia</option>
                </select>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>Localidad</label>
                <select id="txtLocalidad" name="txtLocalidad" required>
                    <option value="">Seleccione localidad</option>
                </select>
            </div>

            <div class="form-group">
                <label>Teléfono</label>
                <input type="text" name="txtTelefono" required>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>Email</label>
                <input type="email" name="txtEmail" required>
            </div>
        </div>

        <h3>Usuario</h3>

        <div class="form-row">
            <div class="form-group">
                <label>Usuario</label>
                <input type="text" name="txtNombreUsuario" required>
            </div>

            <div class="form-group">
                <label>Contraseña</label>
                <input type="password" id="txtContraseña" name="txtContraseña" required>
            </div>

            <div class="form-group">
                <label>Confirmar</label>
                <input type="password" id="txtConfirmarContraseña" name="txtConfirmarContraseña" required>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>Pregunta secreta</label>
                <select name="txtPregunta">
                    <option value="">Seleccione</option>
                    <% 
                        List<Pregunta> preguntas = (List<Pregunta>) request.getAttribute("pregunta");
                        if (preguntas != null) {
                            for (Pregunta pr : preguntas) {
                    %>
                        <option value="<%= pr.getPregunta_id() %>"><%= pr.getDescripcion() %></option>
                    <% } } %>
                </select>
            </div>

            <div class="form-group">
                <label>Respuesta</label>
                <input type="text" name="txtRespuesta" required>
            </div>
        </div>

        <button type="submit" class="primary-btn">Agregar Cliente</button>

        <p class="error"><%= request.getAttribute("mensajeError") != null ? request.getAttribute("mensajeError") : "" %></p>
        <p class="success"><%= request.getAttribute("mensajeExito") != null ? request.getAttribute("mensajeExito") : "" %></p>

    </form>
</div>

<script>
function toggleMenu() {
    document.getElementById("menuUser").classList.toggle("show");
}
</script>
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

function cargarProvincias() {

    let paisId = document.getElementById("cboPais").value;

    fetch('ServletCliente?opc=provincias&paisId=' + paisId)
        .then(res => res.text())
        .then(data => {

            document.getElementById("txtProvincia").innerHTML =
                '<option value="">-- Seleccione provincia --</option>' + data;

            document.getElementById("txtLocalidad").innerHTML =
                '<option value="">-- Seleccione localidad --</option>';
        });

}

function cargarLocalidades () {

    let provId = document.getElementById("txtProvincia").value;

    fetch('ServletCliente?opc=localidades&provinciaId=' + provId)
        .then(res => res.text())
        .then(data => {

            document.getElementById("txtLocalidad").innerHTML =
                '<option value="">-- Seleccione localidad --</option>' + data;

        });
}

</script>
</body>
</html>