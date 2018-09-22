/*
Laboratorio de computacio III
Normalizacion
Alumno: Ruiz Norman
Turno: Noche
Cuatrimestre: segundo
Año: 2018
*/

--Creacion de la base de datos
create database bibliotecaVirtual;
go

use bibliotecaVirtual;
go

--Creacion de tablas

create table categoriasLibros(
idCategorias int not null identity(1,1),
descripcion varchar(30) not null unique,
primary key(idCategorias)
);
go

create table pais(
idPais bigint not null identity(1,1) primary key,
pais varchar(20) not null unique
);
go

create table autores(
idAutor bigint not null identity(1,1) primary key,
apellido varchar(50) not null,
nombres varchar(50) not null,
idNacionalidad bigint foreign key references pais(idPais)
);
go

create table libros(
isbn varchar(17) not null primary key,
titulo varchar(50) not null,
año date not null,
paginas int not null,
idCategoria int not null foreign key references categoriasLibros(idCategorias),
--idAutor bigint not null foreign key references autores(idAutor)
);
go

create table autoresXLibro(
isbn varchar(17) not null foreign key references libros(isbn),
idAutor bigint not null foreign key references autores(idAutor),
primary key (isbn,idAutor)
);
go

create table librosXAutor(
idAutor bigint not null foreign key references autores(idAutor),
isbn varchar(17) not null foreign key references libros(isbn)
--primary key (idAutor,isbn)
);
go

create table usuarios(
idUsuario bigint not null identity(1,1) primary key,
apellido varchar(50) not null,
nombres varchar(50) not null,
fecRegistro date not null,
contraseña varchar(8) not null,

);
go

create table mails(
idUsuario bigint not null foreign key references usuarios(idUsuario),
mail varchar(50) not null,
primary key (idUsuario, mail)
);
go

create table formatoLibros(
idFormato bigint not null identity(1,1) primary key,
descripcion varchar(20) not null unique
);
go

create table bibliotecaXUsuarios(
nBiblioteca bigint not null identity(1,1),
idUsuario bigint not null foreign key references usuarios(idUsuario),
primary key (nBiblioteca,idUsuario)
);
go

create table librosXUsuario(
idUsuario bigint not null foreign key references usuarios(idUsuario),
isbn varchar(17) not null foreign key references libros(isbn),
fecAdquisicion date null,
preAdquisicion money null,
fecIniLec date null,
fecFinLec date null,
idFormato bigint not null foreign key references formatoLibros(idFormato),
condicion int not null check(condicion between 1 and 10),
estado int not null check(estado >= 0 and estado <=2)
);
go

--Carga de datos

--categoriasLibros
insert into categoriasLibros (descripcion) values ('Terror');
insert into categoriasLibros (descripcion) values ('Biografía'); 
insert into categoriasLibros (descripcion) values ('Ciencia ficcion');
insert into categoriasLibros (descripcion) values ('Infantil');
insert into categoriasLibros (descripcion) values ('Literatura Fantastica');
insert into categoriasLibros (descripcion) values ('Manuales');
insert into categoriasLibros (descripcion) values ('Novelas');
insert into categoriasLibros (descripcion) values ('Educacion');
insert into categoriasLibros (descripcion) values ('Enciclopedias');
insert into categoriasLibros (descripcion) values ('Arte');
--insert into categoriasLibros (descripcion) values ('');
select * from categoriasLibros order by idCategorias;
go

