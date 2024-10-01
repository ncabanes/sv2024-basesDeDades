.open equips

create table equips(codi varchar(5) primary key, 
    nom varchar(30));
insert into equips values ('RMD','Real Madrid');
insert into equips values ('FCB','Futbol Club Barcelona');

create table jugadors(codi numeric(8) primary key, 
    nom varchar(50), codiEquip varchar(5));
insert into jugadors values (1,'Vinicius','RMD');
insert into jugadors values (2,'Mbappe','RMD');
insert into jugadors values (3,'Pedri','FCB');
insert into jugadors values (4,'Ferran','FCB');

-- Dades, forma incorrecta

select jugadors.nom, equips.nom 
from jugadors, equips;

-- Dades, forma correcta

select jugadors.nom, equips.nom 
from jugadors, equips 
where jugadors.codiEquip = equips.codi;
