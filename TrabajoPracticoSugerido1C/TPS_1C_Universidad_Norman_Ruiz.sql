/*
Universisas Tecnologica Nacional
General pacheco
Laboratorio de Computacioon III
Profesor: Angel Simon
A�o 2018
Segundo cuatrimestre
Turno Noche
Alumno Norman Ruiz
Trabajo Practico N�1C
*/

/*
Trabajo práctico sugerido 1C 
 
Normalización y creación de tablas y relaciones por código 
 
Una universidad quiere informatizar su planta docente. Desea crear un sistema que les permita 
organizar los docentes que dictan cada una de las materias de las carreras que ofrece la 
institución. Le ha ofrecido a usted diseñar la base de datos y le ha enviado un correo electrónico 
con una hoja de cálculo como adjunto con los siguientes datos: 
 
Hoja Carreras 
------------------------------- 
Código de carrera 
Nombre de carrera 
Resolución del ministerio de educación 
 
Hoja Materias 
------------------------------ 
Código de materia 
Nombre de carrera 
Nombre de materia 
Nombre del profesor actual 
Nombre del profesor actual 2 
Nombre del Jefe de trabajos prácticos 
Nombre de los Ayudantes de 1° y 2° 
 
Hoja Docentes 
---------------------------------- 
DNI 
Fecha de nacimiento 
Edad 
Nombre 
Apellido 
Legajo universidad 
Nombre de Materia 1 
Nombre de Materia 2 
Nombre de Materia 3 
 
Hoja  Plantas docentes 
--------------------------------------- 
Nombre de Carrera 
Nombre de Materia 
Año 
Nombre de profesor titular 
Nombre de jefe de trabajos prácticos 
Nombre de ayudante de 1° 
Nombre de ayudante de 2° 
 
En el cuerpo del mail le aclararon que cada docente puede dar clases en diferentes materias de 
diferentes carreras. Algunas materias pueden tener más de un docente. En algunos casos, ciertas 
materias tienen un Jefe de trabajos prácticos y una serie de ayudantes de 1° y 2° ya que la 
cantidad de alumnos es mucha. Aunque, hay algunas materias que sólo con un profesor es 
suficiente. 
Le adjunta otro listado que le aclara los tipos de cargo que puede tener un docente: 
 
Cargos docentes 
---------------------------- 
Profesor titular 
Jefe de trabajos prácticos 
Ayudante de primera 
Ayudante de segunda 
*/

-- Normalizacion de la base de datos
-- Creacion de la base de datos

use master;

go
create database bd_TPS1C;

go
use bd_TPS1C;

go
create table resoluciones(
rlc_id int not null identity(1,1) primary key,
rlc_denominacion varchar(100) not null unique
);

go
create table carreras(
crs_id int not null identity(1,1) primary key,
crs_nombCarrera varchar(60) not null unique,
crs_idResolucion int not null foreign key references resoluciones(rlc_id)
);

go
create table materias(
mtr_id int not null identity(1,1) primary key,
mtr_nombMateria varchar(100) not null,
mtr_idCarrera int not null foreign key references carreras(crs_id)
);

go
create table cargos(
cgs_id int not null identity(1,1) primary key,
cgs_cargo varchar(100) not null unique
);

go
create table docentes(
dct_id int not null identity(1,1) primary key,
dct_legajo varchar(10) not null unique,
dct_dni varchar(8) not null unique,
dct_apellido varchar(100)not null,
dct_nombre varchar(100) not null,
dct_fecNacimiento date not null,
);

go
create table plantasDocentes(
pds_id int not null identity(1,1),
pds_iddocente int not null foreign key references docentes(dct_id),
pds_idMateria int not null foreign key references materias(mtr_id),
pds_anio int not null,
pds_cargo  int not null foreign key references cargos(cgs_id),
primary key(pds_iddocente, pds_idMateria, pds_anio)
);