--libros
insert into libros (isbn, titulo, año, paginas, idCategoria) values ('978-950-0000-00-0','Megamente','2018','365','1');
insert into libros (isbn, titulo, año, paginas, idCategoria) values ('978-950-0000-00-1','Ralp el Demoledor','2017','4','2');
insert into libros (isbn, titulo, año, paginas, idCategoria) values ('978-950-0000-00-2','Rio','2016','8','3');
insert into libros (isbn, titulo, año, paginas, idCategoria) values ('978-950-0000-00-3','Aviones','2018','16','4');
insert into libros (isbn, titulo, año, paginas, idCategoria) values ('978-950-0000-00-4','Mi villano favorito','2017','32','5');
insert into libros (isbn, titulo, año, paginas, idCategoria) values ('978-950-0000-00-5','Madagascar','2014','64','6');
insert into libros (isbn, titulo, año, paginas, idCategoria) values ('978-950-0000-00-6','Zootopia','2007','128','7');
insert into libros (isbn, titulo, año, paginas, idCategoria) values ('978-950-0000-00-7','Numero 9','2000','256','8');
insert into libros (isbn, titulo, año, paginas, idCategoria) values ('978-950-0000-00-8','El origen de los guardianes','2018','512','9');
insert into libros (isbn, titulo, año, paginas, idCategoria) values ('978-950-0000-00-9','Angry birds','2011','1024','5');
--insert into libros (isbn, titulo, año, paginas, idCategoria) values ('','','','','');
select * from libros;
go

--pais
insert into pais(pais) values ('Argentina');
insert into pais(pais) values ('Bolivia');
insert into pais(pais) values ('Brasil');
insert into pais(pais) values ('Chile');
insert into pais(pais) values ('Colombia');
insert into pais(pais) values ('Ecuador');
insert into pais(pais) values ('Venezuela');
insert into pais(pais) values ('Paraguay');
insert into pais(pais) values ('Peru');
insert into pais(pais) values ('Uruguay');
insert into pais(pais) values ('Guayana');
insert into pais(pais) values ('Surinam');
insert into pais(pais) values ('Trinidad y Tobago');
--insert into pais(pais) values ('');
select * from pais;
go

--autores
insert into autores (apellido, nombres,idNacionalidad) values ('Rowling','Joanne Kathleen','1');
insert into autores (apellido, nombres,idNacionalidad) values ('Marquez','Gabriel Garcia','2');
insert into autores (apellido, nombres,idNacionalidad) values ('Ella Torre','Pablo','3');
insert into autores (apellido, nombres,idNacionalidad) values ('Bo Bardi','Lina','4');
insert into autores (apellido, nombres,idNacionalidad) values ('Duhart','Emilio','5');
insert into autores (apellido, nombres,idNacionalidad) values ('Salmona','Rogelio','6');
insert into autores (apellido, nombres,idNacionalidad) values ('Benitez','Solano','7');
insert into autores (apellido, nombres,idNacionalidad) values ('Dieste','Eladio','8');
insert into autores (apellido, nombres,idNacionalidad) values ('Villanueva','Carlos Raul','9');
insert into autores (apellido, nombres,idNacionalidad) values ('Testa','Clorindo','10');
--insert into autores (apellido, nombres,idNacionalidad) values ('','','');
select * from autores;
go

--librosXAutor
insert into librosXAutor (idAutor,isbn) values ('1','978-950-0000-00-0');
insert into librosXAutor (idAutor,isbn) values ('1','978-950-0000-00-1');
insert into librosXAutor (idAutor,isbn) values ('2','978-950-0000-00-2');
insert into librosXAutor (idAutor,isbn) values ('2','978-950-0000-00-3');
insert into librosXAutor (idAutor,isbn) values ('2','978-950-0000-00-3');
insert into librosXAutor (idAutor,isbn) values ('3','978-950-0000-00-5');
insert into librosXAutor (idAutor,isbn) values ('4','978-950-0000-00-5');
insert into librosXAutor (idAutor,isbn) values ('5','978-950-0000-00-6');
insert into librosXAutor (idAutor,isbn) values ('5','978-950-0000-00-7');
insert into librosXAutor (idAutor,isbn) values ('7','978-950-0000-00-9');
--insert into librosXAutor (idAutor,isbn) values ('','');
select * from librosXAutor;
go

