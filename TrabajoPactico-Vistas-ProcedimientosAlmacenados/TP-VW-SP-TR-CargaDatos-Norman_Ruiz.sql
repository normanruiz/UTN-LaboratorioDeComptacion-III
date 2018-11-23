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

use db_sube;

-- Carga de usuarios

insert into usuarios (apellido, nombre, dni, fec_nac, domicilio, saldo_ultima, estado) 
values ('Ruiz','Norman','27846268','02/04/1980','Muñoz 2964', 0, 1);
insert into usuarios (apellido, nombre, dni, fec_nac, domicilio, saldo_ultima, estado) 
values ('Ruiz','Micaela','27846268','02/04/1980','Muñoz 2964', 0, 1);
insert into usuarios (apellido, nombre, dni, fec_nac, domicilio, saldo_ultima, estado) 
values ('Ruiz','Carlos','27846268','02/04/1980','Muñoz 2964', 0, 1);
insert into usuarios (apellido, nombre, dni, fec_nac, domicilio, saldo_ultima, estado) 
values ('Ruiz','Samanta','27846268','02/04/1980','Muñoz 2964', 0, 1);

-- Carga de lineasDeColectivos

insert into lineasDeColectivos (cod_linea, nombre_empresa,dom_legal,num_interno)
values ('303','Papagallo','Peron 1234','167');
insert into lineasDeColectivos (cod_linea, nombre_empresa,dom_legal,num_interno)
values ('163','Papagallo','Peron 1234','124');
insert into lineasDeColectivos (cod_linea, nombre_empresa,dom_legal,num_interno)
values ('176','Papagallo','Peron 1234','301');
insert into lineasDeColectivos (cod_linea, nombre_empresa,dom_legal,num_interno)
values ('182','Papagallo','Peron 1234','666');

-- Carga de tajetas

insert into tarjetas (num_tarjeta, idUsuario, fec_alta, estado)
values ('001-0000001',1,'01/06/2001',1);
insert into tarjetas (num_tarjeta, idUsuario, fec_alta, estado)
values ('001-0000002',2,'01/06/2001',1);
insert into tarjetas (num_tarjeta, idUsuario, fec_alta, estado)
values ('001-0000003',3,'01/06/2001',1);
insert into tarjetas (num_tarjeta, idUsuario, fec_alta, estado)
values ('001-0000004',4,'01/06/2001',1);


