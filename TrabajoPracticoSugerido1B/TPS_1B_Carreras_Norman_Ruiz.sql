/*
Universisas Tecnologica Nacional
General pacheco
Laboratorio de Computacioon III
Profesor: Angel Simon
A�o 2018
Segundo cuatrimestre
Turno Noche
Alumno Norman Ruiz
Trabajo Practico N�1B
*/

/*
Trabajo práctico sugerido 1B 
 
Normalización y creación de tablas y restricciones por código 
 
Realizar una base de datos normalizada a partir del siguiente conjunto de datos: 
 
A) Determinar las tablas necesarias así como sus respectivas columnas y restricciones. 
B) Optimizar la Base de datos para evitar almacenar grupos repetitivos. 
C) Realizar el Diagrama de Entidad Relación.

 
ACLARACIONES: 
- Un estudiante no puede rendir más de una vez la misma materia en una misma fecha. 
- La nota debe ser un número entero entre 0 y 10. 
 
Como ayuda se indican los nombres de las posibles tablas a utilizar: 
- ALUMNOS 
- MATERIAS 
- CARRERAS 
- EXÁMENES 
 
Agregar todas las columnas y tablas que consideren necesarios. 

*/
-- Normalizacion de la base de datos
-- Creacion de la base de datos

use master;

go
create database bd_TPS1B;

go
use bd_TPS1B;

go
create table carreras(
crr_id int not null identity(1,1) primary key,
crr_nombCarrera varchar(50) not null unique,
);

go
create table materias(
mtr_id int not null identity(1,1) primary key,
mtr_nombMateria varchar(50) not null unique
);

go
create table estudiantes(
std_legajo int not null identity(1,1) primary key,
std_apellido varchar(50) not null,
std_nombre varchar(50) not null
);

go
create table examenes(
xms_id int not null identity(1,1),
xms_idEstudiante int not null foreign key references estudiantes(std_legajo),
xms_idCarrera int not null foreign key references carreras(crr_id),
xms_idMateria int not null foreign key references materias(mtr_id),
xms_fecha date not null,
xms_nota int not null check(xms_nota in(0-10)),

primary key(xms_idEstudiante, xms_idCarrera, xms_idMateria, xms_fecha)
);


