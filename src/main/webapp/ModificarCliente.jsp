<%@page import="entidades.Cliente"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="entidades.Pais"%>
<%@page import="entidades.Provincias"%>
<%@page import="entidades.Localidades"%>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Modificar Cliente</title>
<style>
	body{
		font-family: Serif, sans-serif;
		background-color: #ffffff;
		margin: 0;
        padding: 20px;
	}
	
	.pagina{
		text-align: center;
	}
	
	.buscar-dni{
		display: inline-flex;
		gap: 10px;
        margin-bottom: 8px;
    }
	
	.buscar-dni p {
		font-size: 18px;
		margin-top: 4px;
	}
	
	.buscar-dni .boton {
		font-size: 15px;
		width: 18%;	
		height: 18%;
	}
	
	.buscar-dni .cajaTexto {
		width: 35%;	
		height: 30%;
	}

	label{
        font-size: 15px;
        margin-bottom: 5px;
    }
	
	.boton{
		background-color: #4cc4f0;
		border-radius: 4px;
		border-color: #70d0f3;
		font-weight: bold;
		font-size: 15px;
		color: black;
		padding: 5px 15px;
		cursor: pointer;
	}
	.boton:hover{
		background-color: #94dcf6;
		border-color: #b7e7f9;
		color: white;
	}
	
	.seccion{
        padding: 20px;
        width: 35%;
        margin: 0 auto;
	}
	
	.form-row{
        display: flex;
        justify-content: space-between;
        margin-left: 15px;
        margin-right: 15px;
        margin-bottom: 15px;
        
    }

    .form-group{
        display: flex;
        flex-direction: column;
        width: 150px;
    }
    
    fieldset{
    	padding: 20px 60px;
    	margin-bottom: 15px;
    	border-radius: 15px;
    	background: #f0eaea;
    	border-color: #d8d3d3;
    }
    
    legend {
    	display: inline-table;
	  	border-radius: 4px ;
	  	color: black;
	  	font-weight: bold;
	  	font-size: 16px;
	  	background-color: #4cc4f0;
	  	box-shadow: 3px 3px 5px #3d9dc0;
	  	padding: 5px 10px;
	}	
	
	.cajaTexto{
		margin: 5px;
	}

	.menu{
		position: relative;
		float: right;
		margin-right: 60px;
	}
	
	button{
		background-color: #43a8cd;
		border-radius: 60px;
		font-weight: bold;
		font-size: 16px;
		color: white;
		border-color: #7bc2dc;
		width: 130%;	
		height: 130%;
		cursor: pointer;
	}

	.menu-desplegable{
		display: none;
        position: absolute;
        right: 0;
        background-color: #f0eaea;
        border: 1px solid #ccc;
        margin-top: 5px;
        border-radius: 8px;
	}
	
	.menu-desplegable a{
		color: black;
        padding: 12px 16px;
        text-decoration: none;
        display: block;
	}
	
	.menu:hover .menu-desplegable {
        display: block;
    }
    
    .menu-desplegable a:hover {
        background-color: #ddd;
    }
    
    /* Mensajes */
    .mensajeExitoso{
    	color: green; 
    	font-weight: bold;
    }
    
    .mensajeError{
    	color: red; 
    	font-weight: bold;
    }
	
