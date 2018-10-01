/*
Universisas Tecnologica Nacional
General pacheco
Laboratorio de Computacioon III
Profesor: Angel Simon
A�o 2018
Segundo cuatrimestre
Turno Noche
Alumno Norman Ruiz
Trabajo Practico Integrador Consulta de selecion
*/

-- A) Listar todos los m�dicos de sexo femenino.

select * 
from medicos
where sexo = 'F'

-- B) Listar todos los m�dicos cuyo apellido finaliza con 'EZ'

select * 
from medicos
where apellido like '%EZ'

-- C) Listar todos los m�dicos que hayan ingresado a la cl�nica entre el 1/1/1995 y el 31/12/1999.

select *
from medicos
where fechaingreso between '1995/01/01' and '1999/12/31'

-- D) Listar todos los m�dicos que tengan un costo de consulta mayor a $ 650.

select *
from medicos
where costo_consulta > 650

-- E) Listar todos los m�dicos que tengan una antig�edad mayor a 10 a�os.

select *
from medicos
where year(getdate()) - year(fechaingreso) > 10 

-- F) Listar todos los pacientes que posean la Obra social 'Dasuten'.

select *
from pacientes
where idobrasocial = 4

select p.*
from pacientes as p
left join obras_sociales as os on os.IDOBRASOCIAL = p.IDOBRASOCIAL
where os.NOMBRE = 'Dasuten' 

-- G) Listar todos los pacientes que hayan nacido en los meses de Enero, Febrero o Marzo.

select *
from pacientes
where month(fechanac) in ('1','2','3') 

-- H) Listar todos los pacientes que hayan tenido alg�n turno m�dico en los �ltimos 45 d�as.

select p.*
from pacientes as p
inner join turnos as t on t.idpaciente = p.idpaciente
where datediff(day,t.FECHAHORA,getdate()) < 45

-- I) Listar todos los pacientes que hayan tenido alg�n turno con alg�n m�dico con especialidad 
--    'Gastroenterolog�a'.

select p.*
from pacientes as p
inner join turnos as t on p.idpaciente = t.idpaciente
inner join medicos as m on m.idmedico = t.idmedico 
inner join especialidades as e on e.idespecialidad = m.idespecialidad
where e.nombre = 'Gastroenterolog�a'

-- J) Listar Apellido, nombre, sexo y especialidad de todos los m�dicos que tengan especialidad 
--    en alg�n tipo de 'An�lisis'

select m.apellido, m.nombre, m.sexo, e.nombre as Especialidad
from medicos as m
inner join especialidades as e on e.idespecialidad = m.idespecialidad
where e.nombre like '%An�lisis%'
      
-- K) Listar Apellido, nombre, sexo y especialidad de todos los m�dicos que no posean la especialidad 
--    'Gastroenterolog�a', 'Oftalmolog�a', 'Pediatr�a', 'Ginecolog�a' ni 'Oncolog�a'.

select m.apellido, m.nombre, m.sexo, e.nombre as Especialidad
from medicos as m
inner join especialidades as e on e.idespecialidad = m.idespecialidad
where e.nombre not in ('Gastroenterolog�a', 'Oftalmolog�a', 'Pediatr�a', 'Ginecolog�a' , 'Oncolog�a')

-- L) Listar por cada turno, la fecha y hora, nombre y apellido del m�dico, nombre y apellido del
--    paciente, especialidad del m�dico, duraci�n del turno, costo de la consulta sin descuento, obra
--    social del paciente y costo de la consulta con descuento de la obra social. Ordenar el listado de
--    forma cronol�gica. Del �ltimo turno al primero.

select t.FECHAHORA as 'Fecha y hora', m.apellido as Apellido, m.nombre as Normbre, e.NOMBRE as Especialidad, t.DURACION as 'Duracion del turno', m.COSTO_CONSULTA as 'Costo S/Descuento', o.NOMBRE as 'Obra social', m.COSTO_CONSULTA - (m.COSTO_CONSULTA * o.COBERTURA) as 'Costo C/Descuento' 
from turnos as t
inner join medicos as m on m.IDMEDICO = t.IDMEDICO
inner join especialidades as e on e.IDESPECIALIDAD = m.IDESPECIALIDAD
inner join PACIENTES as p on p.IDPACIENTE = t.IDPACIENTE
inner join OBRAS_SOCIALES as o on o.IDOBRASOCIAL = p.IDOBRASOCIAL
order by t.FECHAHORA desc

-- M) Listar todos los pacientes que no se hayan atendido con ning�n m�dico.

select * 
from pacientes 
where idpaciente not in (select distinct idpaciente from turnos)

-- N) Listar por cada a�o, mes y paciente la cantidad de turnos solicitados.  Del paciente mostrar Apellido y nombre.

select year(t.FECHAHORA) as A�o, month(t.FECHAHORA) as Mes, p.apellido as Apellido, p.nombre as Nombre, count (*) as 'Cantidad de turnos'  
from turnos as t
inner join pacientes as p on p.IDPACIENTE = t.IDPACIENTE
group by year(t.FECHAHORA), month(t.FECHAHORA), p.apellido, p.nombre

