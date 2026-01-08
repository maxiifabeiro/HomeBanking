<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<style>
	body{
		font-family: Arial, sans-serif;
	    margin: 0;
	    padding: 0;
	    display: flex;
	    justify-content: center;
	    align-items: center;
	    height: 100vh;
	}

	.contenedor{
		text-align: center;
	}

	h1{
		color: blue;
		font-size: 40px;
		margin-bottom: 20px;
	}

	form{
		display: flex;
		flex-direction: column;
		align-items: center;
	}

	.form-group{
		display: flex;
		flex-direction: column;
		margin-bottom: 15px;
		width: 250px;
		text-align: left;
	}

	label{
		font-size: 14px;
		margin-bottom: 5px;
		font-weight: bold;
	}

	input[type="text"], input[type="password"]{
		padding: 8px;
		border: 1px solid #aaa;
		border-radius: 3px;
	}

	.link{
	    font-size: 12px;
	    color: #004cff;
	    margin-top: 5px;
	    cursor: pointer;
	    text-decoration: none;
	}
	
	.link:hover{
	    text-decoration: underline;
	}

	.boton{
		background-color: green;
		color: white;
		border: none;
		padding: 10px 20px;
		font-size: 16px;
		cursor: pointer;
		margin-top: 20px;
		border-radius: 4px;
	}
</style>
</head>
<body>
	<div class="contenedor">
		<h1>HomeBanking</h1>
		<img src="images/Logo.png" width="60px"><br><br>

		<form action="ServletUsuario" method="post">
			<div class="form-group">
				<label>Usuario</label>
				<input type="text" name="txtUsuario" required>
			</div>

			<div class="form-group">
				<label>Contraseña</label>
				<input type="password" name="txtContraseña" required>
				<a class="link" href="OlvidasteTuContrasena.jsp">¿Olvidaste tu contraseña?</a>
			</div>

			<input class="boton" type="submit" value="Ingresar">
		</form>
	</div>
</body>
</html>