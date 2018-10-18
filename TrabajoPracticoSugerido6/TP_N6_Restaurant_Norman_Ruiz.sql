/*
Universisas Tecnologica Nacional
General pacheco
Laboratorio de Computacioon III
Profesor: Angel Simon
Año 2018
Segundo cuatrimestre
Turno Noche
Alumno Norman Ruiz
Trabajo Practico Nº6
*/

GO
USE TP_SUGERIDO_6;

--A - Obtener el listado de ingredientes y las cantidades necesarias, que componen la receta con ID 
--    nro 1. 

select i.INGREDIENTE as Ingrediente, IXP.CANTIDAD as Cantidad, U.UNIDAD as Unidad 
from ingredientes as i
inner join INGREDIENTES_X_PLATO as IXP on IXP.IDINGREDIENTE = i.IDINGREDIENTE
inner join UNIDADES as u on u.IDUNIDAD = IXP.IDUNIDAD
where IXP.IDPLATO = 1

-- B - Obtener el total facturado del día de ayer. 

select sum(IMPORTE)
from PLATOS_X_PEDIDO
where convert(nvarchar(29), FECHAHORA_INICIO, 130) = convert(nvarchar(20), getdate()-1, 103) -- Esta linea fue casi por completo copiada de Simon, no la sacaba solo ni ahi

-- C - Obtener un ranking con las diez recetas más solicitadas por los clientes. 

select top 10 p.DESCRIPCION as 'Top Ten 10 Platos mas pedidos', count(PXP.IDPLATO) as 'Cantidad Pedidas'
from platos as p
inner join PLATOS_X_PEDIDO as PXP on PXP.IDPLATO = p.IDPLATO
group by p.DESCRIPCION
order by 2 desc

-- D - Realizar una vista que permita visualizar para cada receta el nombre y el tiempo estimado de 
--     elaboración, además incorporarle el tiempo promedio de elaboración real (surge de la espera de 
--     cada pedido). 

create view VW_Ejercicio_D AS
select p.DESCRIPCION as Descripcion, p.TIEMPO as 'Tiempo estimado de elaboracion',
(select avg(datediff(MINUTE,PXP.FECHAHORA_INICIO,PXP.FECHAHORA_FIN)* 1.0) from PLATOS_X_PEDIDO as PXP group by PXP.IDPLATO having PXP.IDPLATO = p.IDPLATO) as 'Tiempo promedio real de elaboracion' -- ver con Simon, me dio lo mismo pero no se si esta bien porque use group by y el no 
from PLATOS as p

select * from VW_Ejercicio_D

-- E - Obtener el valor que debe cobrar el mozo con ID nro 1 durante el mes de mayo de 2012 en 
--     concepto de comisiones. 


select m.APELLIDO as Apellido, m.NOMBRE as Nombre, sum(pxp.IMPORTE * m.comision) as Comision
from PLATOS_X_PEDIDO as pxp
inner join pedidos as p on p.IDPEDIDO = pxp.IDPEDIDO
inner join mozos as m on m.IDMOZO = p.IDMOZO
where m.IDMOZO = 1 and MONTH(pxp.FECHAHORA_INICIO) = 5 and year(pxp.FECHAHORA_INICIO) = 2012 
group by m.APELLIDO, m.NOMBRE

-- F - La cantidad de platos por categoría de plato. 

select c.CATEGORIA,
(select count(p.IDPLATO) from platos as p where p.IDCATEGORIA = c.IDCATEGORIA) as 'Cantidadde platos'
from categorias as c

-- G - Obtener un listado de los cinco platos más sencillos de hacer. (tener en cuenta la dificultad de 
--     la preparación) 

select top 5 with ties *
from platos as p
order by p.DIFICULTAD asc

