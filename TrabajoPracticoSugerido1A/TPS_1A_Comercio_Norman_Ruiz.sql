/*
Universisas Tecnologica Nacional
General pacheco
Laboratorio de Computacioon III
Profesor: Angel Simon
A�o 2018
Segundo cuatrimestre
Turno Noche
Alumno Norman Ruiz
Trabajo Practico N�1A
*/

/*
Trabajo pr�ctico sugerido 1A�
�
Normalizaci�n y creaci�n de tablas y relaciones por c�digo�
�
Un negocio que se dedica a vender art�culos de librer�a desea registrar la informaci�n de sus�
art�culos, ventas, clientes y vendedores.�
Por cada art�culo, actualmente requieren la siguiente informaci�n:�
�
- C�digo �nico de art�culo: AAA111�
- Descripci�n: Marcador color negro�
- Marca: Sharpie�
- Precios: $ 5.5 (de compra) y $ 9.5 (de venta)�
- Ganancia: $ 4�
- Tipo de art�culo: Art�culo de oficina�
- Stock: 10 (actual) y 2 (stock m�nimo)�
- Stock por encima del m�nimo: 8�
- Estado: Activo�
- C�digo �nico de art�culo: BBB222�
- Descripci�n: Simulcop�
- Marca: Sin marca�
- Precios: $ 0.8 (de compra) y $ 1.5 (de venta)�
- Ganancia: $ 0.7�
- Tipo de art�culo: Art�culo de oficina�
- Stock: 0 (actual) y 10 (stock m�nimo)�
- Stock por encima del m�nimo: 0�
- Estado: Inactivo�
�
Luego, registran la informaci�n de sus clientes habituales. Los datos que almacenan son: DNI,�
apellido, nombre, sexo, telefono de contacto, mail de contacto, fecha de alta al sistema, fecha de�
nacimiento, edad, direcci�n, c�digo postal, localidad y provincia.�
�
La informaci�n que registran de cada uno de sus vendedores es:�
- DNI�
- Legajo�
- Apellido y nombres�
- Sexo�
- Fecha de nacimiento�
- Edad�
- Fecha de ingreso a la empresa�
- Direcci�n�
- C�digo postal�
- Localidad�
- Provincia�
- Tel�fono�
- Sueldo�
- Total de ventas realizadas en el �ltimo mes�
- Total facturado en el �ltimo mes�
�
La librer�a, tambi�n desea registrar cada una de las ventas que se realizaron. Para ello almacena�
la siguiente informaci�n:�
�
- C�digo de factura (n�mero entero correlativo)�
- Fecha de la venta�
- Cliente que realiz� la compra�
- Vendedor que realiz� la venta�
- Forma de pago ('E' - Efectivo � 'T' - Tarjeta)�
- Importe total de la venta�
�
�
Para cada art�culo comprado en una venta, se almacena:�
�
- N�mero de venta�
- C�digo de art�culo�
- Descripci�n del art�culo�
- Marca�
- Precio unitario al momento de la compra�
- Cantidad comprada�
�*/

-- Actividades

-- 1 - Normalizar la base de datos. Incluir o eliminar las columnas o tablas que consideren necesarias�
--     para la normalizaci�n.�
-- 2 - Escribir en c�digo SQL, el script que genera la base de datos normalizada. Crear las tablas,�
--     columnas, relaciones y restricciones que consideren necesarias.�
-- 3 - Generar el diagrama de la base de datos.�

use master;

go
create database bd_TPS1A;

go
use bd_TP1A;

go
create table marcas(
mrc_id int not null identity(1,1) primary key,
mrc_nombre varchar(50) not null unique,

);

go
create table tipos(
tip_id int not null identity(1,1) primary key,
tip_nombre varchar(50) not null unique
);

