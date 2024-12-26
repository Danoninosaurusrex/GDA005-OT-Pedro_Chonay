 --create database  [GDA005-OT-Pedro_Chonay];

create table Rol (
Id_Rol int not null
constraint Pk_Id_Rol primary key,
Nombre varchar (45)
);
insert into Rol (Id_Rol, Nombre) values 
(1,'Super-Operador'),
(2,'Operador');



create table Estados(
Id_Estados int not null
constraint Pk_Id_Estados primary key,
Estado varchar (50)
);
insert into Estados (Id_Estados, Estado) values
(0, 'Inactivo'),
(1, 'Activo');



create table Categoria_Productos (
Id_Categoria int identity not null
constraint Pk_Id_Categoria primary key,
Nombre Varchar (45),
Estados int
constraint Fk_Id_Estados_C foreign key
references Estados(Id_Estados)
);


create table Productos(
Id_Productos int identity not null
constraint Pk_Id_Productos primary key,
CategoriaProductos int 
constraint Fk_Id_Categoria foreign key
references Categoria_productos(Id_Categoria),
nombre varchar (30),
marca varchar (45),
codigo varchar (45),
stock float,
estados int
constraint Fk_Id_Estados foreign key 
references Estados(Id_Estados),
precio Float,
F_creacion datetime 
constraint Dt_F_create default getdate(),
foto NVARCHAR(MAX)
);


create table Clientes(
Id_Clientes int identity not null
constraint Pk_Id_Clientes primary key,
Id_usuarios int 
constraint Fk_Id_UsuariosC foreign key 
references Usuarios(Id_Usuarios), 
Razon_Social varchar (100),
Nombre_Comercial varchar (50),
Direccion_Entrega varchar (70),
Telefono varchar (15),
Email varchar (45),
Estados int constraint Fk_Estado foreign key 
 references Estados(Id_Estados)
);


create table Usuarios(
Id_Usuarios int identity not null
constraint Pk_Id_Usuarios primary key,
Rol int 
constraint  Fk_Id_Rol foreign key
references Rol(Id_Rol),
Estados int not null
constraint Fk_Id_Estados_U foreign key
references Estados(Id_Estados),
Email varchar (50),
Nombre_completo varchar (50),
clave varchar (45),
Telefono varchar (15),
Fecha_Nacimiento date,
Fecha_Creacion datetime
constraint dt_FechaCreacion default getdate(),
);


create table Orden (
Id_Orden int identity not null
constraint Pk_Id_Orden primary key,
Orden_Num int, 
Usuarios int 
constraint Fk_Id_Usuarios_O foreign key
references Usuarios(Id_Usuarios),
Estados int not null
constraint Fk_Id_Estados_O foreign key (Estados)
references Estados(Id_Estados),
F_Creacion datetime
constraint Dt_F_Orden default getdate(),
Nombre_Completo varchar (50),
Direccion varchar (50),
Telefono varchar (50),
Email varchar (50),
Fecha_Entrega date,
Total_Orden float
);


create table Orden_Detalles(
Id_Orden_Detalles int identity not null
constraint Pk_Id_Orden_Detalles primary key,
Orden int 
constraint Fk_Id_Orden foreign key
references Orden(Id_Orden),
Productos int 
constraint Fk_Id_Productos foreign key
references Productos(Id_Productos),
Cantidad int,
Precio Float,
Subtotal Float
);


/*
		Procesos Almacenados de creacion, edicion y eliminacion de filas
		de cada tabla, estan agrupados por la tabla que se desea modificar.
*/

--PROC DE TABLA USUARIOS
--Crear
create or alter proc dbo.Pa_NewUser
@Rol int , 
@Email varchar (30) ,
@N_completo varchar (40) ,
@Clave varchar (40) ,
@Telefono varchar (15) ,
@N_Fecha date ,
@Cliente int

as
	begin 
	if exists (select 1 from Rol where @Rol = Id_Rol)
		begin 
			insert into Usuarios(Nombre_completo, Fecha_Nacimiento, Telefono, Email, clave, Estados, Rol, Clientes) 
			values (@N_completo, @N_Fecha, @Telefono, @Email, @Clave, 1 , @Rol, @Cliente)
		end
	else 
		begin 
			print 'Rol invalido'; 
		end
	end;

 exec dbo.Pa_NewUser
	@N_completo = 'Juli Iglesias', 
	@N_Fecha = '1621-11-01', 
	@Telefono = '123556789', 
	@Email = 'CorreoNo3/@gimal.com', 
	@Clave = 'sintra;a123', 
	@Rol = 5,
	@cliente = 2;

