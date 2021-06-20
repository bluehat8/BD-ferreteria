  --/**PROCEDIMIENTOS ALMACENADOS DEVOLUCION**/
   --/**insertar**/


DBCC CHECKIDENT (Compras, RESEED, 0)
DBCC CHECKIDENT (Detalle_Compra, RESEED,0)
DBCC CHECKIDENT (Ventas, RESEED, 0)
DBCC CHECKIDENT (Detalle_ventas, RESEED, 0)

nueva_dev 1
select * from compras

alter procedure nueva_dev
@id_compra int

as
begin	
		if exists (select * from Compras where Id_Compra = @id_compra)
		begin

			insert into Devoluciones(Id_Compra,TotalD) values(@id_compra ,0)
		end
		else
		begin
			print'Compra no registrada'
			select'Compra no registrada'


		end
	end




--/**MODIFICAR**/

alter procedure Mdevolucion
@id_devolucion int,
@idcompra int,
@nventa int
as
declare @id_devolu as int
set @id_devolu=(select Id_Devolucion from Devoluciones where Id_Devolucion=@id_devolucion)
if(@id_devolu=@id_devolucion)
begin
if(@idcompra is null)	--si compra es null entonces es una venta .
	begin
		if exists (select * from Ventas where NVenta = @nventa)
		begin
			update Devoluciones set Id_Compra=@idcompra,NVenta=@nventa
		end
		else
		begin
			print'Venta no registrada'
			select'Venta no registrada'

		end
	end
	else
	begin
		if exists (select * from Compras where Id_Compra = @idcompra)
		begin
			update  Devoluciones set Id_Compra=@idcompra,NVenta=@nventa
		end
		else
		begin
			print'Compra no registrada'
			select'Compra no registrada'

		end
	end
end
else
begin
	print'Devolucion No Registrada'
	select'Devolucion No Registrada'

end
go


--/**BUSCAR**/

create procedure BuscarDevolu
@id_devolucion int
as
declare @id_devoluci as int
set @id_devoluci=(select Id_Devolucion from Devoluciones where Id_Devolucion=@id_devolucion)
if(@id_devoluci=@id_devolucion)
begin
	select * from Devoluciones where Id_Devolucion=@id_devolucion
end
else
begin
	print'Devolucion No Registrada'
	select'Devolucion No Registrada'

end
go


--/**LISTAR**/

create procedure ListarDevolu
as
select * from Devoluciones
go



--/**PROCEDIMIENTOS ALMACENADOS DETALLEDEVOLUCION**/
--/**INSERTAR**/
select * from Productos
nueva_detalle_devolucion '88112',1,50,'Falla'
select* from Detalles_Devoluciones

alter procedure nueva_detalle_devolucion
@cod_pro char(5),
@id_dev int,
@cantidad int,
@motivo varchar(100)
as
declare @e as int 
set @e=(select  exist from Productos where Cod_Prod=@cod_pro)
begin
	if exists (select * from Productos where Cod_Prod = @cod_pro)
	begin
		if exists (select * from Devoluciones where Id_Devolucion = @id_dev)
		begin


		if(@cantidad<=@e)
				begin
					insert into Detalles_Devoluciones(Cod_Prod, Id_Devolucion,cantidad,subtotalD,Motivo) 
			        values(@cod_pro, @id_dev, @cantidad,dbo.StD(@cantidad,@cod_pro),@motivo)
					
				end
				else
				begin
					print'No Hay Sufientes Existencias para devolver'
					select'No Hay Sufientes Existencias para devolver'  
				end
			
		end
		else
		begin
			print'Devolucion No registrada'
			select'Devolucion No registrada'  ;
		end
	end
	else
	begin
		print'Producto No registrado'
		select 'Producto No registrado'
	end
end
go



--/**MODIFICAR**/
alter procedure Mdetalle_devoluc
@id_detalledevol int ,@descripcion varchar(100)
 as
 declare @idevo as int 
 set @idevo=(select Id_DetalleDevoluc from Detalles_Devoluciones where Id_DetalleDevoluc=@id_detalledevol)
if(@idevo=@id_detalledevol)
begin
	if(@descripcion='')
	begin
		print'Ingrese la nueva descripcion'
		select 'Ingrese la nueva descripcion'
	end
	else
	begin
		update Detalles_Devoluciones set Motivo=@descripcion where Id_DetalleDevoluc=@id_detalledevol
	end
end
else
begin
	print'Detalle de devolucion no registrada'
	select 'Detalle de devolucion no registrada'
end
go


--/**BUSCAR**/
alter procedure BuscardetalleDevolucion
@id_detadevolucion int 
as
declare @id_devol as int
set @id_devol=(select Id_DetalleDevoluc from Detalles_Devoluciones where Id_DetalleDevoluc=@id_detadevolucion)
if(@id_devol=@id_detadevolucion)
begin
	select * from Detalles_Devoluciones where Id_DetalleDevoluc=@id_detadevolucion
end
else
begin
	print'Detalle de devolucion No Registrado'
	select 'Detalle de devolucion No Registrado'
end
go

--/**LISTAR**/

create procedure Listardeatlledevolucion
as
select * from Detalles_Devoluciones
go



--/**FUNCION CALCULO SUBTOTAL DEVOLUCION**/
create function StD (@cantida int ,@codpro char(5))
returns float
as
begin
	declare @Subtdevo as float 
	select @Subtdevo=  precio * @cantida from Productos where Cod_Prod=@codpro
	return @Subtdevo
end



--/**trigger Actualizar inventario Productos cuando se inserta un detalledevolucion**/
alter trigger AcIDe
on 
Detalles_Devoluciones
for insert
as
declare @cantid as int
declare @cod_pr as char(5)
declare @compra as int
declare @Totaldevuel as float
declare @montoNuevoDev as float
declare @iddevolu as int
select @cantid=cantidad from inserted 
select @cod_pr=Cod_Prod from inserted
select @compra=Id_Devolucion from inserted 
set @compra=(select Id_Compra from Devoluciones where Id_Devolucion=@compra)

update Productos set exist=exist-@cantid where Cod_Prod=@cod_pr

select @iddevolu=Id_Devolucion from inserted
select @montoNuevoDev = sum(subtotalD) from Detalles_Devoluciones where Id_Devolucion=@iddevolu
update Devoluciones set TotalD=@montoNuevoDev where Id_Devolucion=@iddevolu
go

