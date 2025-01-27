create table empleats
(
    codi varchar(5) primary key,
    nom varchar(25),
    codiCap varchar(5)
);

insert into empleats values ('pep', 'pepe', null);
insert into empleats values ('alb', 'alberto', 'pep');
insert into empleats values ('nac', 'nacho', null);
insert into empleats values ('jos', 'josé', 'nac');

-- Empleats que tenen cap

select e.nom, cap.nom 
from empleats e, empleats cap
where e.codiCap = cap.codi;

-- Empleats, tinguen cap o no

select e.nom, cap.nom 
from empleats e left join empleats cap
on e.codiCap = cap.codi;
