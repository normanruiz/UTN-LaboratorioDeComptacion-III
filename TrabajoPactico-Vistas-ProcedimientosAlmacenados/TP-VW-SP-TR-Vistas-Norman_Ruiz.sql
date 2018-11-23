/*
Universisas Tecnologica Nacional
General pacheco
Laboratorio de Computacioon III
Profesor: Angel Simon
Año 2018
Segundo cuatrimestre
Turno Noche
Alumno Norman Ruiz
Trabajo Practico Vistas Procedimientos almacenados Triggers
*/

use db_sube;

-- Vistas 
 
-- Realizar las siguientes vistas: 
 
/*
A) Realizar una vista que permita conocer los datos de los usuarios y sus respectivas tarjetas. La 
misma debe contener: Apellido y nombre del usuario, número de tarjeta SUBE, estado de la 
tarjeta y saldo. 
 */
go
create view vw_punto_a
as
select u.apellido as Apellido, u.nombre as Nombre, t.num_tarjeta as Tajeta, t.estado as Estado, u.saldo_ultima as Saldo
from usuarios as u
inner join tarjetas as t on t.idUsuario = u.id

go
select * from  vw_punto_a

/*
B) Realizar una vista que permita conocer los datos de los usuarios y sus respectivos viajes. La 
misma debe contener: Apellido y nombre del usuario, número de tarjeta SUBE, fecha del viaje, 
importe del viaje, número de interno y nombre de la línea. 
*/

go
create view vw_punto_b
as
select u.apellido as Apellido, u.nombre as Nombre, t.num_tarjeta as Tarjeta, v.fecha_hora as 'Fecha del viaje', v.importe as Importe, 
i.num_interno as 'Numero de interno', l.nombre_empresa as Empresa
from usuarios as u
inner join tarjetas as t on t.idUsuario = u.id
inner join viajes  as v on v.idtarjeta = t.id
inner join internos as i on i.id = v.idInterno
inner join lineasDeColectivos as l on l.id = i.idLinea


go
select * from vw_punto_b

 /*
C) Realizar una vista que permita conocer los datos estadísticos de cada tarjeta. La misma debe 
contener: Apellido y nombre del usuario, número de tarjeta SUBE, cantidad de viajes realizados, 
total de dinero acreditado (históricamente), cantidad de recargas, importe de recarga promedio 
(en pesos), estado de la tarjeta. 
*/
go
create view vw_punto_c
as
select u.apellido as Apellido, u.nombre as Nombre, t.num_tarjeta as Tarjeta,
(select count(v.idtarjeta) as Cantidad from viajes as v where v.idtarjeta = t.id) as 'Cantidad de viajes',
(select isnull(sum(r.importe),0) as Total from registros as r where r.tipo_movimiento = 'C' and r.idtarjeta = t.id) as 'Total Acreditado',
(select count(r.tipo_movimiento) as Cantidad from registros as r where r.tipo_movimiento = 'C' and r.idtarjeta = t.id) as 'Cantidad de recargas',
(select isnull(avg(r.importe),0) as Total from registros as r where r.tipo_movimiento = 'C' and r.idtarjeta = t.id) as 'Importe de recarga promedio', 
t.estado as Estado
from usuarios as u
inner join tarjetas as t on t.idUsuario = u.id

go
select * from vw_punto_c