--Leer
--Todos los usuarios
create or alter proc dbo.AllUsers
as
	begin 
	select Id_Usuarios, Rol, Estados, Email, Nombre_completo, clave, Telefono, Fecha_Nacimiento from Usuarios
end;

exec dbo.AllUsers

--Un usuario
create or alter proc dbo.OneUser
@Id int

as
	begin 
	select Id_Usuarios, Rol, Estados, Email, 
	Nombre_completo, clave, Telefono, Fecha_Nacimiento from Usuarios
	where @Id = Id_Usuarios;
	end;

exec dbo.OneUser
@Id = 1;

--Editar
create or alter proc dbo.EditUser
@IdUsuario int,
@Rol int null , 
@Email varchar (30) null ,
@N_completo varchar (40) null ,
@Clave varchar (40) null,
@Telefono varchar (15) null,
@N_Fecha date null,
@Cliente int null

as 
	begin
		update Usuarios 
		set Rol = coalesce (@Rol,Rol),
			Nombre_completo = coalesce (@N_completo, Nombre_completo), 
			Fecha_Nacimiento = coalesce ( @N_Fecha, Fecha_Nacimiento) ,
			Telefono = coalesce (@Telefono, Telefono ),
			Email = coalesce (@Email, Email),
			Clave = coalesce (@Clave, clave ),
			Clientes = coalesce (@Cliente, Clientes)
		where @IdUsuario = Id_Usuarios;
	end;

exec dbo.EditUser
@IdUsuario = 4,
@Rol = 1 , 
@Estado = 0,
@Email = null,
@N_completo = null,
@Clave= 'C0ntrasenamasegura',
@Telefono = null,
@N_Fecha = null,
@Cliente = 2 ;
		


--Borrar 
create or alter proc dbo.DeleteUser 
@IdUsuario int 
as 
	begin   
		update Usuarios
		set Estados = 0
		where Id_Usuarios = @IdUsuario; 
	end;


exec dbo.DeleteUser @IdUsuario = 6;
 


--PROC DE TABLA PRODUCTOS
--Crear
create or alter proc dbo.New_Produ
@Categ_Prod int,
@Name varchar (30),
@Brand varchar (30),
@Codigo varchar (30),
@Stock int ,
@Img binary,
@Precio float

as 
	begin	
		insert into Productos (CategoriaProductos, nombre, marca, codigo, stock, estados, precio, foto)
		values (@Categ_Prod, @Name, @Brand, @Codigo, @Stock, 1 ,@Precio, @Img)
	end;

exec dbo.New_Produ
@Categ_Prod = 6, 
@Name = 'Piano', 
@Brand = 'Yamaha', 
@Codigo = 'P14N0', 
@Stock = 650,  
@Precio = 500.85,
@Img = '10101100'
;

--Leer 
	--Todos los productos
create or alter proc dbo.All_Products
as begin
	select nombre, marca, stock, codigo, precio, foto
	from Productos;
	end;

exec All_Products;

	-- Producto en especifico 
create or alter proc dbo.ProductByName
    @NombreProducto varchar(30)
as
begin
    select nombre, marca, stock, codigo, precio, foto
    from Productos
    where lower(nombre) like lower('%' + @NombreProducto + '%');
end;

exec ProductByName
@NombreProducto = "Aceite";

--Editar
create or alter proc dbo.Edit_Produ
@Id_Prod int,
@Categ_Prod int null,
@Name varchar (30) null,
@Brand varchar (30) null,
@Codigo varchar (30) null,
@Stock int null ,
@Img binary null,
@Precio float null

as 
	begin Update Productos
		set 
			CategoriaProductos = coalesce (@Categ_Prod, CategoriaProductos), 
			nombre = coalesce (@Name, nombre), 
			marca = coalesce (@Brand , marca), 
			codigo = coalesce (@Codigo , codigo), 
			stock = coalesce (@Stock , stock),  
			precio = coalesce (@Precio , precio), 
			foto = coalesce (@Img , foto)
		where @Id_Prod = Id_Productos;
	end; 

