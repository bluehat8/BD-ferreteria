-- Procedimientos

--/**PROCEDIMIENTOS ALMACENADOS CLIENTES**/

--/**INSERTAR**/
alter procedure Ncliente
@PNombre nvarchar(15),
@SNombre nvarchar(15),
@PApell nvarchar(15),
@SApell nvarchar(15),
@Telc char(8)
as
if(@PNombre=''  or @PApell='' or @Telc='')
begin
	print'Nombre,Apellido y Telefono Son Datos Requeridos'
	select'Nombre,Apellido y Telefono Son Datos Requeridos'

end
else
begin
	insert into Clientes (PNombre,SNombre,PApell,SApell,TelC) values(@PNombre,@SNombre,@PApell,@SApell,@TelC)
end
go

select * from Clientes

GRANT EXECUTE ON OBJECT::[dbo].[Ncliente] TO escritor
GO

--/**MODIFICAR**/
alter procedure ModificarCL
@ID_Cliente int, 
@TelC char(8)
as
declare @id_clien as int 
set @id_clien=(select Id_cliente from Clientes where Id_cliente=@ID_Cliente)
if(@id_clien=@ID_Cliente)
begin
	
	if(@TelC='')
	begin
		print'Telefono Requerido'
		select'Telefono Requerido'

	end
	else
	begin
		update Clientes set TelC=@TelC from Clientes where Id_cliente=@ID_Cliente
	end
end
else
begin
	print'Cliente No Registrado'
	select'Cliente No Registrado'

end
go


--/**BUSCAR**/
alter procedure BuscarCl
@id_cliente int
as
declare @id_client as int 
set @id_client=(select Id_cliente from Clientes where Id_cliente=@id_cliente)
if(@id_client=@id_cliente)
begin
	select * from Clientes where Id_cliente=@id_cliente
end
else
begin
	print'Cliente No Registrado'
	select'Cliente No Registrado'

end
go

--/**LISTAR**/
create procedure ListarC
as
select * from Clientes
go





--/**PROCEDIMIENTO ALAMACENADO PROVEEDORES**/
--/**INSERTAR**/

select * from Proveedores

alter procedure NProveedores
@id_prove char(4),
@NombreProv nvarchar(45),
@Tel char(8),
@Direccion nvarchar(70),
@CorreoP nvarchar(75)
as
if(@id_prove='')
begin
	print'Id de proveedor No Debe quedar Nulo'
	select'Id de proveedor No Debe quedar Nulo'

end
else
begin
if(@NombreProv='')
begin
	print'Debe Ingresar el nombre del proveedor'
	select'Debe Ingresar el nombre del proveedor'
	
end
else
begin
	if(@Tel='')
	begin
		print'Debe ingresar el telefono del proveedor'
		select'Debe ingresar el telefono del proveedor'

	end
	else
	begin
		if(@Direccion='')
			begin
				print'debe ingresar la direccion del proveedor'
				select'debe ingresar la direccion del proveedor'

			end
			else
			begin
				if(@CorreoP='')
				begin
					print'debe ingresar el correo del proveedor'
					select'debe ingresar el correo del proveedor'

				end
				else
				begin
					insert into Proveedores (Id_Prov,NombreProv,TelP,DireccionP,correoP) values(@id_prove,@NombreProv,@Tel,@Direccion,@CorreoP)
				end
			end
	end
end
end
go


--/**MODIFICAR**/

alter procedure ModificarProvee
@id_Provee char(4),
@Telp char(8),
@direcci nvarchar(70),
@correop nvarchar(75)
as
declare @id_pro as char(4) 
set @id_pro=(select Id_Prov from Proveedores where Id_Prov=@id_Provee)
if(@id_pro=@id_Provee)
begin
	if(@Telp='')
	begin
		print'Numero Telefono Necesario'
		select'Numero Telefono Necesario'

	end
	else
	begin
		if(@direcci='')
			begin
				print'Debe ingresar la direccion del proveedor'
				select'Debe ingresar la direccion del proveedor'

			end
			else
			begin
				if(@correop='')
				begin
					print'Debe ingresar el correo del proveedor'
					select'Debe ingresar el correo del proveedor'

				end
				else
				begin
					update Proveedores set TelP=@Telp,DireccionP=@direcci,correoP=@correop where Id_Prov=@id_Provee
				end
			end
		end
end	
else
begin
	print'Proveedor No Registrado'
	select'Proveedor No Registrado'

end
go

--/**BUSCAR**/

alter procedure BuscarProv 
@id_proveedor char(4)
as
declare @id_proveedo as char(4) 
set @id_proveedo=(select Id_Prov from Proveedores where Id_Prov=@id_proveedor)
if(@id_proveedo=@id_proveedor)
begin
	select * from Proveedores where Id_Prov=@id_proveedor
