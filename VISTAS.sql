USE TeodoroCalleLara_Banco_10092021;
CREATE VIEW SUCURSALES AS
SELECT nombreSucursal, calle, numero, ciudad, telefonoSucursal FROM SUCURSAL;

CREATE VIEW EMPLEADOS AS
SELECT nombre, apellidoP,apellidoM,calle,numero,ciudad,fechaIngreso
FROM EMPLEADO;

CREATE VIEW CLIENTES AS
SELECT nombre, apellidoP,apellidoM,calle,numero,ciudad,fechaIngreso,numeroTelefono
FROM CLIENTE;

CREATE VIEW EMPLEADOS_IJ AS
SELECT idEmpleado,nombre, apellidoP,apellidoM,ciudad
FROM EMPLEADO;

CREATE VIEW CLIENTES_IJ AS
SELECT idEmpleado,nombre, apellidoP,apellidoM,ciudad
FROM CLIENTE;
