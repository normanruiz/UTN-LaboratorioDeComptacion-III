/*
Sabiendo que: 
- La pizza se identifica con un código autonumérico. 
- El ingrediente se identifica con un código autonumérico. 
- Las pizzas deben registrar el precio de venta y un nombre comercial. 
- Los ingredientes deben registrar un nombre. 
- Para cada ingrediente de una pizza se debe registrar la cantidad utilizada en formato 
Decimal (6, 2) y un tipo de ingrediente que debe estar relacionado con la tabla Tipos 
Ingredientes. 
*/

create database bdPizzas
go
use bdPizzas
go


create table ingredientes(
id bigint identity(1,1) primary key,
ingrediente varchar(100) not null
);

create table pizzas(
id bigint identity(1,1) primary key,
nombre varchar(100) not null,
precio money not null,
);
create table tipoDeIngrediente(
id int identity(1,1) primary key,
tipo varchar(100) not null
);

create table ingredientesXPizza(
idPizza bigint not null foreign key references pizzas(id),
idIngrediente bigint not null foreign key references ingredientes(id),
cantidad decimal(6,2) not null,
idTipoIngrediente int not null foreign key references tipoDeIngrediente(id)
);