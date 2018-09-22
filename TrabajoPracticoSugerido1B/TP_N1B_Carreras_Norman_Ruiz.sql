/*
Universisas Tecnologica Nacional
General pacheco
Laboratorio de Computacioon III
Profesor: Angel Simon
Año 2018
Segundo cuatrimestre
Turno Noche
Alumno Norman Ruiz
Trabajo Practico Nº1B
*/

-- Normalizacion de la base de datos
-- Creacion de la base de datos

create database bdExamenesTP1B;

go
use bdExamenesTP1B;

-- Creacion de tablas

go
create table carreras(
id int not null identity(1,1) primary key,
carrera varchar(50) not null unique,
);

go
create table materias(
id int not null identity(1,1) primary key,
materia varchar(50) not null unique
);

go
create table examenes(
id int not null identity(1,1) primary key,
fechaExamen datetime not null unique
);

go
create table estudiantes(
legajo bigint not null identity(1,1) primary key,
apellido varchar(50) not null,
nombre varchar(50) not null,
idCarrera int not null foreign key references carreras(id),
idMateria int not null foreign key references materias(id),
idExemane int not null foreign key references examenes(id)
);