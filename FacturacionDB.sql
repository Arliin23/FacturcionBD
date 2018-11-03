USE master
GO

-- This section is for developing purposes
-- This kills any connection for databse "Facturacion"
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
ID_Articulo int Identity(40000, 1) primary key not null,
Descripcion varchar(400) not null,
Costo_Unitario float not null,
Precio_Unitario float not null,
Estado varchar (60) not null
CONSTRAINT CHK_EstadoArticulo CHECK(Estado IN('Disponible', 'No Disponible'))

);

CREATE TABLE Cliente(
ID_Cliente int Identity(50000, 1) primary key not null,
Nombre_Comercial varchar(50) not null,
Cedula bigint not null unique,
CONSTRAINT AK_Cedula UNIQUE(Cedula),
Cuenta_Contable varchar(50),
Estado varchar (60) not null 
CONSTRAINT CHK_EstadoCliente CHECK(Estado IN('Activo', 'Dormido' ,'Baja'))
);

CREATE TABLE Vendedor (
ID_Vendedor int Identity(40000, 1) primary key not null,
Nombre varchar(50) not null,
Porciento_Comision int not null,
Estado varchar(60) not null
CONSTRAINT CHK_EstadoVendedor CHECK(Estado IN('Activo', 'Dormido' ,'Baja'))
);


CREATE TABLE Condicion_Pago (
ID_Condicion int Identity(60000, 1) primary key not null,
Descripcion varchar(400) not null,
Cantidad_dias int not null,
Estado varchar (60) not null,
CONSTRAINT CHK_EstadoPago CHECK(Estado IN('Pago al contado', 'Pago anticipado', 'Pago aplazado'))

);


CREATE TABLE Factura(
ID_Factura int Identity(70000, 1) primary key not null,
Forma_Pago varchar(50) not null,
ID_Vendedor int not null,
CONSTRAINT FK_VendedorFactura FOREIGN KEY(ID_Vendedor) REFERENCES Vendedor(ID_Vendedor),
ID_Cliente int not null,
CONSTRAINT FK_ClienteFactura FOREIGN KEY(ID_Cliente) REFERENCES Cliente(ID_Cliente),
Fecha date not null,
Comentario varchar(60) not null,
ID_Articulo int not null,
Cantidad int not null,
Precio_Unitario float not null
);

CREATE TABLE Articulo_Factura (
ID_Articulo int not null,
ID_Factura int  not null,
CONSTRAINT PK_Articulo_Factura Primary Key(ID_Articulo, ID_Factura),
FOREIGN KEY (ID_Articulo) REFERENCES Articulo_Facturable(ID_Articulo),
FOREIGN KEY (ID_Factura) REFERENCES Factura(ID_Factura)
);

CREATE TABLE Usuario(
Id_Usuario int Identity(80000, 1) Primary Key,
Nombre_Usuario varchar(10) not null unique,
Clave varchar(30) not null, 
Estado varchar(50) not null, 
CONSTRAINT CHK_EstadoUsuario CHECK(Estado IN('Activo', 'Vacaciones', 'Inactivo'))   
);



--Insertar valores de prueba
insert into Cliente values ( 'Erick', '40209553250', 'Primera', 'Activo');

insert into Vendedor values ('Pedro', '7', 'Activo');

insert into Condicion_Pago values ('Hipoteca de casa', '30', 'Pago al contado');

select * from Condicion_Pago

insert into Usuario values ('Arliin23', 'PIPOVIVE', 'Activo'),
('Bass360', 'PIPOVIVE', 'Activo'),
('Estef', 'PIPOVIVE', 'Activo')
;

update Usuario set Estado = 'Vacaciones' where id_usuario = 80001

select * from Usuario
