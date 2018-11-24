/*
Universisas Tecnologica Nacional
General pacheco
Laboratorio de Computacioon III
Profesor: Angel Simon
A�o 2018
Segundo cuatrimestre
Turno Noche
Alumno Norman Ruiz
Trabajo Practico Nº2
*/

/*

Trabajo práctico sugerido nº 2 
 
Normalización y consultas de selección 
 
PARTE 1 
 
El siguiente ejercicio tiene como objetivo poner en práctica los conceptos de normalización y de 
consultas DDL y DML. 
Para ello se deberá optimizar la estructura de la siguiente base de datos aplicando los criterios 
de normalización (1FN, 2FN y 3FN). Luego, una vez definida la estructura correcta, se procederá a 
crear los scripts de creación de base de datos, tablas, restricciones y relaciones. 
 
Actores 
--------------- 
Código de Actor - entero autonumérico 
Apellido y nombre - 50 caracteres para el nombre y 50 caracteres para el apellido 
Fecha de nacimiento  
Edad - entero 
Nacionalidad - 50 caracteres para el nombre del país 
 
Películas 
--------------- 
Código de película - entero autonumérico 
País de realización - 50 caracteres para el nombre del país 
Título - 150 caracteres 
Actor_1 - 50 caracteres para el nombre y 50 caracteres para el apellido 
Actor_2 - 50 caracteres para el nombre y 50 caracteres para el apellido 
Actor_3 - 50 caracteres para el nombre y 50 caracteres para el apellido 
Actor_4 - 50 caracteres para el nombre y 50 caracteres para el apellido 
Actor_5 - 50 caracteres para el nombre y 50 caracteres para el apellido 
Inversión en dólares - valor monetario 
Recaudación en dólares - valor monetario 
Cantidad de tickets vendidos - entero largo 
Ganancia - valor monetario 
Pérdida - valor monetario 
Género - 30 caracteres para el nombre del género. Ej: Acción, Comedia, Terror, C. Ficción, etc. 
Fecha de estreno 
Duración en minutos - entero corto 
Calificación - 30 caracteres para el nombre de la categoría. Ej: Apta todo público, Menores de 16, 
etc. 
Puntaje de la crítica - valor numérico decimal entre 0 y 10 
NOTA: La pérdida o ganancia de una película se calcula mediante la diferencia entre la
recaudación y la inversión. 
 */

use master;

go
create database bd_TPS2;

go
use bd_TPS2;

go
create table paises(
pss_id int not null identity(1,1) primary key,
pss_pais varchar(100) not null unique
);

go
create table actores(
trs_codActor int not null identity(1,1) primary key,
trs_apellido varchar(100) not null,
trs_nombre varchar(100) not null,
trs_fecNacimiento date not null ,
trs_idPais int not null foreign key references paises(pss_id)
);

go
create table generos(
gnr_id int not null identity(1,1) primary key,
gnr_genero varchar(100) not null unique
); 

go
create table calificaciones(
cfn_id int not null identity(1,1) primary key,
cfn_calificacion varchar(100) not null unique
);

go
create table peliculas(
pls_codPelicula int not null identity(1,1) primary key,
pls_idPssRealizacion int not null foreign key references paises(pss_id),
pls_titulo varchar(150) not null, 
pls_inversion money not null,
pls_recaudacion money not null,
pls_entradasvendidas int not null,  
pls_idGenero int not null foreign key references generos(gnr_id),
pls_fecEstreno date not null, 
pls_duracion tinyint not null,
pls_calificacion int not null foreign key references calificaciones(cfn_id),
pls_critica decimal not null check(pls_critica between 0 and 10)
);

go
create table actoresXpelicula(
axp_id int not null identity(1,1),
axp_idPelicula int not null foreign key references peliculas(pls_codPelicula),
axp_idActores int not null foreign key references actores(trs_codActor),
primary key(axp_idPelicula, axp_idActores)
);


-- PARTE 2 
 
-- Expresar las siguientes consultas de selección en código SQL 
 
-- A) Obtener un listado de actores ordenado por apellido en forma descendente.
select * 
from actores as a
order by a.trs_apellido desc

-- B) Obtener un listado de actores que tengan edad entre 18 y 28 años.
select *
from actores as a
where DATEDIFF(YEAR,a.trs_fecNacimiento, GETDATE()) between 18 and 28

