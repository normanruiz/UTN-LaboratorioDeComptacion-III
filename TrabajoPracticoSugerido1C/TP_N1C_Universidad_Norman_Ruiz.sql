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

-- Normalizacion de la base de datos
-- Creacion de la base de datos

create database bdUniversidadTP1C;

go
use bdUniversidadTP1C;

-- Creacion de tablas

go
create table carreas(
id int not null identity(1,1),
carrera varchar(60) not null,
resolucion varchar(50) not null,
primary key(id, carrera)
);

go
create table cargos(
id int not null identity(1,1),
cargo varchar(50) not null,
primary key  
);

go 
create table profesores(
id int not null identity(1,1) primary key,
nombre varchar(50) not null,
apellido varchar(50) not null
);

go 
create table jefes(
id int not null identity(1,1) primary key, 
nombre varchar(50) not null,
apellido varchar(50) not null
);

go 
create table ayudantes(
id int not null identity(1,1) primary key,
nombre varchar(50) not null,
apellido varchar(50) not null
);

go
create table materias(
id int not null identity(1,1) primary key,
idCarrera int not null foreign key references carreras(id),
materia varchar(60) not null,
idProfesor1 int not null foreign key references profesores(id),
IdProfesor2 int not null foreign key references profesores(id) check (IdProfesor2 <> idProfesor1),
idJefeTP int not null foreign key references jefes(id),
idAyudante1 int not null foreign key references ayudantes(id),
idAyudante2 int not null foreign key references ayudantes(id) check (idAyudante2 <> idAyudante1)
);

go
create table Docentes(
dni varchar(8) not null unique,
fecNacimiento datetime not null,
nombre varchar(50) not null,
apellido varchar(50)not null,
legajo int not null identity(1,1) primary key,
idMateria1 int not null foreign key references materias(id) check(idMateria1 <> idMateria2 and idMateria1 <> idMateria3),  
idMateria2 int not null foreign key references materias(id) check(idMateria2 <> idMateria1 and idMateria2 <> IdMateria3),
idMateria3 int not null foreign key references materias(id) check(idMateria3 <> idMateria1 and idMateria3 <> idMateria2)
);

go
create table plantasDocentes(
idCarrera int not null foreign key references carreras(id),
idMateria int not null foreign key references materias(id),
idProfTitular int not null foreign key references profesores(id),
idJefeTP int null foreign key references jefes(id),
idAyudante1 int null foreign key references ayudantes(id),
idAyudante2 int null foreign key references ayudantes(id) check(idAyudante2 <> idAyudante1)
);

go
create table cargosDocentes(

);