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

-- Procedimientos almacenados 
 
-- Realizar los siguientes procedimientos almacenados: 
 
/*
A) Realizar un procedimiento almacenado llamado sp_Agregar_Usuario que permita registrar un 
usuario en el sistema. El procedimiento debe recibir como parámetro DNI, Apellido, Nombre, 
Fecha de nacimiento y los datos del domicilio del usuario. 
*/

go
create procedure sp_Agregar_Usuario (
@apellido varchar(100),
@nombre varchar(100),
@dni varchar(8), 
@fec_nac datetime,
@domicilio varchar(200)
)
as
begin
insert into usuarios (apellido, nombre, dni, fec_nac, domicilio, saldo_ultima, estado) 
values (@apellido, @nombre,@dni, @fec_nac, @domicilio, 0, 1);
end

go
exec sp_Agregar_Usuario 'Ruiz', 'Norman', '27846268', '02/04/1980', 'Muñoz 2964'

go
select * from usuarios

/*
B) Realizar un procedimiento almacenado llamado sp_Agregar_Tarjeta que dé de alta una 
tarjeta. El procedimiento solo debe recibir el DNI del usuario. 
Como el sistema sólo permite una tarjeta activa por usuario, el procedimiento debe: 
- Dar de baja la última tarjeta del usuario (si corresponde). 
- Dar de alta la nueva tarjeta del usuario 
- Traspasar el saldo de la vieja tarjeta a la nueva tarjeta (si corresponde)
*/

create procedure sp_Agregar_Tarjeta(
@dni varchar(8)
)
as
begin
declare @idUsuario bigint
set @idUsuario = (select id from usuarios as u where u.dni = @dni)
declare @idTarjeta bigint
set @idTarjeta = (select t.id from tarjetas as t where t.idUsuario = @idUsuario and t.estado = 1)
declare @num_tarjeta bigint
set @num_tarjeta = (select isnull(max(t.num_tarjeta),0) from tarjetas as t)
begin try
begin transaction
update tarjetas set estado = 0 where tarjetas.id = @idTarjeta;
insert into tarjetas (num_tarjeta, idUsuario, fec_alta, estado) values ((@num_tarjeta + 1),@idUsuario,GETDATE(),1)
if (isnull((select u.fec_pri_tar from usuarios as u where u.id = @idUsuario),1) = 1)
begin
update usuarios set fec_pri_tar = GETDATE() where id = @idUsuario;
end
commit transaction
end try
begin catch
rollback transaction
raiserror('Algo salio mal',16,1)
end catch
end

exec sp_Agregar_Tarjeta '27846268'

/* 
C) Realizar un procedimiento almacenado llamado sp_Agregar_Viaje que registre un viaje a una 
tarjeta en particular. El procedimiento debe recibir: Número de tarjeta, importe del viaje, nro de 
interno y nro de línea. 
El procedimiento deberá: 
- Descontar el saldo 
- Registrar el viaje 
- Registrar el movimiento de débito 
 
NOTA: Una tarjeta no puede tener una deuda que supere los $10. 
*/

create procedure sp_Agregar_Viaje(
@num_tarjeta bigint,
@importe money,
@num_interno varchar(3),
@linae varchar(3)
)
as
begin
begin try
begin transaction
declare @idUsuario bigint
set @idUsuario = (select u.id from usuarios as u inner join tarjetas as t on t.idUsuario = u.id where t.num_tarjeta = @num_tarjeta)
declare @saldo money
set @saldo = (select u.saldo_ultima from usuarios as u where u.id = @idUsuario)
declare @idTarjeta bigint
set @idTarjeta = (select t.id from tarjetas as t where t.num_tarjeta = @num_tarjeta)
declare @idInterno bigint
set @idInterno = (select i.id from internos as i where i.num_interno = @num_interno) 
if(@saldo > (-10 + @importe))
begin
update usuarios set saldo_ultima = (saldo_ultima - @importe) where id = @idUsuario
end
else
begin
raiserror('Saldo insuficiente', 16,3)
end
insert into viajes (fecha_hora, idInterno, idTarjeta, importe) values (GETDATE(),@idInterno, @idTarjeta, @importe)
insert into registros (fecha_hora, idTarjeta, importe, tipo_movimiento ) values (GETDATE(), @idTarjeta, @importe,'D')
commit transaction
end try
begin catch
rollback transaction
end catch
end

exec sp_Agregar_Viaje 1, 15, 167, 303

 /*
D) Realizar un procedimiento almacenado llamado sp_Agregar_Saldo que registre un 
movimiento de crédito a una tarjeta en particular. El procedimiento debe recibir: El número de 
tarjeta y el importe a recargar. 
*/

create procedure sp_Agregar_Saldo(
@num_tarjeta bigint,
@importe money
)
as
begin
begin try
declare @idUsuario bigint
set @idUsuario = (select u.id from usuarios as u inner join tarjetas as t on t.idUsuario = u.id where t.num_tarjeta = @num_tarjeta)
update usuarios set saldo_ultima = (saldo_ultima + @importe) where id = @idUsuario
end try
begin catch
raiserror('No se pugo cargar el credito.', 16, 2)
end catch
end

exec sp_Agregar_Saldo 1, 500

/*
E) Realizar un procedimiento almacenado llamado sp_Baja_Fisica_Usuario que elimine un usuario 
del sistema. La eliminación deberá ser 'en cascada'. Esto quiere decir que para cada usuario 
primero deberán eliminarse todos los viajes y recargas de sus respectivas tarjetas. Luego, todas 
sus tarjetas y por último su registro de usuario. 
*/  

create procedure sp_Baja_Fisica_Usuario(
@dni varchar(8)
)
as
begin



end

exec sp_Baja_Fisica_Usuario