-- C) Obtener un listado de actores que cumplan años en los meses de Enero, Febrero, Marzo, Octubre, Noviembre y Diciembre.
select *
from actores as a
where MONTH(a.trs_fecNacimiento) in (1,2,3,10,11,12)

-- D) Obtener un listado de actores que no sean de nacionalidad con código 1, 2, 3, 6, 7 ni 8. 
select *
from actores as a
where a.trs_idPais not in (1, 2, 3, 6, 7, 8)

-- E) Obtener la última película estrenada del género ciencia ficción. 
select  top 1 *
from peliculas as p
where p.pls_idGenero = 4
order by p.pls_fecEstreno desc

-- F) Obtener la película que mayor recaudación haya obtenido en el año 2011. 
select top 1 *
from peliculas as p
where YEAR(p.pls_fecEstreno) = 2011
order by p.pls_recaudacion desc

-- G) Obtener las 10 mejores películas calificadas por los críticos. Mostrar todas las películas que se encuentren en el 10° puesto si hay más de una película con igual puntaje en dicha posición. 
select top 10 *
from peliculas as p
order by p.pls_critica desc, pls_entradasvendidas desc

-- H) Obtener un listado de todas las películas en las que haya actuado el actor con código número 1. 
select *
from peliculas as p
inner join actoresXpelicula as axp on axp.axp_idPelicula = p.pls_codPelicula
where axp.axp_idActores = 1

-- I) Obtener un listado que indique código de película, título y ganancia sólo de las películas que no hayan generado pérdida.
select p.pls_codPelicula as Codigo, p.pls_titulo as Titulo, (p.pls_recaudacion - p.pls_inversion) as Ganancia
from peliculas as p
where (p.pls_recaudacion - p.pls_inversion) > 0

-- J) Obtener los datos de la película que menos duración tenga. 
select top 1 *
from peliculas as p
order by p.pls_duracion asc

-- K) Obtener los datos de las películas que su título comience con la cadena 'Star'. 
select *
from peliculas as p
where p.pls_titulo like 'Star%'

-- L) Obtener los datos de las películas que su título comience con la letra 'T' pero su última letra no sea 'A', 'E', 'I', 'O' ni 'U'.
select *
from peliculas as p
where p.pls_titulo like 'T%' and p.pls_titulo not like '%[AEIOU]'

-- M) Obtener los datos de las películas que su título contenga al menos un número del 0 al 9.
select *
from peliculas as p
where p.pls_titulo like '%[0123456789]%'

-- N) Obtener los datos de las películas que su título contenga exactamente cinco caracteres. Resolverlo de dos maneras: 
--    1) Utilizando el operador LIKE y comodines
select *
from peliculas as p
where p.pls_titulo like '_____'

--    2) Utilizando la función LEN.
select *
from peliculas as p
where len(p.pls_titulo) = 5

-- O) Obtener los datos de las películas cuya recaudación supere el 25% de la inversión. 
select *
from peliculas as p
where p.pls_recaudacion > (p.pls_inversion * 0.25)

-- P) Obtener el título y el valor promedio de cada ticket. Teniendo en cuenta que la recaudación es netamente sobre venta de tickets. 
select p.pls_titulo as Titulo, (p.pls_recaudacion / p.pls_entradasvendidas) as 'Costo Promedio de ticket'
from peliculas as p

-- Q) Obtener el título de la película, la recaudación en dólares y la recaudación pesos. Teniendo en cuenta que u$s 1 -> $ 4,39 
select p.pls_titulo as Titulo, p.pls_recaudacion as 'Recaudacion en dolares', (p.pls_recaudacion * 4.39) as 'Recaudacion en pesos'
from peliculas as p

-- R) Obtener los datos de las películas cuyo puntaje se encuentre en el intervalo (1, 7). 
select *
from peliculas as p
where p.pls_critica between 1 and 7
 







-- Carga de datos auxiliares

-- Carga de paises
insert into paises (pss_pais) values ('Argentina')
insert into paises (pss_pais) values ('Venezuela')
insert into paises (pss_pais) values ('Brasil')
insert into paises (pss_pais) values ('Ecuador')
insert into paises (pss_pais) values ('Guayana')
insert into paises (pss_pais) values ('Surinam')

select * from paises