end
else
begin
	print'Proveedor No Existe'
	select'Proveedor No Existe'

end
go

--/**LISTAR**/
create procedure ListarProv
as
select * from Proveedores
go





--/**PROCEDIMIENTO ALAMACENADO PRODUCTOS**/

select * from Proveedores
NProductos '34341','Alambre','12mts','12','20',8833

alter procedure NProductos
@cod_arti char(5),
@NombreP nvarchar(45),
@Desp nvarchar(60),
@precio float,
@exist int,
@id_Prov char(4)

as
declare @idprov as char(4)

if(@cod_arti='' or @NombreP='' or @Desp='')
begin
	print'Datos Del Producto Necesarios'
	select'Datos Del Producto Necesarios'
end
else
begin
if(@precio>0)
begin
	if(@exist>0)
	begin
		set @idprov=(select Id_Prov from Proveedores where Id_Prov=@id_Prov)
		if(@idprov=@id_Prov)
		begin
			
				insert into Productos(Cod_Prod,NombreP,DescP,precio,exist,Id_Prov)values(@cod_arti,@NombreP,@Desp,@precio,@exist,@id_Prov)
			
		end
		else
		begin
			print'Proveedor no registrado'
			select'Proveedor no registrado'

		end
	end
	else
	begin
		print'La Existencia NO debe ser NI negativa ni ceros'
		select'La Existencia NO debe ser NI negativa ni ceros'

	end
end
else
begin
	print'La cantidad NO debe ser NI negativa ni ceros'
	select'La cantidad NO debe ser NI negativa ni ceros'

end
end
go

select * from Proveedores

--/**MODIFIFCAR**/

alter procedure ModificarProducto
@cod_Pro char(5),
@nombrep nvarchar(45),
@precio float,
@exits int

as
declare @cod_p as char(5)

set @cod_p=(select Cod_Prod from Productos where Cod_Prod=@cod_Pro)
if(@cod_p=@cod_Pro)
begin
	if(@nombrep='')
	begin
		print'Nombre Requerido'
		select'Nombre Requerido'

	end
	else
	begin
		if(@precio>0)
		begin
			if(@exits>0)
			begin
				
		update Productos set NombreP=@nombrep,precio=@precio,exist=(exist+@exits) where Cod_Prod=@cod_Pro
				
			end
			else
			begin
				print'Existencia no debe ser Negativo Ni Ceros'
				select'Existencia no debe ser Negativo Ni Ceros'


			end
		end
		else
		begin
			print'Precio no debe ser Negativo Ni Ceros'
			select'Precio no debe ser Negativo Ni Ceros'

		end
	end
end
else
begin
	print'Producto No Registrado'
	select'Producto No Registrado'

end
go


--/**BUSCAR**/

alter procedure BuscarProduc
@cod_prod char(5)
as
declare @cod_arti as char(5)
set @cod_arti=(select Cod_Prod from Productos where Cod_Prod=@cod_prod)
if(@cod_arti=@cod_prod)
begin
	select * from Productos where Cod_Prod=@cod_prod
end
else
begin
	print'Producto No Registrado'
	select'Producto No Registrado'

end
go

--/**LISTAR**/

create procedure ListarProduct
as
select * from Productos
go









--/**PROCEDIMIENTOS ALMACENADOS VENTAS **/
--/**INSERTAR**/çç
select * from Clientes

Nventas 1

Select * from Ventas

alter procedure Nventas
@id_Cliente int
as
declare @idcliente as int
set @idcliente=(select Id_cliente from Clientes where Id_cliente=@id_Cliente)
if(@idcliente=@id_Cliente)
begin
	insert into Ventas(Id_cliente,totalv) values (@id_Cliente,0)
end
else
begin
	print'Cliente No registrado'
	select'Cliente No registrado'

end
go

--/**MODIFICAR**/

alter procedure ModificarVentas
@n_ventas int,
@id_cliente int
as
declare @n_Ven as int
declare @id_client as int
set @n_Ven=(select NVenta from Ventas where NVenta=@n_ventas)
if(@n_Ven=@n_ventas)
begin
	set @id_client=(select Id_cliente from Clientes where Id_cliente=@id_cliente)
	if(@id_client=@id_cliente)
	begin
		update Ventas set Id_cliente=@id_cliente where NVenta=@n_ventas
	end
	else
	begin
		print'Cliente No Registrado'
		select'Cliente No Registrado'


	end
end
else
begin
	print'Venta No registrada'
	select'Venta No registrada'

end
go

--/**BUSCAR**/