exec dbo.Edit_Produ
@Id_Prod = 8,
@Categ_Prod = null,
@Name = null,
@Brand = null,
@Codigo = null,
@Stock = null ,
@Img = null,
@Precio = null;



--Elimnar 
create or alter proc dbo.DeleteProduct
@IdProducto int 

as 
	begin 
		update Productos
		set estados = 0
		where Id_Productos = @IdProducto;
	end;

exec dbo.DeleteProduct @IdProducto = 6;


--PROC DE TABLA ORDEN-DETALLESORDEN
--Crear
CREATE OR ALTER PROCEDURE dbo.New_OrderD
    @Usuario INT,
    @N_completo VARCHAR(50),
    @Direccion VARCHAR(50),
    @Telefono VARCHAR(15),
    @Email VARCHAR(40),
    @F_Entrega DATE,
    @DetallesOrden NVARCHAR(MAX) 
as
begin
    begin transaction;

    begin try
        declare @Subtotal_O FLOAT,
                @Total_O FLOAT,
                @Comision FLOAT,
                @Id_Orden INT;

        insert into Orden (Usuarios, Estados, Nombre_Completo, Direccion, Telefono, Email, Fecha_Entrega, Total_Orden)
        values (@Usuario, 1, @N_completo, @Direccion, @Telefono, @Email, @F_Entrega, 0);

        set @Id_Orden = SCOPE_IDENTITY();

        insert into Orden_Detalles (Orden, Productos, Cantidad, Precio, Subtotal)
        select 
            @Id_Orden, 
            od.Productos, 
            od.Cantidad, 
            p.precio, 
            od.Cantidad * p.precio as Subtotal
        from 
            OPENJSON(@DetallesOrden)
            WITH (
                Productos INT,
                Cantidad INT
            ) AS od
        JOIN 
            Productos p ON od.Productos = p.Id_Productos;

        SELECT @Subtotal_O = SUM(Subtotal) FROM Orden_Detalles
        WHERE Orden = @Id_Orden;

        SET @Comision = @Subtotal_O * 0.10;
        SET @Total_O = @Comision + @Subtotal_O;

        UPDATE Orden
        SET Total_Orden = @Total_O
        WHERE Id_Orden = @Id_Orden;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;

exec dbo.New_OrderD
    @Usuario = 123, 
    @N_completo = 'Juan Pérez', 
    @Direccion = 'Calle Falsa 123', 
    @Telefono = '555-1234', 
    @Email = 'juan.perez@example.com', 
    @F_Entrega = '2024-12-31', 
    @DetallesOrden = '[{"Productos":1,"Cantidad":2},{"Productos":2,"Cantidad":3}]';

	--Leer
---Leer todas las ordenes
create or alter proc dbo.AllOrders
as
	begin 
	select * from Orden
	end;

exec dbo.AllOrders;

--Leer una orden
create or alter proc dbo.OneOrder
@IdOrder int
as
	begin
	select * from Orden where @IdOrder = Id_Orden;
	end;

exec dbo.OneOrder
@IdOrder = 3;

--Editar
create or alter proc dbo.Edit_Order
@IdOrden int, 
@Usuario int null,
@N_completo varchar (50) null,
@Direccion varchar (50) null,
@Telefono varchar (15) null,
@Email varchar (40) null,
@F_Entrega date null 

as
	begin update Orden
		set Usuarios = coalesce (@Usuario , Usuarios), 
			Nombre_Completo = coalesce (@N_completo , Nombre_Completo), 
			Direccion = coalesce (@Direccion , Direccion), 
			Telefono = coalesce (@Telefono , Telefono), 
			Email = coalesce (@Email , Email), 
			Fecha_Entrega = coalesce (@F_Entrega , Fecha_Entrega)
		where @IdOrden = Id_Orden;
	end;

exec dbo.Edit_Order
	@IdOrden = 9,
	@Num_O = null,
	@Usuario = null, 
	@N_completo = 'Juan Comalapo pez Payaso',
	@Direccion = 'Av. Siempre Viva 123 z9', 
	@Telefono = '555-5533', 
	@Email = 'ju.an.perez@example.com', 
	@F_Entrega = null;

--Eliminar 
create or alter proc dbo.DeleteOrder
@IdOrder int 