-- Carga de actores
insert into actores (trs_apellido, trs_nombre, trs_fecNacimiento, trs_idPais) values ('Disi','Emilio','19800402',1)
insert into actores (trs_apellido, trs_nombre, trs_fecNacimiento, trs_idPais) values ('Franchela','Guillermo','19980402',1)
insert into actores (trs_apellido, trs_nombre, trs_fecNacimiento, trs_idPais) values ('Darin','Ricardo','19800202',1)
insert into actores (trs_apellido, trs_nombre, trs_fecNacimiento, trs_idPais) values ('Renni','Gino','20000202',4)

select * from actores

-- Carga de generos
insert into generos (gnr_genero) values ('Acción')
insert into generos (gnr_genero) values ('Comedia')
insert into generos (gnr_genero) values ('Terror')
insert into generos (gnr_genero) values ('C. Ficción')
insert into generos (gnr_genero) values ('Infantil')

select * from generos

-- Carga de calificacion
insert into calificaciones (cfn_calificacion) values ('Apta todo público')
insert into calificaciones (cfn_calificacion) values ('Menores de 8')
insert into calificaciones (cfn_calificacion) values ('Menores de 16')

select * from calificaciones

-- Carga de peliculas
insert into peliculas (pls_idPssRealizacion, pls_titulo, pls_inversion, pls_recaudacion, pls_entradasvendidas, pls_idGenero, pls_fecEstreno, pls_duracion, pls_calificacion, pls_critica) 
values (1,'Megamente',1000,200000,250,1,'20071204',120,1,5)
insert into peliculas (pls_idPssRealizacion, pls_titulo, pls_inversion, pls_recaudacion, pls_entradasvendidas, pls_idGenero, pls_fecEstreno, pls_duracion, pls_calificacion, pls_critica) 
values (2,'Ralph',500,150000,100,1,'19520109',90,1,2)
insert into peliculas (pls_idPssRealizacion, pls_titulo, pls_inversion, pls_recaudacion, pls_entradasvendidas, pls_idGenero, pls_fecEstreno, pls_duracion, pls_calificacion, pls_critica) 
values (3,'Mi Villano Favorito',2000,10000,400,1,'19800402',75,1,10)
insert into peliculas (pls_idPssRealizacion, pls_titulo, pls_inversion, pls_recaudacion, pls_entradasvendidas, pls_idGenero, pls_fecEstreno, pls_duracion, pls_calificacion, pls_critica) 
values (4,'Como entrenar a tu Dradon',3500,150000,200,1,'19910423',150,1,8)
insert into peliculas (pls_idPssRealizacion, pls_titulo, pls_inversion, pls_recaudacion, pls_entradasvendidas, pls_idGenero, pls_fecEstreno, pls_duracion, pls_calificacion, pls_critica) 
values (4,'Numero 9',10000,1000000,500,4,'20181201',120,2,10)
insert into peliculas (pls_idPssRealizacion, pls_titulo, pls_inversion, pls_recaudacion, pls_entradasvendidas, pls_idGenero, pls_fecEstreno, pls_duracion, pls_calificacion, pls_critica) 
values (1,'Megamente 2',1000,200000,250,1,'20111204',120,1,5)
insert into peliculas (pls_idPssRealizacion, pls_titulo, pls_inversion, pls_recaudacion, pls_entradasvendidas, pls_idGenero, pls_fecEstreno, pls_duracion, pls_calificacion, pls_critica) 
values (2,'Ralph 2',500,200001,100,1,'20110109',90,1,2)

select * from peliculas

-- Carga de actores por peliculas
insert into actoresXpelicula (axp_idPelicula, axp_idActores) values (1 , 1)
insert into actoresXpelicula (axp_idPelicula, axp_idActores) values (2 , 2)
insert into actoresXpelicula (axp_idPelicula, axp_idActores) values (3 , 3)
insert into actoresXpelicula (axp_idPelicula, axp_idActores) values (4 , 4)
insert into actoresXpelicula (axp_idPelicula, axp_idActores) values (5 , 1)
insert into actoresXpelicula (axp_idPelicula, axp_idActores) values (6 , 2)
insert into actoresXpelicula (axp_idPelicula, axp_idActores) values (7 , 3)
insert into actoresXpelicula (axp_idPelicula, axp_idActores) values (1 , 4)
insert into actoresXpelicula (axp_idPelicula, axp_idActores) values (2 , 1)
insert into actoresXpelicula (axp_idPelicula, axp_idActores) values (3 , 2)

select * from actoresXpelicula