create procedure BuscarVentas
@n_ventas int
as
declare @n_Ven as int
set @n_Ven=(select NVenta from Ventas where NVenta=@n_ventas)
if(@n_Ven=@n_ventas)
begin
	select * from Ventas where NVenta=@n_ventas
end
else
begin
	print'Venta No Registrada'
end
go

--/**LISTAR**/

create procedure ListarVentas
as
select * from Ventas
go




--/**PROCEDIMIENTOS ALAMACENADOS  DETALLEVENTAS**/
--/**INSERTAR**/
alter procedure NDetalleVenta
@N_venta int,@cod_producto char(5),@cantidad int 
as 
declare @venta as int
set @venta=(select  NVenta from Ventas where NVenta=@N_venta)
declare @cp as char(5) 
set @cp=(select Cod_Prod from Productos where Cod_Prod=@cod_producto)
declare @e as int 
set @e=(select  exist from Productos where Cod_Prod=@cod_producto)
if(@N_venta=@venta)
begin
	if(@cod_producto='')
	begin
		print'El Codigo de producto No Puede ser Nulo'
		select 'El Codigo de producto No Puede ser Nulo'
	end
	else
	begin
		if(@cod_producto=@cp)
		begin
		  if(@cantidad>0)
		  begin
				if(@cantidad<=@e)
				begin
					insert into Detalle_Ventas values(@N_venta,@cod_producto,@cantidad,dbo.Cst(@cantidad,@cod_producto))
				end
				else
				begin
					print'No Hay Sufientes Existencia'
					select'No Hay Sufientes Existencia'

				end
		  end
		  else
		  begin
			print'L cantidad no debe ser Negativa Ni Cero'
			select'L cantidad no debe ser Negativa Ni Cero'

		  end
		end
		else
		begin
			print'Producto No Registrado'
			select'Producto No Registrado'

		end
	end
end
else
begin
	print'Venta No Registrada'
	select'Venta No Registrada'


end
go



-----Ventas y detalles de ventas
-- 1.- Operaciones Conjuntistas
-- 1.2.- UNIÓN
-- A: Ventas
-- B: Detalle_Venta
-- A U B
-- Operacion Conjuntista
-- INTERSECCION

create view VentasYDetalles
as
select Fecha_Venta, Id_cliente, totalv, Id_DetalleVenta,Cod_Prod, cantv, subtotalp
from Ventas C full join Detalle_ventas V
on C.NVenta=V.NVenta

create proc MuestraVentasDetalles
as
select Fecha_Venta as Fecha_venta, Id_cliente as ID_cliente, totalv as TotalVenta, ID_DetalleVenta as ID_DetalleVenta, Cod_Prod as CodigoProducto
, cantv as Cantidad, subtotalp as SubTotal from VentasYDetalles



select * from VentasYDetalles



--/**MODIFICAR**/

 create procedure modificarDetalle_Venta
  (@id_detalleVenta int, @cod_produ  char(5), @nuevacantidad int, @accion varchar(25))
  as
  begin
	declare @cantidadactual int
	declare @cantidadInventario int
	declare @precio_unitario decimal(9,3)
	declare @diferenciapro as int 
	if(@accion = 'devolver producto')
	begin
		if exists (select Id_DetalleVenta from Detalle_Ventas where Id_DetalleVenta=@id_detalleVenta)
		begin
			if exists (select Cod_Prod from Productos where Cod_Prod=@cod_produ)
			begin
				set @cantidadInventario=(select cantv from Detalle_Ventas where  Id_DetalleVenta=@id_detalleVenta and Cod_Prod=@cod_produ)
				update Productos set exist=(exist+@cantidadInventario) where Cod_Prod=@cod_produ
				delete from Detalle_Ventas where Id_DetalleVenta=@id_detalleVenta
			end
			else
			begin
				print'Producto no registrado'
				return 
			end
			print 'devolvio producto'
		end
		else
		begin
			print'Detalle_Venta No Registrado'
			return
		end
	end

	else if (@accion = 'cambiar cantidad')
	begin
	if exists (select Id_DetalleVenta from Detalle_Ventas where Id_DetalleVenta=@id_detalleVenta)
		begin
			if exists (select Cod_Prod from Productos where Cod_Prod=@cod_produ)
			begin
				select @cantidadactual = cantv from Detalle_Ventas where Id_DetalleVenta = @id_detalleVenta
				select @cantidadInventario = exist from Productos where  Cod_Prod=@cod_produ
		
				if(@nuevacantidad>@cantidadactual)
				begin
					set @diferenciapro = @nuevacantidad - @cantidadactual;

					if(@cantidadInventario >= @diferenciapro) 
					begin
						update Productos set exist = exist-@diferenciapro where Cod_Prod=@cod_produ;
					end
					else
					begin
						print 'NO hay suficiente'
						return
					end
				end
				else
				begin
					set @diferenciapro = @cantidadactual - @nuevacantidad;
					update Productos set exist = exist+@diferenciapro where  Cod_Prod=@cod_produ;
				end

				select @precio_unitario = p.precio from Productos p where p.Cod_Prod = @cod_produ
				declare @calculo money = @precio_unitario * @nuevacantidad;

				update  Detalle_Ventas set Cod_Prod=@cod_produ, cantv=@nuevacantidad, subtotalp=@calculo 
				where Id_DetalleVenta=@id_detalleVenta
				print 'El cambio de Cantidad Del Producto se realizo exitosamente'
			end
			else
			begin
				print'producto no registrado'
				return
			end
		end
		else
		begin
			print'detalle_Venta no registrado'
			return
		end
	end
	else
	begin
		if(@accion='' or @accion is null)
		begin
			print'Debe Ingresar ->cambiar cantidad<-  o ->devolver producto<- para utlizar los procedimientos'
		end
	end
  end
  go


  --/**BUSCAR**/

 create procedure BuscarDetalleVenta
