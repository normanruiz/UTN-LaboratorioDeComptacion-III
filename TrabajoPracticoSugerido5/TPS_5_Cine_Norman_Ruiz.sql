/*
Universisas Tecnologica Nacional
General pacheco
Laboratorio de Computacioon III
Profesor: Angel Simon
A�o 2018
Segundo cuatrimestre
Turno Noche
Alumno Norman Ruiz
Trabajo Practico Sugerido Nº5
*/

/*
Consultas de selección y funciones de agregado 
 
El siguiente ejercicio tiene como objetivo poner en práctica los conceptos de selección y el uso 
de consultas que obtengan datos de diferentes tablas utilizando JOINS. Además se aplicará el 
uso de funciones de agregado para resumir información. 
 
Para ello se utilizará la base de datos creada en el Trabajo práctico sugerido N° 2 y se le 
incorporarán los datos que figuran en el Trabajo práctico sugerido N° 3. 
*/

-- A) Hacer un listado que permita conocer el total recaudado agrupado por año. Se deberá mostrar 
--    año y total recaudado. 
select year(pl.pls_fecEstreno) as Año,
sum(pl.pls_recaudacion) as Recaudacion
from peliculas as pl
group by year(pl.pls_fecEstreno)

-- B) Obtener el promedio de duración en minutos entre todas las películas. 
select avg(p.pls_duracion * 1.0) as 'Promedio de tiempo por pelicula' 
from peliculas as p

-- C) Obtener el promedio de duración en minutos entre todas las películas que se hayan estrenado 
--    desde el año 2000 en adelante. 
select avg(p.pls_duracion * 1.0) as 'Promedio de tiempo por pelicula apartir del 2000' 
from peliculas as p
where year(p.pls_fecEstreno) > 1999

-- D) Obtener el total recaudado agrupado por país. Se deberá mostrar el nombre del país y el total 
--    recaudado. 
select ps.pss_pais as Pais,
sum(pl.pls_recaudacion) as Recaudacion
from peliculas as pl
inner join paises as ps on ps.pss_id = pl.pls_idPssRealizacion
group by ps.pss_pais

-- E) Obtener la puntuación mínima entre todas las películas. 
select min(p.pls_critica) as 'Puntuacion minima'
from peliculas as p

-- F) Obtener la cantidad de actores y actrices agrupados por nacionalidad. Se deberá mostrar el 
--    nombre del país y la cantidad de actores. 
select p.pss_pais as Pais, count(a.trs_idPais)
from actores as a
inner join paises as p on p.pss_id = a.trs_idPais
group by p.pss_pais

-- G) Obtener el promedio de tickets vendidos de las películas estrenadas en el primer semestre y 
--    en el segundo semestre. Se deberá obtener dos filas, la primera obteniendo el promedio de 
--    tickets vendidos para el primer semestre y la segunda fila para el segundo. Sólo debe de tenerse 
--    en cuenta los meses. Los días y años serán indiferentes. 
select distinct (select avg(p.pls_entradasvendidas) as Promedio from peliculas as p where MONTH(p.pls_fecEstreno) <= 6) as 'Promedio del primer semestre',
(select avg(p.pls_entradasvendidas) as Promedio from peliculas as p where MONTH(p.pls_fecEstreno) > 6) as 'Promedio del segundo semestre semestre'
from peliculas as p -- Se me hace que esta consulta esta mal

-- H) Obtener la cantidad de películas realizadas por país. Si algún país no tiene relacionada ninguna 
--    película, este deberá contabilizar cero. Se deberá mostrar nombre del país y cantidad de 
--    películas. 
select ps.pss_pais as Pais,
count(pl.pls_idPssRealizacion) as 'Cantidad de peliculas'
from paises as ps
left join peliculas as pl on pl.pls_idPssRealizacion = ps.pss_id
group by ps.pss_pais

-- I) Obtener el promedio de puntajes de películas agrupado por país. Incorporar al listado sólo 
--    aquellos países que superen el valor promedio de 7,5. Se deberá mostrar nombre del país y 
--    promedio de puntaje. 
select ps.pss_pais as Pais,
avg(pl.pls_critica) as 'Promedio de la critica'
from paises as ps
left join peliculas as pl on pl.pls_idPssRealizacion = ps.pss_id
group by ps.pss_pais
having avg(pl.pls_critica) >= 7.5

-- J) Obtener la fecha de nacimiento más cercana a la actual. 
select top 1 a.trs_fecNacimiento as 'Fecha de nacimiento'
from actores as a
order by a.trs_fecNacimiento desc

-- K) Obtener la cantidad de países en los que se haya realizado alguna película.
select count( distinct ps.pss_id) as cantidad
from paises as ps
inner join peliculas as pl on pl.pls_idPssRealizacion = ps.pss_id