create database TeodoroCalleLara_Banco_10092021;
use TeodoroCalleLara_Banco_10092021;

/**Se crea la tabla EMPLEADO**/
CREATE TABLE EMPLEADO(
	idEmpleado INT AUTO_INCREMENT PRIMARY KEY NOT NULL UNIQUE,
    nombre VARCHAR(255) NOT NULL,
    apellidoP VARCHAR(255) NOT NULL,
    apellidoM VARCHAR(255) NOT NULL,
    calle VARCHAR(255) NOT NULL,
    numero INT NOT NULL,
    ciudad VARCHAR(255) NOT NULL,
    fechaIngreso DATE NOT NULL,
    sueldo DECIMAL(10,2) NOT NULL
);

/*Tabla Cliente*/
CREATE TABLE CLIENTE(
	idCliente INT AUTO_INCREMENT NOT NULL UNIQUE,
    idEmpleado INT NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    apellidoP VARCHAR(255) NOT NULL,
    apellidoM VARCHAR(255) NOT NULL,
    calle VARCHAR(255) NOT NULL,
    numero INT NOT NULL,
    ciudad VARCHAR(255) NOT NULL,
    fechaIngreso DATE NOT NULL,
    numeroTelefono INT NOT NULL,
    PRIMARY KEY (idCliente, idEmpleado), 
    CONSTRAINT fk_ClienEmple FOREIGN KEY (idEmpleado) REFERENCES EMPLEADO (idEmpleado) ON DELETE NO ACTION ON UPDATE NO ACTION
);

/*SUCURSAL*/
CREATE TABLE SUCURSAL(
	nombreSucursal VARCHAR(255) PRIMARY KEY NOT NULL UNIQUE,
    calle VARCHAR(255) NOT NULL,
    numero INT NOT NULL,
    ciudad VARCHAR(255) NOT NULL,
    telefonoSucursal INT NOT NULL
);

CREATE TABLE correoCliente(
	idCliente INT PRIMARY KEY NOT NULL,
	correo VARCHAR(255) NOT NULL UNIQUE,
	CONSTRAINT fk_CorreoCliente FOREIGN KEY (idCliente) REFERENCES CLIENTE (idCliente) ON DELETE CASCADE ON UPDATE NO ACTION
);

CREATE TABLE CUENTA_AHORROS(
	numeroCuenta VARCHAR(255) NOT NULL UNIQUE,
    idCliente INT NOT NULL,
    saldo DECIMAL(10,2),
    tipoInteres DECIMAL(2,1),
    fechaAcceso DATE NOT NULL,
    PRIMARY KEY(numeroCuenta, idCliente),
    CONSTRAINT fk_numCuen_Ahorros FOREIGN KEY (idCliente) REFERENCES CLIENTE (idCliente) ON DELETE CASCADE ON UPDATE NO ACTION
);

CREATE TABLE CUENTA_CORRIENTE(
	numeroCuentaCorriente VARCHAR(255) NOT NULL UNIQUE,
    idCliente INT NOT NULL,
    saldo DECIMAL(10,2),
    sobregiro INT,
    fechaAcceso DATE NOT NULL,
    PRIMARY KEY(numeroCuentaCorriente, idCliente),
    CONSTRAINT fk_numCuen_Corriente FOREIGN KEY (idCliente) REFERENCES CLIENTE (idCliente) ON DELETE CASCADE ON UPDATE NO ACTION
);

CREATE TABLE correoEmpleado(
	idEmpleado INT PRIMARY KEY NOT NULL,
	correoEmpleado VARCHAR(255) NOT NULL UNIQUE,
	CONSTRAINT fk_cEmpleado FOREIGN KEY (idEmpleado) REFERENCES EMPLEADO (idEmpleado) ON DELETE CASCADE ON UPDATE NO ACTION
);

CREATE TABLE numTelefono(
	idEmpleado INT PRIMARY KEY NOT NULL,
	telefono INT NOT NULL,
	CONSTRAINT fk_numTelEmpleado FOREIGN KEY (idEmpleado) REFERENCES EMPLEADO (idEmpleado) ON DELETE CASCADE ON UPDATE NO ACTION
);

CREATE TABLE PRESTAMO(
	idPrestamo INT NOT NULL UNIQUE,
    nombreSucursal VARCHAR(255) NOT NULL,
    monto INT NOT NULL,
    PRIMARY KEY(idPrestamo, nombreSucursal),
    CONSTRAINT fk_Pres_Sucursal FOREIGN KEY (nombreSucursal) REFERENCES SUCURSAL (nombreSucursal) ON DELETE CASCADE ON UPDATE NO ACTION
);

CREATE TABLE SOLICITAR(
	idCliente INT NOT NULL,
	idPrestamo INT NOT NULL,
	PRIMARY KEY(idCliente, idPrestamo),
    CONSTRAINT fk_solictarCliente FOREIGN KEY (idCliente) REFERENCES CLIENTE (idCliente) ON DELETE CASCADE ON UPDATE NO ACTION,
    CONSTRAINT fk_prestamoSolicitar FOREIGN KEY (idPrestamo) REFERENCES PRESTAMO (idPrestamo) ON DELETE CASCADE ON UPDATE NO ACTION
);

CREATE TABLE PAGO(
	idPrestamo INT NOT NULL,
	idPago INT NOT NULL,
    fechaPago DATE NOT NULL,
    montoPago INT NOT NULL,
    PRIMARY KEY(idPago, idPrestamo),
    CONSTRAINT fk_prestaPago FOREIGN KEY (idPrestamo) REFERENCES PRESTAMO (idPrestamo) ON DELETE CASCADE ON UPDATE NO ACTION
);

CREATE TABLE REG_CLIENTES(
	idCliente INT,
    idEmpleado INT,
    nombre VARCHAR(255) ,
    apellidoP VARCHAR(255) ,
    apellidoM VARCHAR(255) ,
    calle VARCHAR(255) ,
    numero INT ,
    ciudad VARCHAR(255) ,
    fechaIngreso DATE ,
    numeroTelefono INT ,
    USUARIO VARCHAR(255),
    FECHA_REGISTRO DATETIME
);

CREATE TABLE REG_EMPLEADOS(
	idEmpleado INT ,
    nombre VARCHAR(255) ,
    apellidoP VARCHAR(255) ,
    apellidoM VARCHAR(255) ,
    fechaIngreso DATE ,
    antiguedad double
);


SELECT * FROM REG_CLIENTES;

select * from CLIENTE;

select * from EMPLEADO;




