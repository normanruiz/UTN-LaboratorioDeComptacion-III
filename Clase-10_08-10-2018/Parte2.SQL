-- SOLUCION.SQL

/*
1) - Por cada vecino, listar el apellido y nombre, tipo de propiedad, domicilio,
porcentaje de superficie construida (sobre el total), valor de la propiedad
y antiguedad. Sólo listar registros de propiedades de costo mayor a un millón de pesos
o que tengan menos de 5 años de antigüedad. (10 puntos)
*/

select v.APELLIDOS as Apellido, v.NOMBRES as Normbre, t.TIPO as 'Tipo de propiedad', p.DOMICILIO as Domicilio, (p.SUPERFICIE_CONSTRUIDA *100)/p.SUPERFICIE as 'Porcentaje Sup. Construida' , p.VALOR as Valor, p.ANTIGUEDAD as Antiguedad
from VECINOS as v
inner join PROPIEDADES as p on p.DNI = v.DNI
inner join TIPOS_PROPIEDADES as t on t.ID = p.IDTIPO
where p.VALOR > 1000000 or p.ANTIGUEDAD < 5

/*
2) - Listar todos los datos de los vecinos que no tengan propiedades de más de 
80m2 de superficie construida. (20 puntos)
*/

select *
from VECINOS as v
where v.DNI not in(select p.DNI from propiedades as p where p.SUPERFICIE_CONSTRUIDA > 80)

/*
3) - Listar por cada vecino el apellido y nombres, la cantidad de propiedades 
sin superficie construida y la cantidad de propiedades con superficie construida que posee.
(25 puntos)
*/

select v.APELLIDOS as Apellido, v.NOMBRES as Nombre, 
isnull((select count(p.DNI) as 'Cant' from PROPIEDADES as p where p.SUPERFICIE_CONSTRUIDA = 0 and v.DNI = p.DNI group by p.DNI),0) as 'S/S Construida',
isnull((select count(p.DNI) as 'Cant' from PROPIEDADES as p where p.SUPERFICIE_CONSTRUIDA > 0 and v.DNI = p.DNI group by p.DNI),0) as 'C/S Construida'
from vecinos as v

/*
4) - Listar por cada tipo de propiedad el valor promedio. Sólo listar aquellos
registros cuyo valor promedio supere los $900000.
(15 puntos)
*/

select t.TIPO as 'Tipo de propiedad', avg(p.VALOR) as 'Valor promedio'
from TIPOS_PROPIEDADES as t
left join PROPIEDADES as p on p.IDTIPO = t.ID
group by t.TIPO
having  avg(p.VALOR) > 900000

/*
5) - Por cada vecino, listar apellido y nombres y el total acumulado en concepto de propiedades. 
Si un vecino no posee propiedades deberá figurar acumulando 0. (15 puntos)
*/

select v.APELLIDOS as Apellido, v.NOMBRES as Nombre, 
isnull((select sum(p.VALOR) from PROPIEDADES as p where v.DNI = p.DNI group by p.DNI),0) as 'Total acumulado en concepto de propiedades'
from VECINOS as v
