
--REPORTES
create view ComprasPproveedor
as
select c.Id_Compra, p.NombreProv, c.TotalCompra, sum(dc.Cantidad) as [Cantcomprada], c.Fecha_Compra
from Compras c 
inner join Detalle_Compra dc on dc.Id_Compra = c.Id_Compra
inner join Proveedores p on p.Id_Prov = c.Id_Prov
group by c.Id_Compra, p.NombreProv, c.TotalCompra, c.Fecha_Compra
go

 select * from Comprasporproveedor

select * from Proveedores

select * from Ventasporcliente

--Ventas por Clientes
create view Ventasporcliente
as
select c.PNombre, c.PApell, v.NVenta,v.totalv,v.Fecha_Venta  from Clientes c  
inner join Ventas v on c.Id_cliente = v.Id_cliente


-- Reporte ER

alter proc ReportER
as
declare @totalv as float
declare @totalc as float
declare @dev as float
declare @comprasT as float
declare @comprasN as float
declare @utbruta as float
set @totalv = (select sum(totalv ) as IngresoVenta from Ventas)
set @totalc= (select SUM(TotalCompra) as CostoVenta from Compras)
set @dev= (select SUM(TotalD) as DevolucionesC from Devoluciones)
set @comprasT= @totalc
set @comprasN= @totalc-@dev
set @utbruta= @totalv-@comprasN

select @totalv as IngresoVenta, @comprasT as ComprasTotales, @dev as DevolucionesSC, @comprasN as ComprasNetas, @utbruta as UtilidadBruta
go
