-- EQUIP (codi, nom)
-- CP: codi
-- 
-- PARTIT (codiEquipLocal, codiEquipVisitant, puntsLocal, puntsVisitant)
-- CP: (codiEquipLocal, codiEquipVisitant)
-- C.AJ: codiEquipLocal -> EQUIP
-- C.AJ: codiEquipVisitant -> EQUIP

-- Álvaro y Miguel

create table equip(codi varchar(10) primary key, nom varchar(30));

insert into equip values ('sv', 'Sant Vicent');
insert into equip values ('a', 'Alacant');

create table partit(
    codiEquipLocal varchar(10),
    codiEquipVisitant varchar(10),
    puntsLocal numeric(3),
    puntsVisitant numeric(3),
    primary key (codiEquipLocal,codiEquipVisitant),
    foreign key (codiEquipLocal) references equip(codi),
    foreign key (codiEquipVisitant) references equip(codi));

insert into partit values ('sv', 'a', 105, 86);