--autoresXLibro
insert into autoresXLibro (isbn, idAutor) values ('978-950-0000-00-0','1');
insert into autoresXLibro (isbn, idAutor) values ('978-950-0000-00-1','1');
insert into autoresXLibro (isbn, idAutor) values ('978-950-0000-00-2','2');
insert into autoresXLibro (isbn, idAutor) values ('978-950-0000-00-2','3');
insert into autoresXLibro (isbn, idAutor) values ('978-950-0000-00-5','6');
insert into autoresXLibro (isbn, idAutor) values ('978-950-0000-00-0','5');
insert into autoresXLibro (isbn, idAutor) values ('978-950-0000-00-7','5');
insert into autoresXLibro (isbn, idAutor) values ('978-950-0000-00-9','5');
insert into autoresXLibro (isbn, idAutor) values ('978-950-0000-00-0','9');
insert into autoresXLibro (isbn, idAutor) values ('978-950-0000-00-8','1');
--insert into autoresXLibro (isbn, idAutor) values ('','');
select * from autoresXLibro;
go

--usuarios
insert into usuarios (apellido, nombres, fecRegistro, contraseña) values ('Ruiz','Norman','08/22/2018','12345678');
insert into usuarios (apellido, nombres, fecRegistro, contraseña) values ('UTN','Guido','04/11/2016','12345678');
insert into usuarios (apellido, nombres, fecRegistro, contraseña) values ('UTN','Ivan','06/30/1999','12345678');
insert into usuarios (apellido, nombres, fecRegistro, contraseña) values ('UTN','Fernando','12/05/2007','12345678');
insert into usuarios (apellido, nombres, fecRegistro, contraseña) values ('UTN','Andres','01/18/2018','12345678');
insert into usuarios (apellido, nombres, fecRegistro, contraseña) values ('UTN','Santiago','10/26/2010','12345678');
insert into usuarios (apellido, nombres, fecRegistro, contraseña) values ('UTN','Daniela','11/29/2001','12345678');
insert into usuarios (apellido, nombres, fecRegistro, contraseña) values ('UTN','Florencia','12/19/2003','12345678');
insert into usuarios (apellido, nombres, fecRegistro, contraseña) values ('UTN','Carolina','08/17/2011','12345678');
insert into usuarios (apellido, nombres, fecRegistro, contraseña) values ('UTN','Ariana','01/05/2012','12345678');
--insert into usuarios (apellido, nombres, fecRegistro, contraseña) values ('','','','');
select * from usuarios;
go

--mails
insert into mails(idUsuario, mail) values ('1','correoelectronico1@dominio.uno.com');
insert into mails(idUsuario, mail) values ('2','correoelectronico2@dominio.dos.com');
insert into mails(idUsuario, mail) values ('3','correoelectronico3@dominio.tres.com');
insert into mails(idUsuario, mail) values ('4','correoelectronico4@dominio.cuatro.com');
insert into mails(idUsuario, mail) values ('5','correoelectronico5@dominio.cinco.com');
insert into mails(idUsuario, mail) values ('6','correoelectronico6@dominio.seis.com');
insert into mails(idUsuario, mail) values ('7','correoelectronico7@dominio.ciete.com');
insert into mails(idUsuario, mail) values ('8','correoelectronico8@dominio.ocho.com');
insert into mails(idUsuario, mail) values ('9','correoelectronico9@dominio.nueve.com');
insert into mails(idUsuario, mail) values ('10','correoelectronico10@dominio.diez.com');
--insert into mails(idUsuario, mail) values ('','');
select * from mails;
go

--formatoLibros
insert into formatoLibros (descripcion) values ('Impreso');
insert into formatoLibros (descripcion) values ('Tigital');
insert into formatoLibros (descripcion) values ('Lienzo');
insert into formatoLibros (descripcion) values ('Papiro');
insert into formatoLibros (descripcion) values ('Roca');
--insert into formatoLibros (descripcion) values ('');
select * from formatoLibros;
go

