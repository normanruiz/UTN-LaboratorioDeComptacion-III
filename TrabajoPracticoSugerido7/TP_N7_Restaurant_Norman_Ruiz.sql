/*
Universisas Tecnologica Nacional
General pacheco
Laboratorio de Computacioon III
Profesor: Angel Simon
Año 2018
Segundo cuatrimestre
Turno Noche
Alumno Norman Ruiz
Trabajo Practico Nº7
*/

GO
USE TP_SUGERIDO_7;

-- A) - Realizar un procedimiento almacenado que permita conocer el listado de ingredientes y sus 
--      respectivas cantidades y unidades de medida. Se deberá enviar el código de receta. 
go -- drop procedure sp_punto_a
create procedure sp_punto_a(
@idPlato int
)
as
begin
select p.DESCRIPCION as Descripcion, ixp.CANTIDAD as Cantidad, u.UNIDAD as Unidad, i.INGREDIENTE as Ingrediente
from PLATOS as p
inner join INGREDIENTES_X_PLATO as ixp on ixp.IDPLATO = p.IDPLATO
inner join INGREDIENTES as i on i.IDINGREDIENTE = ixp.IDINGREDIENTE
inner join UNIDADES as u on u.IDUNIDAD = ixp.IDUNIDAD
where p.IDPLATO = @idPlato
end

exec sp_punto_a 1

-- B) - Realizar un procedimiento almacenado que permita conocer a partir de un código de 
--      producto los datos de los proveedores que lo venden. Ordenado de menor a mayor por tiempo 
--      de envío.
go -- drop procedure sp_punto_b
create procedure sp_punto_b(
@idIngrediente int
)
as
begin
select i.INGREDIENTE as Ingrediente, p.*, ixp.TIEMPO_ESPERA as 'Demora de entrega'
from ingredientes as i
join INGREDIENTES_X_PROVEEDOR as ixp on ixp.IDINGREDIENTE = i.IDINGREDIENTE
inner join PROVEEDORES as p on p.IDPROVEEDOR = ixp.IDPROVEEDOR
inner join RUBROS_X_PROVEEDOR as rxp on rxp.IDPROVEEDOR = p.IDPROVEEDOR
where i.IDINGREDIENTE = @idIngrediente
order by ixp.TIEMPO_ESPERA asc
end

exec sp_punto_b 1


-- C) - Realizar un procedimiento almacenado que permita ingresar un plato. 
go
create procedure sp_punto_c(
@DESCRIPCION varchar(50), 
@TIEMPO SMALLINT, 
@DIFICULTAD decimal, 
@VALOR decimal, 
@IDCATEGORIA int
)
as
begin
declare @id int
set @id = (select max(p.IDPLATO) + 1 from platos as p)
INSERT INTO PLATOS (IDPLATO, DESCRIPCION, TIEMPO, DIFICULTAD, VALOR, IDCATEGORIA) 
VALUES(@id, @DESCRIPCION, @TIEMPO, @DIFICULTAD, @VALOR, @IDCATEGORIA);
end

exec sp_punto_c 'Pollo al horno con papa', 45, 6, 120, 1

-- D) - Realizar un procedimiento almacenado que permita conocer el total facturado de un día que 
--      se envía como parámetro. 
go -- drop procedure sp_punto_d
create procedure sp_punto_d(
@fecha date
)
as
begin
select isnull(sum(pxp.IMPORTE),0) as 'Total factura'
from PLATOS_X_PEDIDO as pxp
where day(pxp.FECHAHORA_INICIO) = day(@fecha) and  month(pxp.FECHAHORA_INICIO) = month(@fecha) and  year(pxp.FECHAHORA_INICIO) = year(@fecha)
end

exec sp_punto_d '1980/04/02'

-- E) - Realizar un procedimiento almacenado que permita conocer el total de horas trabajadas por 
--      un Chef en un mes. Se deberá ingresar el código de chef, el mes y año. 
go -- drop procedure sp_punto_e
create procedure sp_punto_e(
@idChef int,
@mes int,
@year int
)
as
begin
select c.APELLIDO as Apellido, c.NOMBRE as Nombre,
concat((DATEDIFF(hour,dc.FECHAHORA_ENTRADA,dc.FECHAHORA_SALIDA)), ':' ,(DATEDIFF(minute,dc.FECHAHORA_ENTRADA,dc.FECHAHORA_SALIDA)%60)) as 'Cantidad de horas trabajadas'
from DIA_CHEF as dc
inner join CHEFS as c on c.IDCHEF = dc.IDCHEF
where dc.IDCHEF = @idChef
end

exec sp_punto_e 1, 5, 17

-- F) - Realizar un procedimiento almacenado que actualice el tiempo promedio de elaboración de 
--      todos los platos, al valor calculado por el promedio de demora de los pedidos de cada plato en la 
--      realidad. 

go -- drop procedure sp_punto_f
create procedure sp_punto_f
as
begin
update platos set TIEMPO = ISNULL((select avg(datediff(MINUTE,PXP.FECHAHORA_INICIO,PXP.FECHAHORA_FIN)* 1.0) from PLATOS_X_PEDIDO as PXP group by PXP.IDPLATO having PXP.IDPLATO = PLATOS.IDPLATO),0)
select * from PLATOS as p
end

exec sp_punto_f