as 
	begin 
		update Orden
		set Estados = 0
		where Id_Orden = @IdOrder;
	end;

exec dbo.DeleteOrder @IdOrder = 11 ;

--PROC DE TABLA ESTADOS
--Crear
create or alter proc dbo.newEst 
@Id_Estado int,
@Estado varchar (15)

as 
	begin 
		insert into Estados (Id_Estados, Estado)
		values (@Id_Estado, @Estado);
	end;

exec dbo.newEst
@Id_Estado = 0,
@Estado = 'Inactivo';

--Leer
	--todos los estados
create or alter proc dbo.All_Status
as begin
	select * from Estados
	end;

exec dbo.All_Status;
	
	--Un Estado
create or alter proc dbo.StatusbyId
@IdEstado int 
as begin
	select * from Estados
	where Id_Estados = @IdEstado ;
	end	;

exec dbo.Statusbyname
@IdEstado = '2';

--Editar
create or alter proc dbo.EditEst 
@Id_Estado int null,
@Estado varchar (15) null

as 
	begin update Estados
		set 
			Estado = @Estado
		where Id_Estados = @Id_Estado;
	end;

exec dbo.EditEst
@Id_Estado = 0,
@Estado = 'MegaActivo';
                                                                    
--Eliminar 
create or alter proc dbo.DeleteEstatus
@IdEstatus int

as 
	begin transaction;
		update Categoria_Productos set Estados = null 
		where Estados = @IdEstatus;
		delete from Estados 
		where Id_Estados = @IdEstatus;
	commit transaction;

exec dbo.DeleteEstatus @IdEstatus = 0;
 

--PROC TABLA ROL
--Crear
create or alter proc dbo.newRol
@Id_Rol int ,
@Rol varchar (30)

as
	begin 
		insert into Rol (Id_Rol, Nombre)
		values (@Id_Rol, @Rol);
	end;
	
	exec dbo.newRol
	@Id_Rol = 6,
	@Rol = 'Supremo';

--Editar
create or alter proc dbo.EditRol
@Id_Rol int ,
@Rol varchar (30)
as
	begin 
		update Rol
		set  Nombre = @Rol
		where @Id_Rol = Id_Rol;
	end;

	exec dbo.EditRol
	@Id_Rol = 6,
	@Rol = 'Menos que nada';

--Eliminar
create or alter proc dbo.DeleteRol
@IdRol int 
as
	begin transaction;
		update Usuarios set Rol = null 
		where Rol = @IdRol;
		delete from Rol 
		where @IdRol = Id_Rol;
	commit transaction;

exec dbo.DeleteRol @IdRol = 6;



--PROC TABLA CLIENTES
--Crear
create or alter proc dbo.NewCostumer
@RazonSocial varchar (50),
@N_Comercial varchar (50),
@Direccion_entrega varchar (50),
@TelefonoC varchar (15),
@EmailC varchar (50),
@IdUser int

as 
	begin 
		insert into Clientes (Razon_Social, Nombre_Comercial, Direccion_Entrega, Telefono, Email, Id_Usuarios)
		values (@RazonSocial, @N_Comercial, @Direccion_entrega, @TelefonoC, @EmailC, @IdUser);
	end;

exec dbo.NewCostumer
@RazonSocial = 'Instrumental de occidente',
@N_Comercial = 'Trompetilla Dorada',
@Direccion_entrega = 'Av. Nunca Viva 123',
@TelefonoC = '757575757',
@EmailC  = 'emaildeejempo.2@gmail.com',
@IdUser = null;

--Read 
create or alter proc dbo.All_Costumer
as 
	begin 
	select * from Clientes;
	end;

exec dbo.All_Costumer;

--Editar
create or alter proc dbo.EditCostumer
@IdCliente int, 
@RazonSocial varchar (50) null,
@N_Comercial varchar (50) null,
@Direccion_entrega varchar (50) null,
@TelefonoC varchar (15) null,
@EmailC varchar (50) null,
@IdUser int null

as
	begin
		update Clientes
		set 
			Razon_Social = coalesce (@RazonSocial , Razon_Social), 
			Nombre_Comercial = coalesce (@N_Comercial , Nombre_Comercial), 
			Direccion_Entrega = coalesce (@Direccion_entrega , Direccion_Entrega), 
			Telefono = coalesce (@TelefonoC ,Telefono), 
			Email = coalesce (@EmailC , Email), 
			Id_Usuarios = coalesce (@IdUser,Id_Usuarios)
		where @IdCliente = Id_Clientes;
	end;

