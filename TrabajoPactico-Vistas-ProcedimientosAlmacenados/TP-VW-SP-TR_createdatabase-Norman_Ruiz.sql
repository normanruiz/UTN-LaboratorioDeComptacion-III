/*
Universisas Tecnologica Nacional
General pacheco
Laboratorio de Computacioon III
Profesor: Angel Simon
Año 2018
Segundo cuatrimestre
Turno Noche
Alumno Norman Ruiz
Trabajo Practico Vistas Procedimientos almacenados Triggers
*/


/* 
Parte 0 - Repaso Normalización 
 
Realizar la normalización, creación de tablas, relaciones y restricciones a partir del siguiente 
enunciado. 
 
El Sistema Único de Boleto Electrónico (SUBE) desea realizar la base de datos que permitirá a sus 
usuarios utilizar el sistema. 
La forma de pago en los colectivos se realiza mediante una tarjeta magnética que contiene el 
saldo de la misma, cuando se paga el ticket automáticamente se registra la información en la 
base de datos centralizada, por lo que, tarjeta y sistema tienen exactamente la misma 
información de manera sincrónica. Esto quiere decir que este sistema y todas sus terminales 
están constantemente en línea siendo así extremadamente eficiente y ficticio. 
 
Le solicitaron a usted, futuro programador, desarrollar la base de datos que permitirá almacenar 
la información y, en una próxima etapa, deberá desarrollarle módulos que permitan garantizar la 
consistencia de la misma. 
 
Se deberán registrar los usuarios que utilizarán las tarjetas. De cada usuario se debe poder 
obtener: el Apellido, nombre, número de DNI, fecha de su primera tarjeta SUBE, saldo de su 
última tarjeta SUBE, cantidad de viajes realizados, domicilio y edad. 
 
Las tarjetas, necesarias para poder realizar cualquier viaje, registran la siguiente información: 
Número identificatorio de tarjeta, Apellido y nombre del usuario, número de DNI,  fecha de alta 
de la tarjeta SUBE y saldo. 
 
Otro elemento que se registra son los viajes. Cada viaje debe tiene: un código único de viaje, una 
fecha y hora de viaje, el número de interno del colectivo, la línea de colectivo, el número de 
tarjeta SUBE que abona el viaje, el importe del ticket y el usuario que viaja. 
 
Para esto también es necesario almacenar las líneas de colectivos, cada línea registra el código 
de línea, el nombre de la empresa y el domicilio legal. 
 
Por último, otro elemento a registrar en la base de datos son los movimientos que sufren las 
tarjetas. Es decir, todos los débitos y créditos que se le practican. Para cada movimiento se 
registra: número de movimiento, fecha y hora, número de tarjeta SUBE, importe, tipo de 
movimiento ('C' - Crédito y 'D' - Débito). 

Atención: 
 
- Las entidades de usuario y tarjeta deberán contener un campo estado para poder realizar 
baja lógica. 
 */

-- Normalizacion de la base de datos

use master;

go
create database db_sube;

go
use db_sube;

go
create table usuarios(
id bigint primary key identity(1,1),
apellido varchar(100) not null,
nombre varchar(100) not null,
dni varchar(8) not null unique, 
fec_nac datetime not null,
domicilio varchar(200) not null,
fec_pri_tar datetime null,
saldo_ultima money not null,
estado bit not null
)

go
create table tarjetas(
id bigint primary key identity(1,1),
num_tarjeta bigint not null unique,
idUsuario bigint not null foreign key references usuarios(id),
fec_alta datetime not null,
estado bit not null
)

go
create table lineasDeColectivos(
id bigint primary key identity(1,1),
cod_linea varchar(3) not null unique,
nombre_empresa varchar(100) not null,
dom_legal varchar(200) not null,
)

go
create table internos(
id bigint primary key identity(1,1),
num_interno varchar(3) not null unique,
idLinea bigint not null foreign key references lineasDeColectivos(id),
)

go
create table viajes(
id bigint primary key identity(1,1),
fecha_hora datetime not null,
idInterno bigint not null foreign key references internos(id),
idTarjeta bigint not null foreign key references tarjetas(id),
importe money not null
)

go
create table registros(
id bigint primary key identity(1,1),
fecha_hora datetime not null,
idTarjeta bigint not null foreign key references tarjetas(id),
importe money not null,
tipo_movimiento char not null check(tipo_movimiento = 'C' or tipo_movimiento = 'D')
)
