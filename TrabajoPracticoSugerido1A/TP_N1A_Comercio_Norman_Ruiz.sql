/*
Universisas Tecnologica Nacional
General pacheco
Laboratorio de Computacioon III
Profesor: Angel Simon
Año 2018
Segundo cuatrimestre
Turno Noche
Alumno Norman Ruiz
Trabajo Practico Nº1A
*/

-- Normalizacion de la base de datos
-- Creasion de la base de datos

create database bdComercioTP1A;

go
use bdComercioTP1A;

go
create table marcas(
id int not null identity(1,1),
nombre varchar(50) not null,
primary key(id, nombre)
);

go
create table tipos(
id int not null identity(1,1),
nombre varchar(50) not null,
primary key(id, nombre)
);

go
create table articulos(
id int not null identity(1,1) primary key,
descripcion varchar(50) not null,
id_Marca int not null foreign key references marcas(id),
precio_compra money default NULL,
precio_venta money default NULL,
id_tipo int not null foreign key references tipos(id),
stock_actual int default null,
stock_minimo int default null,
estado bit default 'true',
);