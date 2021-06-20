create database BDFerreteria
use BDFerreteria

select * from Clientes

create table Clientes(
Id_cliente int identity(1,1) primary key not null,
PNombre nvarchar(15) not null,
SNombre nvarchar(15),
PApell nvarchar(15) not null,
SApell nvarchar(15),
TelC char(8) check(TelC like '[2|5|7|8][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') not null,
)






create table TiposProduct(
Id_Tipoprod int identity(1,1) primary key not null,
NombreTipopro nvarchar(25) not null
)

create table Proveedores(
Id_Prov char(4) primary key not null,
NombreProv nvarchar(45) not null,
TelP char(8) check(TelP like '[2|5|7|8][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') not null,
DireccionP nvarchar(70) not null,
correoP nvarchar(75) not null
)

select * from Productos
drop table Productos

create table Productos(
Cod_Prod char(5) primary key not null,
NombreP nvarchar(45) not null,
DescP nvarchar(60) not null,
precio float not null,
exist int not null,
Id_Prov char(4) foreign key references Proveedores(Id_Prov) not null,

)
drop table Detalle_Ventas
drop table Detalle_Compra
drop table Compras
drop table Ventas
drop table Devoluciones
create table Ventas(
NVenta int identity(1,1) primary key not null,
Fecha_Venta date default getdate() not null,
Id_cliente int foreign key references Clientes(Id_cliente) not null,
totalv float
)


create table Detalle_Ventas(
Id_DetalleVenta int identity(1,1) primary key not null,
NVenta int foreign key references Ventas(NVenta) not null,
Cod_Prod char(5) foreign key references Productos(Cod_Prod) not null,
cantv int not null,
subtotalp float,
)
drop table Compras
create table Compras
(
Id_Compra int primary key identity(1,1),
Fecha_Compra datetime not null default current_timestamp,
TotalCompra float,
Id_Prov char(4) not null,
TipoPago varchar(30) not null, 
foreign key(Id_Prov) references Proveedores(Id_Prov)
)
drop Table Detalle_Compra
create table Detalle_Compra
(
	Id_DetalleCompra int identity(1,1) primary key not null,
	Id_Compra int foreign key references Compras(Id_Compra ) not null,
	Cod_Prod char(5) foreign key references Productos(Cod_Prod) not null,
	Cantidad int not null,
	precioCompra  float,
	subtotal float
)
drop table Devoluciones

create table Devoluciones(
	 Id_Devolucion int primary key identity (1,1) not null,
	 Id_Compra int default null,
	 TotalD float,
	 Fecha_Devolucion date default getdate()not null,
	 foreign key(Id_Compra) references Compras(Id_Compra)
);

create table Detalles_Devoluciones(
	Id_DetalleDevoluc int identity(1,1) primary key not null,
	Cod_Prod char(5) foreign key references Productos(Cod_Prod),
	Id_Devolucion int,foreign key(Id_Devolucion) references Devoluciones(Id_Devolucion),
	cantidad int,
	subtotalD float,
	Motivo varchar(100),
);




	backup database BDFerreteria to disk='C:\BackUp\BDFerreteria_2.bak'
