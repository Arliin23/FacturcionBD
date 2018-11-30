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
Nombre_Articulo varchar(40) not null,
Costo_Unitario float not null,
Precio_Unitario float not null,
Cantidad int not null,
Estado varchar (60) not null
CONSTRAINT CHK_EstadoArticulo CHECK(Estado IN('Disponible', 'No Disponible'))

);

CREATE TABLE Cliente(
ID_Cliente int Identity(50000, 1) primary key not null,
Nombre_Comercial varchar(50) not null,
Cedula bigint not null unique,
CONSTRAINT AK_Cedula UNIQUE(Cedula),
Cuenta_Contable varchar(50),
CONSTRAINT CHK_CuentaContableCliente CHECK(Cuenta_Contable IN('Debito', 'Credito')),
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
Clave varchar(32) not null, 
Estado varchar(50) not null, 
CONSTRAINT CHK_EstadoUsuario CHECK(Estado IN('Activo', 'Vacaciones', 'Inactivo'))   
);


--Insertar valores de prueba
insert into Cliente values ( 'Erick', '40209553250', 'Debito', 'Activo');

insert into Vendedor values ('Pedro', '7', 'Activo');

insert into Condicion_Pago values ('Hipoteca de casa', '30', 'Pago al contado');

insert into Usuario values('Admin', 'Pipo', 'Activo');

select * from Condicion_Pago

insert into Usuario values ('Arliin23', 'PIPOVIVE', 'Activo'),
('Bass360', 'PIPOVIVE', 'Vacaciones'),
('Estef', 'PIPOVIVE', 'Activo')
;

insert into Articulo_Facturable values ('Melon', 20, 50, 300, 'Disponible'),
('Pimiento rojo', 5, 15, 200, 'Disponible'),
('Pimiento verde', 5, 15, 200, 'Disponible'),
('Pan Bimbo', 30, 60, 245, 'Disponible'),
('Emparedado', 25, 50, 80, 'Disponible'),
('Dulce de Leche', 15, 25, 150, 'Disponible'),
('Salsa picante', 50, 80, 100, 'Disponible'),
('Pechuga de pollo', 80, 150, 90, 'Disponible'),
('Filete de pescado', 70, 130, 100, 'Disponible'),
('Arroz Pimco', 80, 150, 250, 'Disponible'),
('Platano maduro', 5, 18, 87, 'Disponible'),
('Platano verde', 3, 15, 125, 'Disponible'),
('Jugo de Naranja', 40, 85, 90, 'Disponible'),
('Mantequilla de mani', 55, 100, 50, 'Disponible'),
('Mayonesa', 40, 75, 300, 'Disponible'),
('Pepinillos', 30, 70, 200, 'Disponible'),
('Cebolla', 5, 15, 125, 'Disponible'),
('Ron Brugal', 250, 600, 50, 'Disponible'),
('Coca-Cola', 45, 60, 200, 'Disponible'),
('Leche Rica', 40, 85, 65, 'Disponible'),
('Cafe molido', 45, 80, 300, 'Disponible'),
('Galletas wafer', 15, 45, 100, 'Disponible'),
('Tostitos', 100, 185, 50, 'Disponible'),
('Chocolate embajador', 2, 5, 100, 'Disponible'),
('Pasta Princesa', 15, 35, 124, 'Disponible'),
('Salsa de tomate', 25, 45, 120, 'Disponible'),
('Desodorante AXE', 75, 125, 80, 'Disponible'),
('Harina el negrito', 15, 35, 200, 'Disponible'),
('Red Bull', 75, 125, 70, 'Disponible'),
('Habichuelas rojas', 45, 80, 300, 'Disponible');


update Usuario set Clave = 'BCFF3BD90663E3D89D07700AF2C05A62' where id_usuario = 80001
update Usuario set Clave = '80DB790085DB27F745B9B654CD70A240' where Id_Usuario = 80000
update usuario set Clave = 'BCFF3BD90663E3D89D07700AF2C05A62' where Id_Usuario = 80002
update usuario set Clave = 'BCFF3BD90663E3D89D07700AF2C05A62' where Id_Usuario = 80003

select * from Usuario
select * from Articulo_Facturable