go
create table articulos(
art_id int not null identity(1,1) primary key,
art_codigo varchar(6) not null unique,
art_descripcion varchar(50) not null,
art_precio_compra money default NULL,
art_ganancia money default NULL,
art_idTipo int not null foreign key references tipos(tip_id),
art_stock_actual int default null,
art_stock_minimo int default null,
art_estado bit default 'true'
);

go
create table marcasXarticulos(
mxa_id int not null identity(1,1),
mxa_idArt int not null foreign key references articulos(art_id),
mxa_idMrc int not null foreign key references marcas(mrc_id),
primary key (mxa_idArt,mxa_idMrc)
);

go
create table provincias(
pvc_id int not null identity(1,1) primary key,
pvc_nombre varchar(100) not null unique
);

go
create table localidades(
lcd_id int not null identity(1,1),
lcd_codPostal varchar(4) not null primary key,
lcd_Nombre varchar(100) not null,
lcd_idProvincia int not null foreign key references provincias(pvc_id)
);

go
create table clientes(
cln_id int not null identity(1,1) primary key,
cln_DNI varchar(8) not null unique,�
cln_apellido varchar(100) not null,
cln_nombre varchar(100) not null,
cln_sexo bit not null, -- 0 = hombre, 1 = mujer
cln_telefono varchar(15) not null unique,
cln_correo varchar(100) not null unique,
cln_fecAlta date not null,
cln_fecNacimiento date not null,
cln_direccion varchar(100) not null,
cln_codPostal varchar(4) not null foreign key references localidades(lcd_codPostal)
);

go
create table vendedores(
vnd_id int not null identity(1,1) primary key,
vnd_DNI varchar(8) not null unique,�
vnd_Legajo� varchar(6) not null unique,
vnd_Apellido varchar(100) not null,
vnd_nombres�varchar(100) not null,
vnd_Sexo�bit not null, -- 0 = hombre, 1 = mujer
vnd_fecNacimiento�date not null,
vnd_fecIngreso date not null,
vnd_Direccion�varchar(100) not null,
vnd_codPostal�varchar(4) not null foreign key references localidades(lcd_codPostal),
vnd_telefono�varchar(15) not null unique,
vnd_sueldo�money not null
);

go
create table ventas(
vnt_codFactura int not null identity(1,1) primary key,
vnt_fecVenta� date not null,
vnt_idCliente int not null foreign key references clientes(cln_id),
vnt_idVendedor int not null foreign key references vendedores(vnd_id),
vnt_Pago char not null check(vnt_Pago = 'E' or vnt_Pago = 'T') -- ('E' - Efectivo � 'T' - Tarjeta)�
);

create table articulosXventa(
axv_id int not null identity(1,1) primary key,
axv_numFac int not null foreign key references ventas(vnt_codFactura),
axv_idArticulo  int not null foreign key references articulos(art_id),
axv_cantComprada�int not null,
axv_precio_unitario money not null
);

-- 4 - Contestar:�

-- A - �C�mo ser�a la mejor manera de indicar que un art�culo no posee Marca?�
-- Podriamos almacenar en la base de datos la marca como null y cuando se lista al encontrar un null mostrar "Sin marca" o "Generico".
-- Otra opcion podria ser cargar en la tabla marcas "Generico" y a los que no tienen marca asignarle este valor. 

-- B - �Considera correcto almacenar el Precio unitario al momento de la compra? �Por qu�?�
-- Si, ya que si deseamos listar la operacion tiempo despues cuando a variado el precio unitario del articulo los datos no seran reales si no lo tenemos registrado en nuestra venta.

-- C - �Qu� tipo de columna me permite generar un n�mero correlativo para el C�digo de factura?�
-- El tipo de dato para dicha columna puede ser tinyint, int, bigint y si lo que buscamos es la correlatividad deve ser declarada como identity.

-- D- �Qu� ocurre con las columnas Total de ventas realizadas en el �ltimo mes y Total facturado en�el �ltimo mes?
-- Estas columnas seran calculadas con los registros que se vallan agregando a la base de datos por este motivo no es lo recomendable o correcto generar columnas con dicjo proposito.