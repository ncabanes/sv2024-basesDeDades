-- DIRECTOR(dniDirector, nomDirector, codiProjecte, denominacióProjecte)
-- C.P.: dniDirector
-- C.Alt.: codiProjecte

--Sergio y Sergio

create table director(
    dniDirector vachar(9) primary key, 
    nomDirector varchar(30), 
    codiProjecte varchar(10) unique, 
    nomProjecte varchar(30)
);

insert into director values (
    '45454545F', 
    'Nacho C.', 
    '8989898', 
    'Juan de Dios'
);

select * from director;

insert into director values (
    '45454545F', 
    'Pepe', 
    ' 455656', 
    'No le pidas peras al olmo'
);
Runtime error: UNIQUE constraint failed: director.dniDirector (19)

--Aquí comprobamos que la clave primaria esta bien puesta ya que no nos deja repetir el valor de dniDirector.

insert into director values (
    '1234587F', 
    'Nacho C.', 
    '8989898', 
    'No le pidas peras al olmo'
);
Runtime error: UNIQUE constraint failed: director.codiProjecte (19)

--Aquí comprobamos que la clave alterna esta bien puesta ya que no nos deja repetir el valor de codiProjecte.

--Parece que funciona