exec dbo.EditCostumer
@IdCliente = 2,
@RazonSocial = null,
@N_Comercial = 'Trompetilla Plateada',
@Direccion_entrega = 'Av. Nunca Viva 123 z9',
@TelefonoC = '6257-8900',
@EmailC  = null,
@IdUser = null;

--Delete Clientes
create or alter proc dbo.DeleteCostumer
@IdCliente int 

as
	begin transaction;
		update Usuarios set Clientes = null 
		where Clientes = @IdCliente;
		delete from Clientes 
		where Id_Clientes = @IdCliente;
	commit transaction;


 exec dbo.DeleteCostumer @Idcliente = 6;


--PROC TABLA CATEGORIA-PRODUCTOS
--Crear
create or alter proc dbo.NewCateg
@NombreCateg varchar (30)

as
	begin 
		insert into Categoria_Productos (Nombre)
		values ( @NombreCateg);
	end;

exec dbo.NewCateg
@NombreCateg = 'Viento plastico';

--Leer
	--Todas las categorias
create or alter proc dbo.AllCateg
as
	begin 
	select * from Categoria_Productos;
	end;

exec dbo.AllCateg

	--Una Categoria
create or alter proc dbo.OneCateg
@Id int
as
	begin 
	select * from Categoria_Productos where Id_Categoria = @Id;
	end;

exec dbo.OneCateg
@Id = 3;

--Editar
create or alter proc dbo.EditCateg
@IdCateg int,
@NombreCateg varchar (30)

as
	begin update Categoria_Productos
		set 
			Nombre = coalesce (@NombreCateg , Nombre)
		where @IdCateg = Id_Categoria;
	end;

exec dbo.EditCateg
@IdCateg = 7,
@NombreCateg = 'Electronico';

--Eliminar
create or alter proc dbo.DeleteCateg
@IdCateg int 

as
	begin update Categoria_Productos
		set Estados = 0
		where @IdCateg = Id_Categoria;
	end;

exec dbo.DeleteCateg @IdCateg = 5;

/*
		Las vistas estan identificadas con la letra que se mostro en los 
		requisitos de la parte del proyecto
*/

--Vista "A"
create or alter view V_PDisponibles
as
select COUNT(*)as 'Productos disponibles'
from Productos where estados = 1 and stock > 0;

select * from V_PDisponibles;

--Vista "B"
--Utiliza fecha de creacion (getdate)
create or alter view V_TotalMoneyORdenes
as 
	select sum(Total_Orden) as 'Total en quetzales de ordenes 8/2024'
	from Orden where MONTH (F_Creacion) = 08 and YEAR (F_Creacion) = 2024;

	select * from V_TotalMoneyORdenes;

--Utiliza fecha de  entrega 
create or alter view V_TotalMoneyORdenesEntrega
as 
	select sum (Total_Orden) as 'Total en quetzales de ordenes 8/2024'
	from Orden where MONTH (Fecha_Entrega) = 08 and YEAR (Fecha_Entrega) = 2024;

	select * from V_TotalMoneyORdenesEntrega;

--Vista "C"
create or alter view V_Top10Clientes
as 
	select top 10 
	Clientes.Id_Clientes, 
	Clientes.Razon_Social, 
	Clientes.Nombre_Comercial,
	sum (Orden.Total_Orden) as Total_compras 
	from Clientes 
	Join Orden on Clientes.Id_Usuarios = Orden.Usuarios
	group by Clientes.Id_Clientes, 
	Clientes.Razon_Social, 
	Clientes.Nombre_Comercial
	order by Total_compras desc;

	select * from V_Top10Clientes;

--Vista "D"
create or alter view V_Top10Prodcutos
as 
	select top 10
	Productos.Id_Productos,
	Productos.nombre,
	Productos.marca,
	sum(Orden_Detalles.Cantidad) as Mas_Vendidos
	from Productos
	join Orden_Detalles on Orden_Detalles.Productos = Productos.Id_Productos
	group by 
	Productos.Id_Productos,
	Productos.nombre,
	Productos.marca
	order by Mas_Vendidos  asc;

	select * from V_Top10Prodcutos;