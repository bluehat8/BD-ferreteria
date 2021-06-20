--/**PROCEDIMIENTOS ALMACENADOS COMPRAS **/
  --/**INSERTAR**/

alter procedure Ncompra 
@idprov char(4),
@tipopago varchar(30)
as
declare @idproveed as int 
set @idproveed=(select Id_Prov from Proveedores where Id_Prov=@idprov)
if(@idproveed=@idprov)
begin
	if(@tipopago='')
	begin
		print'Tipo De Pago No Puede ser Nu'
		select 'Tipo De Pago No Puede ser Nu'
	end
	else
	begin
		insert into Compras(TotalCompra,Id_Prov,TipoPago) values(0,@idprov,@tipopago)
	end
end
else
begin
	print'Proveedor No Registrado'
	select'Proveedor No Registrado'

end
go


select * from Compras

 --/**MODIFICAR**/

alter procedure Mcompra 
@id_Compra int,
@Tipopago varchar(30)
as
declare @iddetallefac as int
set @iddetallefac=(select Id_Compra from Compras where Id_Compra=@id_Compra)
if(@iddetallefac=@id_Compra)
begin
	if(@Tipopago='')
		begin
			print'Debe Ingresar El Tipo De Pago'
			select'Debe Ingresar El Tipo De Pago'

		end
		else
		begin
			update Compras set Fecha_Compra=current_timestamp,TipoPago=@Tipopago where Id_Compra=@id_Compra
		end
end
else
begin
	print'Compra No Registrada'
	select'Compra No Registrada'

end
go



  --/**BUSCAR**/
alter procedure BuscarCompra
@id_Compra int
as
declare @id_com as int
set @id_com=(select Id_Compra from Compras where Id_Compra=@id_Compra)
if(@id_com=@id_Compra)
begin
	select * from Compras where Id_Compra=@id_Compra
end
else
begin
	print'Compra No Registrada'
	select'Compra No Registrada'


end
go


  --/**LISTAR**/
create procedure ListarCompras
as
select * from Compras
go



 --/**PROCEDIMIENTOS ALAMCENADOS DETALLECOMPRAS**/
  --/**INSERTAR**/


  NDetalleCompra 5, '88112',2,21
  select * from Detalle_Compra
  select * from Productos
  insert into Detalle_Compra values('88112',2,24,2,3)
  select * from Compras
  delete Compras where Id_Compra=4 
  delete Detalle_Compra where Id_Compra=4

  NCompra '8833','Efectivo'

alter procedure NDetalleCompra
@idcompra int,@cod_producto char(5),@cantidad int,@precioCom float
as 
declare @id_comp as int
set @id_comp=(select  Id_Compra from Compras where Id_Compra=@idcompra)
declare @codp as char(5) 
set @codp=(select Cod_Prod from Productos where Cod_Prod=@cod_producto)
if(@idcompra=@id_comp)
begin
	if(@cod_producto='')
	begin
		print'No Puede ser Nulo'
		select'No Puede ser Nulo'

	end
	else
	begin
		if(@cod_producto=@codp)
		begin
		  if(@cantidad>0)
		  begin
			insert into Detalle_Compra values(@idcompra,@cod_producto,@cantidad,@precioCom,dbo.StdC(@cantidad,@precioCom))
			print'Bienvenido'
		  end
		  else
		  begin
			print'La cantidad no debe ser Negativa Ni Cero'
			select'La cantidad no debe ser Negativa Ni Cero'

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
	print'Compra No Registrada'
	select'Compra No Registrada'

end
go


 --/**MODIFICAR**/

