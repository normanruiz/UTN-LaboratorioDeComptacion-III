/*
Universisas Tecnologica Nacional
General pacheco
Laboratorio de Computacioon III
Profesor: Angel Simon
A�o 2018
Segundo cuatrimestre
Turno Noche
Alumno Norman Ruiz
Trabajo Practico Nº4
*/

 /*
Consultas de selección y JOINS 
 
El siguiente ejercicio tiene como objetivo poner en práctica los conceptos de selección y el uso 
de consultas que obtengan datos de diferentes tablas utilizando JOINS. 
 
Para ello se utilizará la base de datos creada en el Trabajo práctico sugerido N° 2 y se le 
incorporarán los datos que figuran en el Trabajo práctico sugerido N° 3. 
*/

go
use bd_TPS2;

-- A) Obtener un listado de actores que muestre el Apellido y nombre  separados por una coma en 
--    la misma columna, edad y nombre del país donde nació. 
select (a.trs_apellido + ',' + a.trs_nombre) as Actor,
DATEDIFF(year, trs_fecNacimiento,GETDATE()) as Edad,
p.pss_pais as 'Pais de origen'
from actores as a
inner join paises as p on p.pss_id = a.trs_idPais

-- B) Obtener para cada actor su nombre y apellido y los nombres de las películas en las que actuó. 
select a.trs_apellido as Apellido,
a.trs_nombre as Nombre,
p.pls_titulo as Pelicula
from actores as a
inner join actoresXpelicula as axp on axp.axp_idActores = a.trs_codActor
inner join peliculas as p on p.pls_codPelicula = axp.axp_idPelicula

-- C) Obtener para cada película su título y el nombre y apellido de los actores que participaron en 
--    ella. 
select p.pls_titulo as 'Titulo de la Pelicula',
(a.trs_apellido + ',' + a.trs_nombre) as Protagonista
from peliculas as p
inner join actoresXpelicula as axp on axp.axp_idPelicula = p.pls_codPelicula
inner join actores as a on a.trs_codActor = axp.axp_idActores

-- D) Obtener para cada película su código, título, nombre de país de realización, saldo (ganancia o 
--    pérdida), nombre de género, nombre de calificación y puntaje. 
select pl.pls_codPelicula as Codigo,
pl.pls_titulo as Titulo,
ps.pss_pais as Origen,
(pl.pls_recaudacion - pl.pls_inversion) Saldo,
gn.gnr_genero as Genero,
cl.cfn_calificacion as Calificacion,
pl.pls_critica as Puntaje
from peliculas as pl
inner join paises as ps on ps.pss_id = pl.pls_idPssRealizacion
inner join generos as gn on gn.gnr_id = pl.pls_idGenero
inner join calificaciones as cl on cl.cfn_id = pl.pls_calificacion

-- E) Obtener los países en los que se haya realizado alguna película (no tener en cuenta aquellos 
--    países en los que no se realizó alguna película). 


-- F) Obtener el título de las películas y el país de realización. Incluir los países que no tienen alguna 
--    película asociada completando con NULL el campo reservado para el título de película. 


-- G) Obtener para cada actor su nombre y apellido y además el/los géneros de película en que haya 
--    participado. Si ocurriese que un mismo actor haya participado en más de una película del mismo 
--    género, esta combinación debe aparecer sólo una vez. 


-- H) Obtener un listado que contenga Apellido y nombre, fecha de nacimiento, título de película, 
--    fecha de estreno y la edad que tenía el actor al momento del estreno de la película. 

