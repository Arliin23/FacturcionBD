USE master
GO

-- This section is for developing purposes
-- This kills any connection for databse "Nomina"
-- In case they exist, allowing to then drop the DB
DECLARE @kill varchar(8000) = '';
SELECT @kill = @kill + 'kill ' + CONVERT(varchar(5), spid) + ';'
FROM master..sysprocesses 
WHERE dbid = db_id('FacturacionBD')

EXEC(@kill);
GO

--Recrea la base de datos

DROP DATABASE IF EXISTS FacturacionDB;
GO

CREATE DATABASE FacturacionBD;
GO

USE FacturacionBD;
GO

--Tablas

CREATE TABLE Articulo_Facturable(
ID_Articulo int primary key not null,
Descripcion varchar(60) not null,
Costo_Unitario float not null,
Precio_Unitario float not null,
Estado varchar (60) not null
);

CREATE TABLE Cliente(
ID_Cliente int primary key not null,
Nombre_Comercial varchar(50) not null,
Cedula int not null,
CONSTRAINT AK_Cedula UNIQUE(Cedula),
Cuenta_Contable varchar(50),
Estado varchar (60) not null 
);

CREATE TABLE Condicion_Pago (
ID_Condicion int primary key not null,
Descripcion varchar(60) not null,
Cantidad_dias int not null,
Estado varchar (60) not null
);

CREATE TABLE Vendedor (
ID_Vendedor int primary key not null,
Nombre varchar(50) not null,
Porciento_Comision int not null,
Estado varchar(60) not null
);

CREATE TABLE Factura(
ID_factura int primary key not null,
Forma_pago varchar(50) not null,
ID_Vendedor int not null,
ID_Cliente int not null,
Fecha date not null,
Comentario varchar(60) not null,
ID_Articulo int not null,
Cantidad int not null,
Precio_unitario float not null
);

