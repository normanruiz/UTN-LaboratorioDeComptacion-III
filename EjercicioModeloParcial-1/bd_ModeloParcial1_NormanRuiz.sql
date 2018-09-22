create database bdSube;

go
use bdSube;

go
create table empresaTransporte(
id int identity(1,1) primary key,
nombre varchar(50) not null unique
);

go
create table internos(
id int identity(1,1) primary key,
interno int not null unique 
);
go
create table lineas(
linea int not null primary key,
idEmpresa int not null foreign key references empresaTransporte(id)
);

go
create table tiposDocumentos(
id int identity(1,1) primary key,
tipo varchar(10) not null unique
);

go
create table ciudades(
codigoPostal int primary key,
ciudad varchar(50) not null
);

go
create table usuarios(
idTipoDocumento int not null foreign key references tiposDocumentos(id),
documento bigint primary key,
apellido varchar(50) not null,
nombre varchar(50) not null,
fechaNacimiento datetime,
codigoPostal int not null foreign  key references ciudades(codigoPostal)
);

go
create table motivosBaja(
id int identity(1,1) primary key,
descripcion varchar(50) not null
);

go
create table tarjetas(
numeroTarjeta bigint primary key,
idTipoDocumento int not null foreign key references tiposDocumentos(id),
dniTitular bigint not null foreign key references usuarios(documento), 
fechaEntrega datetime not null,
-- horaEntrega
fechaBaja datetime null default null,
-- horaBaja
idMotivoBaja int null foreign key references motivosBaja(id)
);

go
create table viajes(
idLine int not null foreign key references lineas(linea),
idInterno int not null foreign key references internos(id),
tarjeta bigint not null foreign key references tarjetas(numeroTarjeta)
);