--bibliotecaXUsuarios
insert into bibliotecaXUsuarios (idUsuario) values ('1');
insert into bibliotecaXUsuarios (idUsuario) values ('2');
insert into bibliotecaXUsuarios (idUsuario) values ('3');
insert into bibliotecaXUsuarios (idUsuario) values ('4');
insert into bibliotecaXUsuarios (idUsuario) values ('5');
insert into bibliotecaXUsuarios (idUsuario) values ('6');
insert into bibliotecaXUsuarios (idUsuario) values ('7');
insert into bibliotecaXUsuarios (idUsuario) values ('8');
insert into bibliotecaXUsuarios (idUsuario) values ('9');
insert into bibliotecaXUsuarios (idUsuario) values ('10');
--insert into bibliotecaXUsuarios (idUsuario) values ();
select * from bibliotecaXUsuarios;
go

--librosXUsuario
insert into librosXUsuario (idUsuario, isbn, fecAdquisicion, preAdquisicion, fecIniLec, fecFinLec, idFormato, condicion, estado) values ('1','978-950-0000-00-0','08/29/2014','1','01/29/2016','06/29/2016','1','1','0');
insert into librosXUsuario (idUsuario, isbn, fecAdquisicion, preAdquisicion, fecIniLec, fecFinLec, idFormato, condicion, estado) values ('2','978-950-0000-00-1','08/29/2015','2','02/27/2017','07/29/2016','2','2','1');
insert into librosXUsuario (idUsuario, isbn, fecAdquisicion, preAdquisicion, fecIniLec, fecFinLec, idFormato, condicion, estado) values ('3','978-950-0000-00-2','08/29/2016','4','03/29/2018','08/29/2016','3','3','2');
insert into librosXUsuario (idUsuario, isbn, fecAdquisicion, preAdquisicion, fecIniLec, fecFinLec, idFormato, condicion, estado) values ('4','978-950-0000-00-3','08/29/2017','8','04/29/2017','09/29/2016','4','4','0');
insert into librosXUsuario (idUsuario, isbn, fecAdquisicion, preAdquisicion, fecIniLec, fecFinLec, idFormato, condicion, estado) values ('5','978-950-0000-00-4','08/29/2014','16','05/29/2015','10/29/2016','5','5','1');
insert into librosXUsuario (idUsuario, isbn, fecAdquisicion, preAdquisicion, fecIniLec, fecFinLec, idFormato, condicion, estado) values ('1','978-950-0000-00-5','08/29/2015','32','06/29/2016','11/29/2016','1','6','2');
insert into librosXUsuario (idUsuario, isbn, fecAdquisicion, preAdquisicion, fecIniLec, fecFinLec, idFormato, condicion, estado) values ('2','978-950-0000-00-6','08/29/2016','64','07/29/2017','12/29/2016','2','7','0');
insert into librosXUsuario (idUsuario, isbn, fecAdquisicion, preAdquisicion, fecIniLec, fecFinLec, idFormato, condicion, estado) values ('3','978-950-0000-00-7','08/29/2017','128','08/29/2018','01/29/2016','3','8','1');
insert into librosXUsuario (idUsuario, isbn, fecAdquisicion, preAdquisicion, fecIniLec, fecFinLec, idFormato, condicion, estado) values ('1','978-950-0000-00-8','08/29/2014','256','09/29/2015','02/29/2016','4','9','2');
insert into librosXUsuario (idUsuario, isbn, fecAdquisicion, preAdquisicion, fecIniLec, fecFinLec, idFormato, condicion, estado) values ('2','978-950-0000-00-9',null,'0',null,null,'5','10','2');
--insert into librosXUsuario (idUsuario, isbn, fecAdquisicion, preAdquisicion, fecIniLec, fecFinLec, idFormato, condicion, estado) values ('','','','','','','','','');
select * from librosXUsuario;
go
