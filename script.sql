CREATE SCHEMA homebanking;
USE homebanking;

/*TABLAS*/

CREATE TABLE paises (
    pais_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE provincias (
    provincia_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    pais_id INT NOT NULL,
    UNIQUE (nombre, pais_id),
    FOREIGN KEY (pais_id) REFERENCES paises(pais_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE localidades (
    localidad_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    provincia_id INT NOT NULL,
    UNIQUE (nombre, provincia_id),
    FOREIGN KEY (provincia_id) REFERENCES provincias(provincia_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

/*TIPO USUARIOS */
CREATE TABLE tipoUsuarios(
    tipoUsuario_id INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE pregunta(
    pregunta_id INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(255) NOT NULL UNIQUE
);


/*USUARIOS */

CREATE TABLE usuarios (
    usuario_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(50) NOT NULL UNIQUE,
    clave VARCHAR(255) NOT NULL,
    tipoUsuario_id INT NOT NULL,
    pregunta_id INT NOT NULL,
    respuesta VARCHAR(100) NOT NULL,
    estado BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (tipoUsuario_id) REFERENCES tipoUsuarios(tipoUsuario_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (pregunta_id) REFERENCES pregunta(pregunta_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);


/*CLIENTES*/

CREATE TABLE clientes (
    cliente_id INT AUTO_INCREMENT PRIMARY KEY,
    dni VARCHAR(8) NOT NULL UNIQUE,
    cuil VARCHAR(13) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    sexo CHAR(1) NOT NULL,
    pais_id INT NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    localidad_id INT NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(20) NOT NULL,
    usuario_id INT NOT NULL UNIQUE,
    estado BOOLEAN DEFAULT TRUE,

    FOREIGN KEY (pais_id) REFERENCES paises(pais_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (localidad_id) REFERENCES localidades(localidad_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(usuario_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);


/*TIPOS DE CUENTAS */

CREATE TABLE tipos_cuentas (
    tipocuentas_id INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL UNIQUE
);


/*CUENTAS */

CREATE TABLE cuentas (
    cuenta_id INT AUTO_INCREMENT PRIMARY KEY,
    cbu VARCHAR(22) NOT NULL UNIQUE,
    cliente_id INT NOT NULL,
    fecha_creacion DATE NOT NULL,
    alias VARCHAR(50),
    tipocuentas_id INT NOT NULL,
    saldo DECIMAL(12,2) NOT NULL DEFAULT 10000.00,
    estado BOOLEAN DEFAULT TRUE,

    CHECK (saldo >= 0),

    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (tipocuentas_id) REFERENCES tipos_cuentas(tipocuentas_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);


/*TRANSFERENCIAS*/

CREATE TABLE transferencias (
    transferencia_id INT AUTO_INCREMENT PRIMARY KEY,
    cuenta_origen INT NOT NULL,
    cuenta_destino INT NOT NULL,
    fecha DATETIME NOT NULL,
    detalle VARCHAR(255),
    importe DECIMAL(12,2) NOT NULL CHECK (importe > 0),
    estado ENUM('COMPLETADA','PENDIENTE','ERROR') DEFAULT 'COMPLETADA',

    FOREIGN KEY (cuenta_origen) REFERENCES cuentas(cuenta_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (cuenta_destino) REFERENCES cuentas(cuenta_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);


/*TIPO MOVIMIENTOS */

CREATE TABLE tipoMovimientos(
    tipoMovimiento_id INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL UNIQUE
);


/*MOVIMIENTOS */

CREATE TABLE movimientos (
    movimiento_id INT AUTO_INCREMENT PRIMARY KEY,
    cuenta_id INT NOT NULL,
    fecha DATETIME NOT NULL,
    detalle VARCHAR(255),
    importe DECIMAL(12,2) NOT NULL,
    saldo DECIMAL(12,2) NOT NULL,
    tipoMovimiento_id INT NOT NULL,
    transferencia_id INT NULL,

    FOREIGN KEY (cuenta_id) REFERENCES cuentas(cuenta_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (tipoMovimiento_id) REFERENCES tipoMovimientos(tipoMovimiento_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (transferencia_id) REFERENCES transferencias(transferencia_id)
        ON UPDATE CASCADE ON DELETE SET NULL
);

                
/* TIPOS DE PRÉSTAMO */
CREATE TABLE tipos_prestamo (
    tipo_prestamo_id INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL UNIQUE,
    interes_mensual DECIMAL(5,2) NOT NULL
);

/* PRÉSTAMOS */
CREATE TABLE prestamos (
    prestamo_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    cuenta_destino INT NOT NULL,
    tipo_prestamo_id INT NOT NULL,
    fecha DATE NOT NULL,
    monto_pedido DECIMAL(12,2) NOT NULL,
    nro_cuotas INT NOT NULL,
    cuota_mensual DECIMAL(12,2),
    saldo_restante DECIMAL(12,2),
    cuotas_pagas INT DEFAULT 0,
    estado ENUM('en proceso','autorizado','rechazado','pagado') DEFAULT 'en proceso',

    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (cuenta_destino) REFERENCES cuentas(cuenta_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (tipo_prestamo_id) REFERENCES tipos_prestamo(tipo_prestamo_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);


/*CUOTAS*/

CREATE TABLE cuotas (
    cuota_id INT AUTO_INCREMENT PRIMARY KEY,
    prestamo_id INT NOT NULL,
    cuenta_id INT NOT NULL,
    numero_cuota INT NOT NULL,
    monto DECIMAL(12,2) NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    fecha_pago DATE NULL,
    estado ENUM('pendiente','pagada') DEFAULT 'pendiente',

    FOREIGN KEY (prestamo_id) REFERENCES prestamos(prestamo_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (cuenta_id) REFERENCES cuentas(cuenta_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);




/* ------------------- INSERTS ------------------ */

/* ===========================
   PAISES
   =========================== */
INSERT INTO paises (nombre) VALUES
('Argentina'),('Brasil'),('Chile'),('Uruguay'),('Paraguay'),
('Bolivia'),('Perú'),('Colombia'),('Ecuador'),('Venezuela'),
('México'),('España'),('Italia'),('Francia'),('Alemania');

/* ===========================
   PROVINCIAS
   =========================== */
INSERT INTO provincias (nombre, pais_id) VALUES
('Buenos Aires',1),('Córdoba',1),('Santa Fe',1),('Mendoza',1),('Salta',1),
('Río de Janeiro',2),('São Paulo',2),('Santiago',3),('Valparaíso',3),('Montevideo',4),
('Asunción',5),('La Paz',6),('Lima',7),('Bogotá',8),('Quito',9);

/* ===========================
   LOCALIDADES
   =========================== */
INSERT INTO localidades (nombre, provincia_id) VALUES
('Tigre',1),('Córdoba Capital',2),('Rosario',3),('Godoy Cruz',4),('Salta Capital',5),
('Copacabana',6),('Campinas',7),('Providencia',8),('Viña del Mar',9),('Centro Montevideo',10),
('San Lorenzo',11),('Zona Sur La Paz',12),('Miraflores',13),('Chapinero',14),('Centro Quito',15);

/* ===========================
   TIPO USUARIOS
   =========================== */
INSERT INTO tipoUsuarios (descripcion) VALUES
('Administrador'),('Cliente');

/* ===========================
   PREGUNTAS
   =========================== */
INSERT INTO pregunta (descripcion) VALUES
('¿Color favorito?'),('¿Nombre de tu mascota?'),('¿Ciudad donde naciste?'),
('¿Comida preferida?'),('¿Nombre de tu escuela?'),('¿Segundo nombre de tu madre?'),
('¿Equipo favorito?'),('¿Marca de tu primer auto?'),('¿Apodo de la infancia?'),
('¿Canción favorita?'),('¿Profesor/a que más recordás?'),('¿Nombre de tu mejor amigo/a?'),
('¿Lugar de vacaciones preferido?'),('¿Nombre de tu padre?'),('¿Serie favorita?');

/* ===========================
   USUARIOS
   =========================== */
INSERT INTO usuarios (nombre_usuario, clave, tipoUsuario_id, pregunta_id, respuesta, estado) VALUES
('user01','Clave01!',2,1,'azul',TRUE),
('user02','Clave02!',2,2,'firulais',TRUE),
('user03','Clave03!',2,3,'rosario',TRUE),
('user04','Clave04!',2,4,'milanesa',TRUE),
('user05','Clave05!',2,5,'sanmartin',TRUE),
('user06','Clave06!',2,6,'andrea',TRUE),
('user07','Clave07!',2,7,'river',TRUE),
('user08','Clave08!',2,8,'renault',TRUE),
('user09','Clave09!',2,9,'nico',TRUE),
('user10','Clave10!',2,10,'one',TRUE),
('user11','Clave11!',2,11,'garcia',TRUE),
('user12','Clave12!',2,12,'sofia',TRUE),
('user13','Clave13!',2,13,'mar del',TRUE),
('user14','Clave14!',2,14,'carlos',TRUE),
('user15','Clave15!',2,15,'friends',TRUE);

INSERT INTO usuarios (nombre_usuario, clave, tipoUsuario_id, pregunta_id, respuesta, estado) VALUES
('admin', 'admin123', 1, 2, 'rojo', TRUE);

/* ===========================
   CLIENTES
   =========================== */
INSERT INTO clientes (dni,cuil,nombre,apellido,sexo,nacionalidad,fecha_nacimiento,direccion,localidad_id,provincia_id,correo_electronico,telefono,usuario_id,estado) VALUES
('30000001','20-30000001-3','Juan','Pérez','M','Argentina','1990-01-15','Calle 1',1,1,'cliente01@mail.com','+5491100000001',1,TRUE),
('30000002','20-30000002-3','María','García','F','Argentina','1988-03-22','Calle 2',2,2,'cliente02@mail.com','+5491100000002',2,TRUE),
('30000003','20-30000003-3','Luis','Rodríguez','M','Argentina','1992-07-09','Calle 3',3,3,'cliente03@mail.com','+5491100000003',3,TRUE),
('30000004','20-30000004-3','Ana','Martínez','F','Argentina','1995-11-30','Calle 4',4,4,'cliente04@mail.com','+5491100000004',4,TRUE),
('30000005','20-30000005-3','Carlos','López','M','Argentina','1987-05-17','Calle 5',5,5,'cliente05@mail.com','+5491100000005',5,TRUE),
('30000006','20-30000006-3','Fernanda','Silva','F','Brasil','1991-02-10','Rua 6',6,6,'cliente06@mail.com','+551100000006',6,TRUE),
('30000007','20-30000007-3','Paulo','Santos','M','Brasil','1989-09-25','Rua 7',7,7,'cliente07@mail.com','+551100000007',7,TRUE),
('30000008','20-30000008-3','Camila','Rojas','F','Chile','1993-12-05','Av. 8',8,8,'cliente08@mail.com','+569900000008',8,TRUE),
('30000009','20-30000009-3','Diego','Salinas','M','Chile','1994-08-14','Av. 9',9,9,'cliente09@mail.com','+569900000009',9,TRUE),
('30000010','20-30000010-3','Sofía','Núñez','F','Uruguay','1990-10-21','Av. 10',10,10,'cliente10@mail.com','+598200000010',10,TRUE),
('30000011','20-30000011-3','Jorge','Benítez','M','Paraguay','1986-04-02','Calle 11',11,11,'cliente11@mail.com','+595210000011',11,TRUE),
('30000012','20-30000012-3','Valeria','Suárez','F','Bolivia','1992-06-13','Calle 12',12,12,'cliente12@mail.com','+591700000012',12,TRUE),
('30000013','20-30000013-3','Hugo','Paredes','M','Perú','1985-12-19','Av. 13',13,13,'cliente13@mail.com','+511100000013',13,TRUE),
('30000014','20-30000014-3','Laura','Moreno','F','Colombia','1998-07-28','Av. 14',14,14,'cliente14@mail.com','+571300000014',14,TRUE),
('30000015','20-30000015-3','Nicolás','Vega','M','Ecuador','1999-09-03','Av. 15',15,15,'cliente15@mail.com','+593400000015',15,TRUE);

/* ===========================
   TIPOS DE CUENTAS
   =========================== */
INSERT INTO tipos_cuentas (descripcion) VALUES
('Caja de Ahorro ARS'),('Cuenta Corriente ARS'),('Caja de Ahorro USD'),('Cuenta Corriente USD'),('Caja de Ahorro EUR'),
('Cuenta Corriente EUR'),('Cuenta Sueldo'),('Cuenta PyME'),('Cuenta Premium'),('Cuenta Joven'),
('Cuenta Universitaria'),('Cuenta Senior'),('Cuenta Digital'),('Cuenta Plazo'),('Cuenta Inversión');

/* ===========================
   CUENTAS
   =========================== */
INSERT INTO cuentas (cbu,cliente_id,fecha_creacion,alias,tipocuentas_id,saldo,estado) VALUES
('1234567890123456789001',1,'2024-06-01','alias01',1,15000.00,TRUE),
('1234567890123456789002',2,'2024-06-02','alias02',2,27500.50,TRUE),
('1234567890123456789003',3,'2024-06-03','alias03',3,10200.75,TRUE),
('1234567890123456789004',4,'2024-06-04','alias04',4,50000.00,TRUE),
('1234567890123456789005',5,'2024-06-05','alias05',5,9800.00,TRUE),
('1234567890123456789006',6,'2024-06-06','alias06',6,15200.00,TRUE),
('1234567890123456789007',7,'2024-06-07','alias07',7,30500.00,TRUE),
('1234567890123456789008',8,'2024-06-08','alias08',8,7500.00,TRUE),
('1234567890123456789009',9,'2024-06-09','alias09',9,25000.00,TRUE),
('1234567890123456789010',10,'2024-06-10','alias10',10,12345.67,TRUE),
('1234567890123456789011',11,'2024-06-11','alias11',11,8450.00,TRUE),
('1234567890123456789012',12,'2024-06-12','alias12',12,19999.99,TRUE),
('1234567890123456789013',13,'2024-06-13','alias13',13,60200.00,TRUE),
('1234567890123456789014',14,'2024-06-14','alias14',14,4000.00,TRUE),
('1234567890123456789015',15,'2024-06-15','alias15',15,100000.00,TRUE),
('1234567890123456789016',1,'2024-06-15','alias15',15,100000.00,TRUE);

/* ===========================
   TRANSFERENCIAS
   =========================== */
INSERT INTO transferencias (cuenta_origen,cuenta_destino,fecha,detalle,importe) VALUES
(1,2,'2025-10-01 10:00:00','Pago servicio',1200.00),
(2,3,'2025-10-02 11:15:00','Envío amigo',8500.00),
(3,4,'2025-10-03 09:30:00','Compra online',3200.50),
(4,5,'2025-10-04 14:45:00','Gastos varios',999.99),
(5,6,'2025-10-05 16:20:00','Pago alquiler',45000.00),
(6,7,'2025-10-06 08:05:00','Devolución',1500.00),
(7,8,'2025-10-07 18:40:00','Transferencia familiar',7000.00),
(8,9,'2025-10-08 12:00:00','Pago proveedor',22000.00),
(9,10,'2025-10-09 19:25:00','Compra supermercado',1750.75),
(10,11,'2025-10-10 07:50:00','Pago crédito',9000.00),
(11,12,'2025-10-11 10:10:00','Servicio streaming',2500.00),
(12,13,'2025-10-12 13:35:00','Suscripción',1200.00),
(13,14,'2025-10-13 17:00:00','Regalo',5000.00),
(14,15,'2025-10-14 09:00:00','Donación',3000.00),
(15,1,'2025-10-15 15:45:00','Transferencia mensual',10000.00);

/* ===========================
   TIPO MOVIMIENTOS
   =========================== */
INSERT INTO tipoMovimientos (descripcion) VALUES
('Apertura de cuenta'),('Depósito'),('Extracción'),('Transferencia enviada'),('Transferencia recibida'),('Pago servicio'),
('Compra'),('Devolución'),('Interés'),('Ajuste'),('Comisión'),
('Pago préstamo'),('Cobro préstamo'),('Recarga'),('Deuda'),('Corrección');

/* ===========================
   MOVIMIENTOS
   =========================== */
INSERT INTO movimientos (cuenta_id,fecha,detalle,importe,tipoMovimiento_id,transferencia_id) VALUES
(1,'2025-10-01 10:00:00','Transferencia enviada',1200.00,3,1),
(2,'2025-10-02 11:15:00','Transferencia enviada',8500.00,3,2),
(3,'2025-10-03 09:30:00','Transferencia enviada',3200.50,3,3),
(4,'2025-10-04 14:45:00','Transferencia enviada',999.99,3,4),
(5,'2025-10-05 16:20:00','Transferencia enviada',45000.00,3,5),
(6,'2025-10-06 08:05:00','Transferencia enviada',1500.00,3,6),
(7,'2025-10-07 18:40:00','Transferencia enviada',7000.00,3,7),
(8,'2025-10-08 12:00:00','Transferencia enviada',22000.00,3,8),
(9,'2025-10-09 19:25:00','Transferencia enviada',1750.75,3,9),
(10,'2025-10-10 07:50:00','Transferencia enviada',9000.00,3,10),
(11,'2025-10-11 10:10:00','Depósito efectivo',5000.00,1,NULL),
(12,'2025-10-12 13:35:00','Pago servicio',1200.00,5,NULL),
(13,'2025-10-13 17:00:00','Compra tienda',2500.00,6,NULL),
(14,'2025-10-14 09:00:00','Comisión mensual',300.00,10,NULL),
(15,'2025-10-15 15:45:00','Interés acreditado',150.00,8,NULL);

/* ===========================
   TIPOS DE PRESTAMO
   =========================== */
INSERT INTO tipos_prestamo (descripcion,interes_mensual) VALUES
('Personal',2.50),('Hipotecario',1.80),('Automotor',2.20),('Educativo',1.50),('Refacción hogar',2.00),
('Viajes',3.00),('Emprendimiento',3.50),('Consumo',2.75),('Tecnología',2.30),('Salud',1.90),
('Consolidación deuda',2.60),('Electrodomésticos',2.40),('Negocio PyME',3.20),('Mudanza',2.10),('Eventos',3.80);

/* ===========================
   PRESTAMOS
   =========================== */
INSERT INTO prestamos (cliente_id,cuenta_destino,tipo_prestamo_id,fecha,monto_pedido,nro_cuotas,cuota_mensual,saldo_restante,cuotas_pagas,estado) VALUES
(1,1,1,'2025-09-01',100000.00,24,5200.00,94800.00,1,'autorizado'),
(2,2,2,'2025-09-02',500000.00,120,8500.00,491500.00,1,'autorizado'),
(3,3,3,'2025-09-03',300000.00,60,7200.00,292800.00,1,'en proceso'),
(4,4,4,'2025-09-04',80000.00,12,7000.00,73000.00,1,'autorizado'),
(5,5,5,'2025-09-05',150000.00,36,6800.00,143200.00,1,'en proceso'),
(6,6,6,'2025-09-06',60000.00,18,3800.00,56200.00,1,'autorizado'),
(7,7,7,'2025-09-07',220000.00,48,6200.00,213800.00,1,'autorizado'),
(8,8,8,'2025-09-08',90000.00,24,4200.00,85800.00,1,'rechazado'),
(9,9,9,'2025-09-09',120000.00,24,5100.00,114900.00,1,'autorizado'),
(10,10,10,'2025-09-10',70000.00,18,4100.00,65900.00,1,'en proceso'),
(11,11,11,'2025-09-11',250000.00,60,7300.00,242700.00,1,'autorizado');

/* PROCEDIMIENTOS ALMACENADOS */

/* ---------- CLIENTES ---------- */
DELIMITER //
CREATE PROCEDURE AltaCliente(
    IN ac_dni VARCHAR(8),
    IN ac_cuil VARCHAR(13),
    IN ac_nombre VARCHAR(100),
    IN ac_apellido VARCHAR(100),
    IN ac_sexo CHAR(1),
    IN ac_paisId INT,
    IN ac_fecha DATE,
    IN ac_direccion VARCHAR(255),
    IN ac_localidad INT,
    IN ac_correo VARCHAR(100),
    IN ac_telefono VARCHAR(20),
    IN ac_username VARCHAR(50),
    IN ac_password VARCHAR(255),
    IN ac_pregunta INT,
    IN ac_respuesta VARCHAR(255),
    IN ac_tipoUsuario INT
)
BEGIN
    DECLARE nuevoUsuarioID INT;
    DECLARE existe INT;

    -- Validar DNI existente
    SELECT COUNT(*) INTO existe
    FROM clientes WHERE dni = ac_dni;

    IF existe > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El DNI ya existe';
    END IF;

    -- Validar usuario existente
    SELECT COUNT(*) INTO existe
    FROM usuarios WHERE nombre_usuario = ac_username;

    IF existe > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El nombre de usuario ya existe';
    END IF;

    -- Crear usuario
    INSERT INTO usuarios(nombre_usuario, clave, tipoUsuario_id, estado, pregunta_id, respuesta)
	VALUES(ac_username, ac_password, 2, TRUE, ac_pregunta, ac_respuesta);

    SET nuevoUsuarioID = LAST_INSERT_ID();

    -- Crear cliente
    INSERT INTO clientes(
        dni, cuil, nombre, apellido, sexo, pais_id,
        fecha_nacimiento, direccion, localidad_id,
        correo_electronico, telefono, usuario_id, estado
    )
    VALUES(
        ac_dni, ac_cuil, ac_nombre, ac_apellido, ac_sexo, ac_paisId,
        ac_fecha, ac_direccion, ac_localidad,
        ac_correo, ac_telefono, nuevoUsuarioID, TRUE
    );
END//
DELIMITER ;

-- MODIFICAR CLIENTE
DELIMITER //
CREATE PROCEDURE ModificarCliente(
    IN mc_clienteId INT,
    IN mc_dni VARCHAR(8),
    IN mc_cuil VARCHAR(13),
    IN mc_nombre VARCHAR(100),
    IN mc_apellido VARCHAR(100),
    IN mc_sexo CHAR(1),
    IN mc_paisId INT,
    IN mc_fechaNacimiento DATE,
    IN mc_direccion VARCHAR(255),
    IN mc_localidad INT,
    IN mc_correo VARCHAR(100),
    IN mc_telefono VARCHAR(20),
    IN mc_username VARCHAR(50)
)
BEGIN
    UPDATE clientes
    SET dni = mc_dni,
        cuil = mc_cuil,
        nombre = mc_nombre,
        apellido = mc_apellido,
        sexo = mc_sexo,
        pais_id = mc_paisId,
        fecha_nacimiento = mc_fechaNacimiento,
        direccion = mc_direccion,
        localidad_id = mc_localidad,
        correo_electronico = mc_correo,
        telefono = mc_telefono
    WHERE cliente_id = mc_clienteId;

    UPDATE usuarios
    SET nombre_usuario = mc_username
    WHERE usuario_id = (
        SELECT usuario_id 
        FROM clientes 
        WHERE cliente_id = mc_clienteId
    );
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ListarClientes()
BEGIN
    SELECT 
        c.cliente_id,
        c.dni,
        c.cuil,
        c.nombre,
        c.apellido,
        c.sexo,
        pa.nombre AS nacionalidad,
        c.fecha_nacimiento,
        c.direccion,
        l.nombre AS localidad,
        p.nombre AS provincia,
        c.correo_electronico,
        c.telefono,
        u.nombre_usuario,
        u.tipoUsuario_id
    FROM clientes c
        INNER JOIN localidades l ON c.localidad_id = l.localidad_id
        INNER JOIN provincias p ON l.provincia_id = p.provincia_id
        INNER JOIN paises pa ON p.pais_id = pa.pais_id 
        INNER JOIN usuarios u ON c.usuario_id = u.usuario_id
    WHERE c.estado = 1;
END//

DELIMITER //
CREATE PROCEDURE ListarUnCliente(IN ac_dni VARCHAR(8))
BEGIN
    SELECT
        c.cliente_id,
        c.dni,
        c.cuil,
        c.nombre,
        c.apellido,
        c.sexo,
        pa.pais_id AS pais_id,
		pa.nombre AS nombre_pais,
        c.fecha_nacimiento,
        c.direccion,
        c.correo_electronico,
        c.telefono,
		
        l.localidad_id,
        l.nombre AS nombre_localidad,

        p.provincia_id,
        p.nombre AS nombre_provincia,
        
        u.usuario_id,
        u.nombre_usuario

    FROM clientes c
    JOIN localidades l ON c.localidad_id = l.localidad_id
    JOIN provincias p ON l.provincia_id = p.provincia_id
    JOIN paises pa ON p.pais_id = pa.pais_id
    JOIN usuarios u ON c.usuario_id = u.usuario_id
    WHERE c.dni = ac_dni
      AND c.estado = 1;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE BajaClienteYUsuario(IN ec_id INT)
BEGIN
    DECLARE v_usuario INT;

    SELECT usuario_id INTO v_usuario
    FROM clientes WHERE cliente_id = ec_id;

    UPDATE clientes SET estado = 0 WHERE cliente_id = ec_id;
    UPDATE usuarios SET estado = 0 WHERE usuario_id = v_usuario;
END//
DELIMITER ;


/* ---------- CUENTAS ---------- */
DELIMITER //
CREATE PROCEDURE AltaCuenta(
    IN ac_cbu VARCHAR(22),
    IN ac_cliente_id INT,
    IN ac_fecha_creacion DATE,
    IN ac_alias VARCHAR(50),
    IN ac_tipocuentas_id INT,
    IN ac_saldo DECIMAL(12,2)
)
BEGIN
    DECLARE cuenta_cont INT;
    DECLARE nuevaCuenta INT;
    DECLARE tipoAlta INT;

    -- Validar máximo de cuentas
    SELECT COUNT(*) INTO cuenta_cont
    FROM cuentas
    WHERE cliente_id = ac_cliente_id
      AND estado = 1;

    IF cuenta_cont >= 3 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El cliente ya tiene el maximo permitido de 3 cuentas.';
    END IF;

    -- Crear cuenta
    INSERT INTO cuentas(cbu, cliente_id, fecha_creacion, alias, tipocuentas_id, saldo, estado)
    VALUES(ac_cbu, ac_cliente_id, ac_fecha_creacion, ac_alias, ac_tipocuentas_id, ac_saldo, TRUE);

    SET nuevaCuenta = LAST_INSERT_ID();

    -- Buscar ID real de Apertura de cuenta
    SELECT tipoMovimiento_id
    INTO tipoAlta
    FROM tipoMovimientos
    WHERE descripcion = 'Apertura de cuenta'
    LIMIT 1;

    -- Insertar movimiento inicial
    INSERT INTO movimientos(cuenta_id, fecha, detalle, importe, saldo, tipoMovimiento_id)
    VALUES (nuevaCuenta, NOW(), 'Apertura de cuenta', ac_saldo, ac_saldo, tipoAlta);
END//



DELIMITER //
CREATE PROCEDURE listarCuentas()
BEGIN
	SELECT
	c.cbu,
	cl.nombre,
	cl.apellido,
	cl.dni,
	tc.descripcion,
	c.saldo
	FROM cuentas c
	INNER JOIN clientes cl ON cl.cliente_id = c.cliente_id
	INNER JOIN tipos_cuentas tc ON tc.tipocuentas_id = c.tipocuentas_id
    WHERE c.estado = 1;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE listarCuentaPorDni(IN ac_dni VARCHAR(8))
BEGIN
	SELECT
	c.cuenta_id,
	c.cbu,
	cl.nombre,
	cl.apellido,
	cl.dni,
	tc.descripcion,
	c.saldo
	FROM cuentas c
	INNER JOIN clientes cl ON cl.cliente_id = c.cliente_id
	INNER JOIN tipos_cuentas tc ON tc.tipocuentas_id = c.tipocuentas_id
	WHERE cl.dni = ac_dni
      AND c.estado = 1;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ModificarCuenta(
    IN mc_cuenta_id INT,
    IN mc_cbu VARCHAR(22),
    IN mc_alias VARCHAR(50),
    IN mc_tipoCuenta_id INT,
    IN mc_saldo DECIMAL(12,2),
    IN mc_fecha_creacion DATE
)
BEGIN
    UPDATE cuentas
    SET 
        cbu = mc_cbu,
        alias = mc_alias,
        tipocuentas_id = mc_tipoCuenta_id,
        saldo = mc_saldo,
        fecha_creacion = mc_fecha_creacion
    WHERE cuenta_id = mc_cuenta_id;
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE ObtenerCuentaPorId(IN id INT)
BEGIN
	
SELECT c.cuenta_id, c.cbu, c.alias, c.fecha_creacion, c.saldo, cli.dni, cli.cliente_id, cli.nombre AS nombre_cliente, cli.apellido AS apellido_cliente, 
	tc.tipocuentas_id, tc.descripcion AS tipos_cuentas FROM cuentas c
    INNER JOIN clientes cli ON c.cliente_id = cli.cliente_id
    INNER JOIN tipos_cuentas tc ON c.tipocuentas_id = tc.tipocuentas_id
    WHERE c.cuenta_id = id AND c.estado = 1;

END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE BajaCuenta(IN ec_id INT)
BEGIN
    -- Baja logica en cuentas
    UPDATE cuentas
    SET estado = 0
    WHERE cuenta_id = ec_id;
    
END//
DELIMITER ;

/* ---------- TRANSFERENCIAS ---------- */

DELIMITER //
CREATE PROCEDURE TransferirEntrePropias(
    IN p_cuenta_origen INT,
    IN p_cuenta_destino INT,
    IN p_detalle VARCHAR(255),
    IN p_importe DECIMAL(12,2)
)
BEGIN
    DECLARE v_origen_saldo DECIMAL(12,2);
    DECLARE v_destino_saldo DECIMAL(12,2);
    DECLARE v_transferencia_id INT;
    DECLARE v_mov_origen INT;
    DECLARE v_mov_destino INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en transferencia. Se hizo rollback.';
    END;

    START TRANSACTION;

    -- Validar cuentas y saldo
    SELECT saldo INTO v_origen_saldo FROM cuentas WHERE cuenta_id = p_cuenta_origen FOR UPDATE;
    IF v_origen_saldo IS NULL THEN
        ROLLBACK; SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cuenta origen inexistente';
    END IF;

    IF v_origen_saldo < p_importe THEN
        ROLLBACK; SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Saldo insuficiente';
    END IF;

    SELECT saldo INTO v_destino_saldo FROM cuentas WHERE cuenta_id = p_cuenta_destino FOR UPDATE;
    IF v_destino_saldo IS NULL THEN
        ROLLBACK; SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cuenta destino inexistente';
    END IF;

    -- Registrar transferencia
    INSERT INTO transferencias(cuenta_origen, cuenta_destino, fecha, detalle, importe, estado)
    VALUES (p_cuenta_origen, p_cuenta_destino, NOW(), p_detalle, p_importe, 'COMPLETADA');

    SET v_transferencia_id = LAST_INSERT_ID();

    -- Registrar movimiento salida (origen): importe negativo, tipo SALIDA (2)
    CALL RegistrarMovimiento(p_cuenta_origen, NOW(), p_detalle, -p_importe, 2, v_transferencia_id);

    -- Registrar movimiento entrada (destino): importe positivo, tipo ENTRADA (3)
    CALL RegistrarMovimiento(p_cuenta_destino, NOW(), p_detalle, p_importe, 3, v_transferencia_id);

    COMMIT;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE TransferirATerceros(
    IN p_cuenta_origen INT,
    IN p_cbu_o_alias VARCHAR(50),
    IN p_detalle VARCHAR(255),
    IN p_importe DECIMAL(12,2)
)
BEGIN
    DECLARE v_destino_id INT;
    DECLARE v_origen_saldo DECIMAL(12,2);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en transferencia a terceros. Se hizo rollback.';
    END;

    START TRANSACTION;

    -- Encontrar destino
    SELECT cuenta_id INTO v_destino_id
    FROM cuentas
    WHERE (cbu = p_cbu_o_alias OR alias = p_cbu_o_alias)
    AND estado = 1
    LIMIT 1
    FOR UPDATE;

    IF v_destino_id IS NULL THEN
        ROLLBACK; SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cuenta destino no encontrada';
    END IF;

    SELECT saldo INTO v_origen_saldo FROM cuentas WHERE cuenta_id = p_cuenta_origen FOR UPDATE;
    IF v_origen_saldo IS NULL THEN
        ROLLBACK; SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cuenta origen inexistente';
    END IF;

    IF v_origen_saldo < p_importe THEN
        ROLLBACK; SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Saldo insuficiente';
    END IF;

    -- Registrar transferencia
    INSERT INTO transferencias(cuenta_origen, cuenta_destino, fecha, detalle, importe, estado)
    VALUES (p_cuenta_origen, v_destino_id, NOW(), p_detalle, p_importe, 'COMPLETADA');

    SET @transferencia_id = LAST_INSERT_ID();

    -- Movimientos
    CALL RegistrarMovimiento(p_cuenta_origen, NOW(), p_detalle, -p_importe, 2, @transferencia_id);
    CALL RegistrarMovimiento(v_destino_id, NOW(), p_detalle, p_importe, 3, @transferencia_id);

    COMMIT;
END//
DELIMITER ;

/* ---------- Movimientos ---------- */
DELIMITER //
CREATE PROCEDURE listarMovimientos()
BEGIN
	SELECT
		m.movimiento_id AS movimientoId,
		m.fecha AS fecha,
		m.importe AS importe,
		m.saldo AS saldo,
		tf.cuenta_origen AS cuentaOrigen,
		tf.cuenta_destino AS cuentaDestino,
		tf.estado AS estado
	FROM movimientos m
	LEFT JOIN transferencias tf ON tf.transferencia_id = m.transferencia_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE listarMovimientosPorCliente(IN p_usuario_id INT)
BEGIN
    SELECT
    m.movimiento_id,
    m.fecha,
    m.detalle,
    m.importe,
    m.saldo,

    cu.cuenta_id,
    cu.alias AS cuenta_alias,
    cu.cbu   AS cuenta_cbu,

    t.transferencia_id,
    t.estado,

    co.alias AS alias_origen,
    cd.alias AS alias_destino

	FROM movimientos m
	INNER JOIN cuentas cu
		ON cu.cuenta_id = m.cuenta_id
	INNER JOIN clientes cl
		ON cl.cliente_id = cu.cliente_id
	INNER JOIN usuarios u
		ON u.usuario_id = cl.usuario_id
	LEFT JOIN transferencias t
		ON t.transferencia_id = m.transferencia_id
	LEFT JOIN cuentas co
		ON t.cuenta_origen = co.cuenta_id
	LEFT JOIN cuentas cd
		ON t.cuenta_destino = cd.cuenta_id
	WHERE u.usuario_id = p_usuario_id AND cu.estado = 1
	ORDER BY m.fecha DESC;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE listarMovimientosPorFechas(
    IN fechaDesde DATE,
    IN fechaHasta DATE,
    IN p_usuario_id INT
)
BEGIN
SELECT
    m.movimiento_id,
    m.fecha,
    m.importe,
    m.saldo,

    t.estado,
    co.alias AS alias_origen,
    cd.alias AS alias_destino

	FROM movimientos m
	INNER JOIN cuentas cu ON cu.cuenta_id = m.cuenta_id AND cu.estado = 1
	INNER JOIN clientes cl ON cl.cliente_id = cu.cliente_id
	INNER JOIN usuarios u ON u.usuario_id = cl.usuario_id
	LEFT JOIN transferencias t ON t.transferencia_id = m.transferencia_id
	LEFT JOIN cuentas co ON t.cuenta_origen = co.cuenta_id
	LEFT JOIN cuentas cd ON t.cuenta_destino = cd.cuenta_id
	WHERE m.fecha BETWEEN fechaDesde AND fechaHasta
	  AND u.usuario_id = p_usuario_id
	ORDER BY m.fecha DESC;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE listarMovimientosPorCuenta(IN p_cuenta_id INT)
BEGIN
SELECT
    m.movimiento_id,
    m.fecha,
    m.detalle,
    m.importe,
    m.saldo,
    m.cuenta_id,

    t.estado,
    co.alias AS alias_origen,
    cd.alias AS alias_destino

	FROM movimientos m
	LEFT JOIN transferencias t
		ON m.transferencia_id = t.transferencia_id
	LEFT JOIN cuentas co
		ON t.cuenta_origen = co.cuenta_id
	LEFT JOIN cuentas cd
		ON t.cuenta_destino = cd.cuenta_id
	WHERE m.cuenta_id = p_cuenta_id
	  AND EXISTS (
		  SELECT 1
		  FROM cuentas c
		  WHERE c.cuenta_id = m.cuenta_id
			AND c.estado = 1
	  )
	ORDER BY m.fecha DESC;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE RegistrarMovimiento(
    IN p_cuenta_id INT,
    IN p_fecha DATETIME,
    IN p_detalle VARCHAR(255),
    IN p_importe DECIMAL(12,2),
    IN p_tipoMovimiento_id INT,
    IN p_transferencia_id INT
)
BEGIN
    DECLARE v_saldo_actual DECIMAL(12,2);
    DECLARE v_nuevo_saldo DECIMAL(12,2);
    DECLARE v_movimiento_id INT;

    -- Obtener saldo actual con bloqueo (el caller debe haber iniciado la transacción si corresponde)
    SELECT saldo INTO v_saldo_actual FROM cuentas WHERE cuenta_id = p_cuenta_id FOR UPDATE;

    IF v_saldo_actual IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cuenta inexistente';
    END IF;

    SET v_nuevo_saldo = v_saldo_actual + p_importe;

    IF v_nuevo_saldo < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Saldo insuficiente para realizar movimiento';
    END IF;

    INSERT INTO movimientos(cuenta_id, fecha, detalle, importe, saldo, tipoMovimiento_id, transferencia_id)
    VALUES (p_cuenta_id, p_fecha, p_detalle, p_importe, v_nuevo_saldo, p_tipoMovimiento_id, p_transferencia_id);

    SET v_movimiento_id = LAST_INSERT_ID();

    UPDATE cuentas SET saldo = v_nuevo_saldo WHERE cuenta_id = p_cuenta_id;

    -- Devolvemos el id del movimiento (opcional)
    SELECT v_movimiento_id AS movimiento_id;
END//
DELIMITER ;

/* ---------- Prestamos ---------- */
DELIMITER //
CREATE PROCEDURE listarPrestamosPendientes()
BEGIN
   SELECT 
    p.prestamo_id,
    p.cliente_id,
    p.tipo_prestamo_id,
    p.cuenta_destino,
    p.monto_pedido,
    p.nro_cuotas,
    p.cuota_mensual,
    p.saldo_restante,
    p.cuotas_pagas,
    p.fecha,
    p.estado,
    c.nombre AS nombre_cliente,
    c.apellido AS apellido_cliente,
    tp.descripcion AS tipo_prestamo,
    tp.interes_mensual
FROM prestamos p
JOIN clientes c ON p.cliente_id = c.cliente_id
JOIN tipos_prestamo tp ON p.tipo_prestamo_id = tp.tipo_prestamo_id
WHERE p.estado = 'en proceso';
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE actualizarEstadoPrestamo(
    IN p_id INT,
    IN p_estado VARCHAR(20)
)
proc: BEGIN
    DECLARE v_monto DECIMAL(12,2);
    DECLARE v_cuenta_id INT;
    DECLARE v_nro_cuotas INT;
    DECLARE v_cuota_mensual DECIMAL(12,2);
    DECLARE v_fecha DATE;
    DECLARE v_saldo_nuevo DECIMAL(12,2);
    DECLARE i INT DEFAULT 1;

    -- Validación de estado
    IF p_estado NOT IN ('autorizado', 'rechazado') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Estado invalido. Solo se acepta: autorizado / rechazado.';
    END IF;

    -- Rechazo → solo cambia estado y sale
    IF p_estado = 'rechazado' THEN
        UPDATE prestamos
        SET estado = 'rechazado'
        WHERE prestamo_id = p_id;

        LEAVE proc;
    END IF;

    -- Obtener datos del préstamo
    SELECT
        monto_pedido,
        cuenta_destino,
        nro_cuotas,
        cuota_mensual,
        fecha
    INTO
        v_monto,
        v_cuenta_id,
        v_nro_cuotas,
        v_cuota_mensual,
        v_fecha
    FROM prestamos
    WHERE prestamo_id = p_id;

    IF v_monto IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El préstamo no existe.';
    END IF;

    -- Autorizar préstamo
    UPDATE prestamos
    SET estado = 'autorizado'
    WHERE prestamo_id = p_id;

    -- Acreditar saldo
    UPDATE cuentas
    SET saldo = saldo + v_monto
    WHERE cuenta_id = v_cuenta_id;

    -- Obtener saldo actualizado
    SELECT saldo
    INTO v_saldo_nuevo
    FROM cuentas
    WHERE cuenta_id = v_cuenta_id;

    -- Registrar movimiento
    INSERT INTO movimientos(
        cuenta_id,
        fecha,
        detalle,
        importe,
        saldo,
        tipoMovimiento_id
    )
    VALUES(
        v_cuenta_id,
        NOW(),
        CONCAT('Acreditación préstamo #', p_id),
        v_monto,
        v_saldo_nuevo,
        1
    );

    -- Generar cuotas
    WHILE i <= v_nro_cuotas DO
        INSERT INTO cuotas (
            prestamo_id,
            cuenta_id,
            numero_cuota,
            monto,
            fecha_vencimiento,
            estado
        )
        VALUES (
            p_id,
            v_cuenta_id,
            i,
            v_cuota_mensual,
            DATE_ADD(v_fecha, INTERVAL i MONTH),
            'pendiente'
        );
        SET i = i + 1;
    END WHILE;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE agregarPrestamo(
    IN p_cliente_id INT,
    IN p_cuenta_destino INT,
    IN p_tipo_prestamo INT,
    IN p_fecha DATE,
    IN p_monto_pedido DECIMAL(12,2),
    IN p_nro_cuotas INT,
    IN p_cuota_mensual DECIMAL(12,2)
)
BEGIN
    INSERT INTO prestamos (
        cliente_id,
        cuenta_destino,
        tipo_prestamo_id,
        fecha,
        monto_pedido,
        nro_cuotas,
        cuota_mensual,
        saldo_restante
    ) VALUES (
        p_cliente_id,
        p_cuenta_destino,
        p_tipo_prestamo,
        p_fecha,
        p_monto_pedido,
        p_nro_cuotas,
        p_cuota_mensual,
        p_monto_pedido
    );
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE PagarCuota(
    IN p_cuota_id INT,
    IN p_cuenta_id INT
)
BEGIN
    DECLARE v_monto DECIMAL(12,2);
    DECLARE v_saldo_actual DECIMAL(12,2);
    DECLARE v_saldo_nuevo DECIMAL(12,2);
    DECLARE v_prestamo_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error al pagar cuota. Se hizo rollback.';
    END;

    START TRANSACTION;

    -- Obtener datos de la cuota
    SELECT monto, prestamo_id
    INTO v_monto, v_prestamo_id
    FROM cuotas
    WHERE cuota_id = p_cuota_id
      AND estado = 'pendiente'
    FOR UPDATE;

    IF v_monto IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La cuota no existe o ya está pagada.';
    END IF;

    -- Obtener saldo actual
    SELECT saldo
    INTO v_saldo_actual
    FROM cuentas
    WHERE cuenta_id = p_cuenta_id
      AND estado = 1
    FOR UPDATE;

    IF v_saldo_actual < v_monto THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Saldo insuficiente para pagar la cuota.';
    END IF;

    SET v_saldo_nuevo = v_saldo_actual - v_monto;

    -- Descontar saldo
    UPDATE cuentas
    SET saldo = v_saldo_nuevo
    WHERE cuenta_id = p_cuenta_id;
    
    INSERT INTO movimientos(
        cuenta_id,
        fecha,
        detalle,
        importe,
        saldo,
        tipoMovimiento_id
    )
    VALUES(
        p_cuenta_id,
        NOW(),
        CONCAT('Pago de cuota del préstamo #', v_prestamo_id),
        -v_monto,
        v_saldo_nuevo,
        2
    );

    -- Marcar cuota como pagada
    UPDATE cuotas 
    SET estado = 'pagada',
        fecha_pago = NOW()
    WHERE cuota_id = p_cuota_id;

    -- Actualizar préstamo
    UPDATE prestamos
    SET 
        cuotas_pagas = cuotas_pagas + 1,
        saldo_restante = saldo_restante - v_monto
    WHERE prestamo_id = v_prestamo_id;

    COMMIT;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ListarPrestamosPorCliente(IN clienteId INT)
BEGIN
    SELECT pr.prestamo_id,
           pr.fecha,
           pr.monto_pedido,
           pr.nro_cuotas,
           pr.cuota_mensual,
           pr.saldo_restante,
           pr.cuotas_pagas,
           pr.estado,
           pr.cliente_id,
           pr.tipo_prestamo_id,
           pr.cuenta_destino
    FROM prestamos pr
    WHERE pr.cliente_id = clienteId;
END//
DELIMITER ;