-- �) Listar el/los paciente que haya tenido el turno con mayor duraci�n.

select top 1 with ties p.*, t.DURACION as 'Duracion del turno'
from turnos as t
inner join pacientes as p on p.idpaciente = t.IDPACIENTE 
order by t.duracion desc

-- O) Listar el promedio de duraci�n de un turno que pertenezcan a m�dicos con  especialidad 'Pediatr�a'.

select m.apellido as 'Apellido del mecico', e.NOMBRE as Especialidad, avg(t.DURACION) as 'Duracion del turno'
from turnos as t
inner join medicos as m on m.IDMEDICO = t.IDMEDICO
inner join ESPECIALIDADES as e on e.IDESPECIALIDAD = m.IDESPECIALIDAD
group by m.APELLIDO, e.NOMBRE
having e.NOMBRE like 'Pediatr�a'

-- P) Listar por cada m�dico, el total facturado (sin descuentos) agrupado por a�o.  Listar apellido
--    y nombre del m�dico.

select m.APELLIDO as Apellido, m.NOMBRE as Nombre, year(t.FECHAHORA) as A�o, sum(m.COSTO_CONSULTA) as 'Total S/Descuento'  
from turnos as t
inner join medicos as m on m.IDMEDICO = t.IDMEDICO
group by m.APELLIDO, m.NOMBRE, year(t.FECHAHORA)
order by a�o desc

-- Q) Listar por cada especialidad la cantidad de turnos que se solicitaron en total. Listar nombre
--    de la especialidad.

select e.NOMBRE as Especialidad, count(e.IDESPECIALIDAD) as 'Cantidad de turnos'
from ESPECIALIDADES as e
left join medicos as m on m.IDESPECIALIDAD = e.IDESPECIALIDAD
left join turnos as t on t.IDMEDICO = m.IDMEDICO
group by e.NOMBRE

-- R) Listar por cada obra social, la cantidad de turnos

select os.NOMBRE, count(t.IDPACIENTE) as 'Cantidad de turnos'
from OBRAS_SOCIALES as os
left join PACIENTES as p on p.IDOBRASOCIAL = os.IDOBRASOCIAL
left join turnos as t on t.IDPACIENTE = p.IDPACIENTE
group by os.NOMBRE

-- S) Listar todos los m�dicos que nunca atendieron a pacientes con Obra Social 'Dasuten'.

select m.apellido as Apellido, m.nombre as Nombre, os.NOMBRE as 'Obra atendida'
from MEDICOS as m
left join turnos as t on t.IDMEDICO = m.IDMEDICO
left join pacientes as p on p.IDPACIENTE = t.IDPACIENTE
left join OBRAS_SOCIALES as os on os.IDOBRASOCIAL = p.IDOBRASOCIAL
group by m.apellido, m.nombre, os.NOMBRE
having os.nombre not like 'Dasuten'

-- T) Listar todos los pacientes que no se atendieron durante todo el a�o 2015.

select distinct p.APELLIDO as Apellido, p.NOMBRE as Nombre
from turnos as t
right join PACIENTES as p on p.IDPACIENTE = t.IDPACIENTE
where year(t.FECHAHORA) != 2015

-- U) Listar para cada paciente la cantidad de turnos solicitados con m�dicos que realizan
--    "An�lisis" y la cantidad de turnos solicitados  con m�dicos de otras especialidades.


















-- V) Listar todos los m�dicos que no atendieron nunca por la ma�ana. Horario de 08:00 a 12:00.

select * 
from medicos as m
where m.IDMEDICO not in (select t.IDMEDICO from turnos as t where datepart(hour,t.FECHAHORA) between 8 and 12)

-- W) Listar el paciente que m�s veces se atendi� para una misma especialidad.













-- X) Listar las obras sociales que tengan m�s de 10 afiliados en la cl�nica.

select os.NOMBRE as Nombre, (select count(p.IDPACIENTE) as Cantidad from pacientes as p where p.IDOBRASOCIAL = os.IDOBRASOCIAL group by p.IDOBRASOCIAL) as 'Cantidad de afiliados'
from OBRAS_SOCIALES as os
where (select count(p.IDPACIENTE) as Cantidad from pacientes as p where p.IDOBRASOCIAL = os.IDOBRASOCIAL group by p.IDOBRASOCIAL) > 10

-- Y) Listar todos los pacientes que se hayan atendido con m�dicos de otras especialidades  pero
--    no se hayan atendido con m�dicos que realizan "An�lisis".

select *
from PACIENTES as p
where p.IDPACIENTE in(select t.IDPACIENTE from turnos as t inner join medicos as m on m.IDMEDICO = t.IDMEDICO inner join ESPECIALIDADES as e on e.IDESPECIALIDAD = m.IDESPECIALIDAD where e.NOMBRE not like '%An�lisis%')

-- Z) Listar todos los pacientes cuyo promedio de duraci�n por turno sea mayor a 20 minutos.

select distinct *
from pacientes as p
where p.IDPACIENTE in(select t.IDPACIENTE from turnos as t where t.DURACION >20)

