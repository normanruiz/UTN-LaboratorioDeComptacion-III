/*
Universisas Tecnologica Nacional
General pacheco
Laboratorio de Computacioon III
Profesor: Angel Simon
A�o 2018
Segundo cuatrimestre
Turno Noche
Alumno Norman Ruiz
Trabajo Practico Nº3
*/

/*
Consultas de acción 
 
El siguiente ejercicio tiene como objetivo poner en práctica las consultas de acción. Para ello se 
utilizará la base de datos creada en el Trabajo práctico sugerido nº 2. 
Todos los ejercicios que se detallan a continuación deberán ser realizados mediante código SQL. 
*/

use bd_TPS2;
-- 1) 
-- A) Se deberán realizar los INSERT necesarios para poder cargarle datos a la base de datos como figuran en el documento LAB3_TP2 - Hoja 1.pdf. 

-- Carga de paises
insert into paises (pss_pais) values ('ARGENTINA')
insert into paises (pss_pais) values ('ESTADOS UNIDOS')
insert into paises (pss_pais) values ('REINO UNIDO')
insert into paises (pss_pais) values ('INDIA')
insert into paises (pss_pais) values ('FRANCIA')
insert into paises (pss_pais) values ('ESPAÑA')

-- Carga de generos
insert into generos (gnr_genero) values ('TERROR')
insert into generos (gnr_genero) values ('COMEDIA')
insert into generos (gnr_genero) values ('CIENCIA FICCION')
insert into generos (gnr_genero) values ('DRAMA')

-- Carga de calificacion
insert into calificaciones (cfn_calificacion) values ('APTO PARA TODO PUBLICO')
insert into calificaciones (cfn_calificacion) values ('APTO PARA MAYORES DE 13')
insert into calificaciones (cfn_calificacion) values ('APTO PARA MAYORES DE 16')

-- Carga de actores
insert into actores (trs_apellido, trs_nombre, trs_fecNacimiento, trs_idPais) values ('DARIN','RICARDO','19570116',1)
insert into actores (trs_apellido, trs_nombre, trs_fecNacimiento, trs_idPais) values ('BALE','CHRISTIAN','19740130',3)
insert into actores (trs_apellido, trs_nombre, trs_fecNacimiento, trs_idPais) values ('PALTROW','GWYNETH','19721127',2)
insert into actores (trs_apellido, trs_nombre, trs_fecNacimiento, trs_idPais) values ('FREEMAN','MORGAN','19370601',2)

-- Carga de peliculas
insert into peliculas (pls_idPssRealizacion, pls_titulo, pls_inversion, pls_recaudacion, pls_entradasvendidas, pls_idGenero, pls_fecEstreno, pls_duracion, pls_calificacion, pls_critica) 
values (2,'SEVEN',10000000,30000000,5000000,4,'19960115',127,2,8.70)
insert into peliculas (pls_idPssRealizacion, pls_titulo, pls_inversion, pls_recaudacion, pls_entradasvendidas, pls_idGenero, pls_fecEstreno, pls_duracion, pls_calificacion, pls_critica) 
values (1,'UN CUENTO CHINO',5000000,4000000,1000000,2,'20110324',93,1,7.30)
insert into peliculas (pls_idPssRealizacion, pls_titulo, pls_inversion, pls_recaudacion, pls_entradasvendidas, pls_idGenero, pls_fecEstreno, pls_duracion, pls_calificacion, pls_critica) 
values (2,'TERMINATOR',20000000,90000000,6000000,3,'20090603',115,2,6.70)

-- Carga de actores por peliculas
insert into actoresXpelicula (axp_idPelicula, axp_idActores) values (1 , 3)
insert into actoresXpelicula (axp_idPelicula, axp_idActores) values (1 , 4)
insert into actoresXpelicula (axp_idPelicula, axp_idActores) values (2 , 1)
insert into actoresXpelicula (axp_idPelicula, axp_idActores) values (3 , 2)
 
-- B) Guardar todas las consultas con el nombre de TP_SUGERIDO2_DATOS.sql 
 
-- 2) 
-- A) Modificar la duración de la película de nombre 'SEVEN' a 130 minutos. 
update peliculas set pls_duracion = 130 where pls_titulo = 'SEVEN'

-- B) Modificar la duración de todas las películas agregándole 10 minutos extra. 
update peliculas set pls_duracion = (pls_duracion + 10)

-- C) Modificar la recaudación a $ 0 a todas las películas que se hayan estrenado entre el 1/1/1990 y el 1/1/2000. 
update peliculas set pls_recaudacion = 0 where pls_fecEstreno between '19900101' and '20000101'

-- D) Modificar el apellido a 'Kloster' de todos los actores cuyos nombres terminen en 'AN'. 
update actores set trs_apellido = 'Kloster' where trs_nombre like '%AN'

-- E) Modificar las calificaciones de: 
--    'APTO PARA TODO PUBLICO' -> 'ATP' 
update calificaciones set cfn_calificacion = 'ATP' where cfn_calificacion = 'APTO PARA TODO PUBLICO'

--    'APTO PARA MAYORES DE 13' -> 'PG-13' 
update calificaciones set cfn_calificacion = 'PG-13' where cfn_calificacion = 'APTO PARA MAYORES DE 13'

--    'APTO PARA MAYORES DE 16' -> 'PG-16' 
update calificaciones set cfn_calificacion = 'PG-16' where cfn_calificacion = 'APTO PARA MAYORES DE 16'
 
-- 3) select * from generos
-- A) Eliminar los países cuyo nombres sean 'India', 'Francia' o 'España' 
delete from paises where pss_pais in('India', 'Francia' , 'España')

-- B) Eliminar el género con código 1 
delete from generos where gnr_id = 1

-- C) Eliminar el país 'Reino Unido'. ¿Por qué no se pudo eliminar el registro? 
delete from paises where pss_pais = 'Reino Unido' -- Porque la tabla paises esta referenciada (integridad referencial) desde las tablas peliculas y actores

-- D) Eliminar todos los datos de la base de datos 
delete from actoresXpelicula
delete from peliculas
delete from actores
delete from generos
delete from calificaciones
delete from paises