@id_detalleve int
as
declare @iddeta as int 
set @iddeta=(select Id_DetalleVenta from Detalle_Ventas where Id_DetalleVenta=@id_detalleve)
if(@iddeta=@id_detalleve)
begin
	select * from Detalle_Ventas where Id_DetalleVenta =@id_detalleve
end
else
begin
	print'Detalle de venta no Registrado'
end
go



  --/**LISTAR**/
create procedure ListarDetalle_Venta
as
select * from Detalle_Ventas
go


--/**FUNCION CALCULO SUBTOTAL DETALLEVENTAS**/
create function Cst(@cant int ,@CP char(5))
returns Float
as
begin
	declare @st as float
	select @st = precio * @cant from Productos where Cod_Prod=@CP
	return @st
end


--trigger para actualizar el inventario por ventas
create trigger ActIV
on 
Detalle_Ventas
for insert
as
declare @Nventa as int
declare @monto float
declare @cant as int
declare @cod_pro as char(5)
select @cant=cantv from inserted 
select @cod_pro=Cod_Prod from inserted
update Productos set exist=exist-@cant where Cod_Prod=@cod_pro
select @Nventa= NVenta from inserted 
select @monto = sum(subtotalp) from Detalle_Ventas d where  NVenta= @Nventa
update Ventas set totalv = @monto where @Nventa = NVenta
go


--TRIGGER Actualizar el nuevo total VENTAS cuando se modifica el detalle venta
create trigger ActualizarTotalVenta
on  
Detalle_Ventas
for update
as
declare @nventa as int
declare @montoNuevo as float 
declare @iddetallev as int
select @iddetallev=Id_DetalleVenta from inserted
select @nventa=NVenta from inserted where Id_DetalleVenta=@iddetallev
select @montoNuevo = sum(subtotalp) from Detalle_Ventas where NVenta=@nventa
update Ventas set totalv=@montoNuevo where NVenta=@nventa
go


--TRIGGER Actualizar el nuevo total VENTAS cuando se ELIMINA un detalle venta
create trigger ActualizarTotalVentaElimi
on  
Detalle_Ventas
for delete
as
declare @nventa as int
declare @montoNuevo as float 
declare @iddetallev as int
select @iddetallev=Id_DetalleVenta from deleted
select @nventa=NVenta from deleted where Id_DetalleVenta=@iddetallev
select @montoNuevo = sum(subtotalp) from Detalle_Ventas where NVenta=@nventa
update Ventas set totalv=@montoNuevo where NVenta=@nventa
go






-----Compras y detalles de compras
-- 1.- Operaciones Conjuntistas
-- 1.2.- UNIÓN
-- A: Compras
-- B: Detalle_Compra
-- A U B
-- Operacion Conjuntista
-- INTERSECCION

create view ComprasYDetalles
as
select Fecha_Compra, TotalCompra, Id_Prov, TipoPago,ID_DetalleCompra, Cod_Prod,Cantidad, precioCompra,subtotal
from Compras C full join Detalle_Compra V
on C.Id_Compra=V.Id_Compra

create proc MuestraComprasYDetalles
as
select Fecha_Compra, TotalCompra, Id_Prov, TipoPago,ID_DetalleCompra, Cod_Prod,Cantidad, precioCompra,subtotal
from ComprasYDetalles

select * from Compras
select * from Detalle_Compra

delete Compras where Id_prov=8833
delete Detalle_Compra where Cod_Prod='88112'










