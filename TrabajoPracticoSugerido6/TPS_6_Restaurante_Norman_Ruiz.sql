/*
Universisas Tecnologica Nacional
General pacheco
Laboratorio de Computacioon III
Profesor: Angel Simon
A�o 2018
Segundo cuatrimestre
Turno Noche
Alumno Norman Ruiz
Trabajo Practico Sugerido Nº6
*/


--Consultas 
go
 USE TP_SUGERIDO_6;

-- A - Obtener el listado de ingredientes y las cantidades necesarias, que componen la receta con ID nro 1.
go
create view vw_Punto_a
as
select i.INGREDIENTE as Ingrediente, u.UNIDAD as Unidad, ixp.CANTIDAD as Cantidad
from INGREDIENTES as i
inner join INGREDIENTES_X_PLATO as ixp on ixp.IDINGREDIENTE = i.IDINGREDIENTE
inner join UNIDADES as u on u.IDUNIDAD = ixp.IDUNIDAD
where ixp.IDPLATO = 1

go
select * from vw_Punto_A

-- B - Obtener el total facturado del día de ayer.
go
create view vw_Punto_B
as
select isnull(sum(pxp.IMPORTE),0) as 'Total recaudado el dia de ayer'
from PLATOS_X_PEDIDO as pxp
where pxp.FECHAHORA_INICIO = (GETDATE() -1 )

go
select * from vw_Punto_B

-- C - Obtener un ranking con las diez recetas más solicitadas por los clientes. 
go
create view vw_Punto_C
as
select top 10 with ties p.DESCRIPCION as Plato, count(pxp.IDPLATO) as 'Cantidad de pedidos' 
from PLATOS_X_PEDIDO as pxp
inner join PLATOS as p on p.IDPLATO = pxp.IDPLATO
group by p.DESCRIPCION, pxp.IDPLATO
order by 2 desc

select * from PLATOS_X_PEDIDO
go

-- D - Realizar una vista que permita visualizar para cada receta el nombre y el tiempo estimado de 
--     elaboración, además incorporarle el tiempo promedio de elaboración real (surge de la espera de cada pedido). 
go
create view vw_Punto_D
as
select p.DESCRIPCION as Descripcion, p.TIEMPO as 'Tiempo estimado de elaboracion',
(select avg(datediff(MINUTE,PXP.FECHAHORA_INICIO,PXP.FECHAHORA_FIN)* 1.0) from PLATOS_X_PEDIDO as PXP group by PXP.IDPLATO having PXP.IDPLATO = p.IDPLATO) as 'Tiempo promedio real de elaboracion' -- ver con Simon, me dio lo mismo pero no se si esta bien porque use group by y el no 
from PLATOS as p

go
select * from vw_Punto_D

-- E - Obtener el valor que debe cobrar el mozo con ID nro 1 durante el mes de mayo de 2012 en concepto de comisiones. 
go
create view vw_Punto_E
as
select sum(pxp.IMPORTE) as 'Caja Mozo 1'
from PLATOS_X_PEDIDO as pxp
inner join PEDIDOS as p on p.IDPEDIDO = pxp.IDPEDIDO
where p.IDMOZO = 1

go
select * from vw_Punto_E

-- F - La cantidad de platos por categoría de plato. 
go
create view vw_Punto_F
as
select c.CATEGORIA as Categoria,
(select count(IDPLATO) from platos where IDCATEGORIA = c.IDCATEGORIA) as 'Cantidad de platos'
from categorias as c
inner join platos as p on p.IDCATEGORIA = c.IDCATEGORIA

go
select * from vw_Punto_F

-- G - Obtener un listado de los cinco platos más sencillos de hacer. (tener en cuenta la dificultad de la preparación) 
 go
create view vw_Punto_G
as
select top 5 *
from platos as p
order by p.DIFICULTAD asc 

go
select * from vw_Punto_G
 
