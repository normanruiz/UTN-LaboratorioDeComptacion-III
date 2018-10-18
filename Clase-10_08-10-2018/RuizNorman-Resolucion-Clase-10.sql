-- PRIMERA PARTE DE LA CLASE
--------------------------------
-- Por cada tipo de propiedad, la cantidad de vecinos distintos que poseen propiedades de dicho tipo.

select tp.TIPO as 'Tipo de propiedad',
isnull((select count(distinct p.DNI) as cantidad from PROPIEDADES as p where p.IDTIPO = tp.ID group by p.IDTIPO),0) as 'Cantidad de vecinos'
from TIPOS_PROPIEDADES as tp

-- Por cada tipo de propiedad, la cantidad de vecinos que poseen propiedades de dicho tipo.

select tp.TIPO as 'Tipo de propiedad',
isnull((select count(p.DNI) as cantidad from PROPIEDADES as p where p.IDTIPO = tp.ID group by p.IDTIPO),0) as 'Cantidad de vecinos'
from TIPOS_PROPIEDADES as tp

-- Listar apellido y nombres de los vecinos que tengan m�s de una propiedad sin superficie construida (superficie construida igual a cero)

select v.APELLIDOS as Apellido, v.NOMBRES as Nombre
from vecinos as v
where v.DNI in (select p.DNI from PROPIEDADES as p where p.SUPERFICIE_CONSTRUIDA = 0 group by p.DNI having count(p.DNI) > 1)

-- Listar apellido y nombres de los vecinos que tengan alguna propiedad con superficie construida y 
-- ninguna propiedad sin superficie construida

select v.APELLIDOS as Apellido, v.NOMBRES as Nombre
from vecinos as v
where v.DNI = any(select p.DNI from PROPIEDADES as p where p.SUPERFICIE_CONSTRUIDA <> 0) and v.dni not in(select p.DNI from PROPIEDADES as p where p.SUPERFICIE_CONSTRUIDA = 0)

-- Listar el vecino que disponga de la casa con mayor valor por m2.



-- Para cada vecino, listar apellido y nombre y la antig�edad menor de sus propiedades. Si un vecino no tiene
-- propiedades registradas, listar una antig�edad con valor NULL.



-- A todos los vecinos cuya sumatoria de valuaci�n de todas sus propiedades sea mayor a $4.000.000 y
-- posean m�s de una propiedad se le aplicar� un impuesto del 5% del valor de sus propiedades 
-- (a excepci�n del valor de su propiedad m�s cara).
-- Listar apellido y nombre de los vecinos que deban pagar el impuesto y cu�nto deber�n pagar.


