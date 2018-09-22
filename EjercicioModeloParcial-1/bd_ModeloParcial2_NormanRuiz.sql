--Consultas
-- A) El ganador del torneo es aquel que haya capturado el pez más pesado entre todos los
--    peces siempre y cuando se trate de un pez registrado por los jueces del torneo. Puede haber
--    más de un ganador del torneo. Listar Apellido y nombre, especie de pez que capturó y el
--    pesaje del mismo. (5 puntos)

select top 1 pes.PESO, pes.IDESPECIE, par.apellido, par.nombre
from pesca as pes
inner join participantes as par on par.IDPARTICIPANTE = pes.idparticipante  
where pes.IDESPECIE is not null
order by pes.PESO desc

-- B) Listar todos los participantes que no hayan pescado ningún tipo de bagre. (ninguna
--    especie cuyo nombre contenga la palabra "bagre"). Listar apellido y nombre. (10 puntos)
go
select distinct par.apellido, par.nombre
from participantes as par
left join pesca as pes on pes.IDPARTICIPANTE = par.IDPARTICIPANTE
left join especies as esp on esp.IDESPECIE = pes.IDESPECIE
where esp.ESPECIE not like '%bagre%'

-- C) Listar los participantes cuyo promedio de pesca (en kilos) sea mayor a 30. Listar apellido,
--    nombre y promedio de kilos. ATENCIÓN: No tener en cuenta los peces no registrados. (15 puntos)
go
select par.apellido, par.nombre, avg(pes.peso) as promedio
from participantes as par
inner join pesca as pes on pes.idparticipante = par.idparticipante
group by par.idparticipante, par.apellido, par.nombre
having avg(pes.peso) > 30

-- D) Por cada especie listar la cantidad de veces que han sido capturadas por un pescador
--    durante la noche. (Se tiene en cuenta a la noche como el horario de la competencia entre las
--    21pm y las 5am -ámbas inclusive-) (20 puntos)

select e.IDESPECIE, e.ESPECIE, count(p.IDESPECIE) as cant
from ESPECIES as e
left join pesca as p on p.IDESPECIE = e.IDESPECIE
where (DATEPART(hour,p.FECHA_HORA)>=21) or (DATEPART(hour,p.FECHA_HORA)<=05)
group by e.IDESPECIE, e.ESPECIE


-- E) Listar apellido, nombre y edad de aquellos participantes de sexo masculino menores a 35
--    años que hayan pescado al menos un pez no registrado. Un participante deberá aparecer una
--    vez en este listado. (10 puntos)

select distinct par.APELLIDO, par.NOMBRE, DATEDIFF(year, 0, getdate()-par.FECHA_NACIMIENTO) as edad
from PARTICIPANTES as par
left join pesca as pes on pes.IDPARTICIPANTE = par.IDPARTICIPANTE
where par.SEXO = 'm' and datediff(year,0,getdate()-par.FECHA_NACIMIENTO) < 35 and (select count(*) from pesca where IDESPECIE is null) >=1

-- F) Listar apellido y nombre del participante y nombre de la especie de cada pez que haya
--    capturado el pescador/a. Si alguna especie de pez no ha sido pescado nunca entonces
--    deberá aperecer en el listado de todas formas pero sin relacionarse con ningún pescador. El
--    listado debe aparecer ordenado por nombre de especie de manera creciente. La
--    combinación apellido y nombre y nombre de la especie debe aparecer sólo una vez este
--    listado. (10 puntos)

select par.apellido as Apellido, par.nombre as Nombre, esp.ESPECIE as 'Nombre de la Especie'
from ESPECIES as esp
left join pesca as pes on pes.IDESPECIE = esp.IDESPECIE
left join PARTICIPANTES as par on par.IDPARTICIPANTE = pes.IDPARTICIPANTE
order by esp.ESPECIE