</style>
</head>
<body>

	<div class="menu">
		<button class="menu-btn" >Menu</button>
		<div class="menu-desplegable">
	       	<a href="ABMLMenu.jsp">Volver al menu anterior</a>
	        <a href="ServletCliente?opc=agregar">Agregar Cliente</a>
			<a href="ServletCliente?opc=eliminar">Eliminar Cliente</a>
			<a href="ServletCliente?opc=listar">Listado de Clientes</a>
	    </div>
	</div>
	
	
	<% Cliente cliente = (Cliente) request.getAttribute("cliente"); %>
	
	<div class="pagina">
		<h1> Modificar Cliente</h1> 
		
		<form action="ServletCliente" method="get">
		    <input type="hidden" name="opc" value="modificar">
		    <p>Ingrese DNI del cliente: </p>  
		    <input type="text" name="dniCliente" maxlength="8" pattern="\d{7,8}" class="cajaTexto">  
		    <input type="submit" value="Buscar" name="btnBuscar" class="boton">
		</form>
		
		<form action="ServletCliente" method="post">
		<input type="hidden" name="opc" value="modificar">
		<% if (cliente != null) { %>
			
			<!-- campo oculto para idCliente -->
			<input type="hidden" name="clienteId" value="<%= cliente.getClienteId() %>">
			<!-- campo oculto para idUsuario -->
			<input type="hidden" name="usuarioId" value="<%= (cliente.getUsuario() != null) ? cliente.getUsuario().getUsuarioId() : 0 %>">
		
			<div class="seccion"> 
			<fieldset>
			<legend>  Datos Personales </legend>
				<div class="form-row">
				<div class="form-group">
					<label>Nombre</label> 
					<input type="text" name="txtNombre" class="cajaTexto" value="<%=cliente.getNombre() %>" required>
				</div>
				<div class="form-group">
					<label>Apellido</label> 
					<input type="text" name="txtApellido" class="cajaTexto" value="<%=cliente.getApellido() %>" required>
				</div>
				</div>
				<div class="form-row">
				<div class="form-group">
					<label>DNI</label> 
					<input type="text" name="txtDNI" maxlength="8" pattern="\d{7,8}" class="cajaTexto" value="<%=cliente.getDni() %>"  required>
				</div>
				<div class="form-group">
					<label>CUIT</label> 
					<input type="text" name="txtCUIT" name="txtCUIT" maxlength="11" pattern="[0-9]{11}" class="cajaTexto" value="<%=cliente.getCuil() %>"  required>
				</div>
				</div>
				<div class="form-row">
				<div class="form-group">
					<label>Sexo</label> 
					<table>
		            <tbody>
		                <tr>
		                     <td><input type="radio" name="txtSexo" value="F" <%= cliente.getSexo() == 'F' ? "checked" : "" %> id=1 class="radio" required></td> <td><label> Femenino </label></td>
		                </tr>
		                <tr>
		                     <td><input type="radio" name="txtSexo" value="M" <%= cliente.getSexo() == 'M' ? "checked" : "" %> id=2 class="radio" required></td><td> <label>Masculino </label></td>
		                </tr>
		            </tbody>
		            </table>
				</div>
				<div class="form-group">
				    <label>País</label>
				    <select name="txtPais" id="cboPais" onchange="cargarProvincias()" required>
				        <option value="">-- Seleccione un país --</option>
				        <%
				            List<Pais> paises = (List<Pais>) request.getAttribute("paises");
				            if (paises != null) {
				                for (Pais pais : paises) {
				                    String selected = (cliente.getPais() != null && cliente.getPais().getPais_id() == pais.getPais_id()) ? "selected" : "";
				        %>
				                    <option value="<%= pais.getPais_id() %>" <%= selected %>><%= pais.getNombre() %></option>
				        <%
				                }
				            }
				        %>
				    </select>
				</div>

				</div>
				<div class="form-row">
				<div class="form-group">	
					<label>Fecha de nacimiento</label> 		
					
					<!-- Formateo de fecha -->	
					<%
					java.text.SimpleDateFormat formato = new java.text.SimpleDateFormat("yyyy-MM-dd");
					String fechaFormateada = cliente != null && cliente.getFechaNacimiento() != null ? formato.format(cliente.getFechaNacimiento()) : "";
					%>
										
					<input type="date" name="txtFechaNacimiento" class="cajaTexto" value="<%= fechaFormateada %>" required>
				</div>
				</div>
				</fieldset>
				<fieldset>
				<legend>  Datos Contacto </legend>
					<div class="form-row">
				<div class="form-group">
					<label>Nombre Usuario</label> <input type="text" name="txtNombreUsuario" maxlength="50" pattern="[A-Za-z0-9._-]{4,50}" class="cajaTexto" value="<%= cliente.getUsuario().getNombreUsuario() %>" required>
				</div>
<!-- 				<div class="form-group">
					<label>Contraseña</label> <input type="password" name="txtContraseña" class="cajaTexto" required>
				</div> -->
				</div>
				<div class="form-row">
				<div class="form-group">
					<label>Dirección</label> <input type="text" name="txtDireccion" class="cajaTexto" value="<%= cliente.getDireccion() %>" required>
				</div>
				<div class="form-group">
					<label>Telefono</label> <input type="text" name="txtTelefono"  pattern="\+?\d{7,20}" class="cajaTexto" value="<%= cliente.getTelefono() %>" required>
				</div>
				</div>
				<div class="form-row">
				<div class="form-group">
					<label>Provincia</label> 
						<select name="txtProvincia" id="txtProvincia" onchange="cargarLocalidades()">

						    <option value="">-- Seleccionar --</option>

						</select>
				</div>
				<div class="form-group">
					<label>Localidad</label> 
					<select name="txtLocalidad" id="txtLocalidad">
						    <option value=""> --- Seleccionar ---</option>
	  				</select>
				</div>
				</div>
				<div class="form-row">
				<div class="form-group">
					<label>Email</label> 
					<input type="email" name="txtEmail" pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" value="<%= cliente.getCorreoElectronico() %>" required>
				</div>
				
				</div>
				</fieldset>
				<input type="submit" value="Modificar" name="btnModificar" class="boton" required>
			</div>
		<% } %>
		</form>
		
		<!-- Mensajes -->
		<% if (request.getAttribute("mensajeExito") != null) { %>
		    <div class="mensajeExitoso">
		        <%= request.getAttribute("mensajeExito") %>
		    </div>
		<% } else if (request.getAttribute("mensajeError") != null) { %>
		    <div class="mensajeError">
		        <%= request.getAttribute("mensajeError") %>
		    </div>
		<% } %>	
				
	</div>
	
<script>

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

window.onload = function() {
    <% if (cliente != null && cliente.getPais() != null) { %>
        // Setear país actual
        document.getElementById("cboPais").value = "<%= cliente.getPais().getPais_id() %>";
        // Cargar provincias del país
        cargarProvincias();

        // Esperar un poco y luego cargar localidades de la provincia
        setTimeout(function() {
            document.getElementById("txtProvincia").value = "<%= cliente.getProvincia().getProvincia_id() %>";
            cargarLocalidades();

            setTimeout(function() {
                document.getElementById("txtLocalidad").value = "<%= cliente.getLocalidad().getLocalidad_id() %>";
            }, 300);
        }, 300);
    <% } %>
}


</script>
</body>
</html>