alter procedure modificarDetalle_Compras
  (@id_DetalleCompra int, @cod_producto char(5), @nuevacantidad int,@precio float, @accion varchar(25))
  as
  begin
	declare @cantidadactual int
	declare @cantidadInventario int
	declare @precio_unitario decimal(9,3)
	declare @diferenciapro as int 
	if(@accion = 'devolver producto')
	begin
		if exists (select Id_DetalleCompra from Detalle_Compra where Id_DetalleCompra=@id_DetalleCompra)
		begin
			if exists (select Cod_Prod from Productos where Cod_Prod=@cod_producto)
			begin
				delete from Detalle_Compra where Id_DetalleCompra=@id_DetalleCompra
			end
			else
			begin
				print'Producto no registrado'
				select'Producto no registrado'


				return 
			end
			print 'Producto Devuelto al Proveedor'
			select 'Producto Devuelto al Proveedor'

		end
		else
		begin
			print'Detalle_Compra No Registrado'
			select'Detalle_Compra No Registrado'

			return
		end
	end

	else if (@accion = 'cambiar cantidad')
	begin
	if exists (select Id_DetalleCompra from Detalle_Compra where Id_DetalleCompra=@id_DetalleCompra)
		begin
			if exists (select Cod_Prod from Productos where Cod_Prod=@cod_producto)
			begin
				declare @calculo float = @precio * @nuevacantidad;

				update  Detalle_Compra set Cantidad=@nuevacantidad, subtotal=@calculo 
				where Id_DetalleCompra=@id_DetalleCompra
				print 'El cambio se realizo exitosamente'
				select 'El cambio se realizo exitosamente'

			end
			else
			begin
				print'producto no registrado'
				select'producto no registrado'

				return
			end
		end
		else
		begin
			print'detalle_compra no registrado'
			select'detalle_compra no registrado'

			return
		end
	end
	else
	begin
		if(@accion='' or @accion is null)
		begin
			print'Debe Ingresar ->cambiar cantidad<-  o ->devolver<- producto para utlizar los procedimientos'
			select'Debe Ingresar ->cambiar cantidad<-  o ->devolver<- producto para utlizar los procedimientos'

		end
	end
  end
  go


 --/**BUSCAR**/

 alter procedure BuscarDetallecompra
@id_detallecomp int
as
declare @id_detallec as int
set @id_detallec=(select Id_DetalleCompra from Detalle_Compra where Id_DetalleCompra=@id_detallecomp)
if(@id_detallec=@id_detallecomp)
begin	
	select * from Detalle_Compra where Id_DetalleCompra=@id_detallecomp
end
else
begin	
	print'Detalle de Compra No registrada'
	select'Detalle de Compra No registrada'

end
go

  --/**LISTAR**/

create procedure Listardetallecompras
as
select * from Detalle_Compra
go


  --/**FUNCION CALCULO SUBTOTAL COMPRA**/
alter function StdC(@cant int ,@precioc float)
returns float 
as
begin
	declare @stdco as float
	select @stdco=@cant*@precioc 
	return @stdco
end


go

delete  Compras where Id_Prov=8833;
delete Detalle_Compra where Id_Compra=1;
select * from Detalle_Compra
select * from Compras

  --/**TRIGGER  Actualizar el inventario de productos**/
alter trigger ActICompr
on 
Detalle_Compra
for insert
as
declare @idCompra as int
declare @montot as float
declare @canti as int
declare @cod_product as char(5)
select @canti= Cantidad from inserted 
select @cod_product=Cod_Prod from inserted
update Productos set exist=exist+@canti where Cod_Prod=@cod_product
select @idcompra= Id_Compra from inserted 
select @montot = sum(subtotal) from Detalle_Compra where Id_Compra= @idcompra
update Compras set TotalCompra=@montot where @idcompra=Id_Compra
go


  --/**TRIGGER  Actualizar el total de compra cuando se mofica un detalle compra**/
create trigger ActualizarTotalCompra
on  
Detalle_Compra
for update
as
declare @nventa as int
declare @montoNuevo as float 
declare @iddetallev as int
declare @id_com as int
declare @idCompr as int
select @id_com=Id_DetalleCompra from inserted
select @idCompr=Id_Compra from inserted where Id_DetalleCompra=@id_com
select @montoNuevo = sum(subtotal) from Detalle_Compra where Id_Compra=@idCompr
update Compras set TotalCompra=@montoNuevo where Id_Compra=@idCompr
go


 --/**TRIGGER  Actualizar el inventario de productos cuando se elimina un  detalle compra**/
create trigger ActualizarTotalCompraElimi
on  
Detalle_Compra
for delete
as
declare @nCompra as int
declare @montoNuevo as float 
declare @iddetallComp as int
declare @exits as int
declare @codigopro as char(5)
select @iddetallComp=Id_DetalleCompra from deleted
select @nCompra=Id_Compra from deleted where Id_DetalleCompra=@iddetallComp
select @montoNuevo = sum(subtotal) from Detalle_Compra where Id_Compra=@nCompra
update Compras set TotalCompra=@montoNuevo where Id_Compra=@nCompra
 select @exits=Cantidad  from deleted where Id_DetalleCompra=@iddetallComp
 select @codigopro=Cod_Prod from deleted where Id_DetalleCompra=@iddetallComp
update Productos set exist=exist-@exits where Cod_Prod=@codigopro
go




