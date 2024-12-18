--Mostra nom i plataforma dels jocs la plataforma dels quals comence per PS

SELECT nom,plataforma FROM jocs WHERE plataforma LIKE 'PS%';

--Mostra nom i plataforma dels jocs el nom dels quals acabe en A

SELECT nom,plataforma FROM jocs WHERE nom LIKE '%A';

--Mostra nom i plataforma dels jocs la plataforma dels quals tinga 3 lletres

SELECT nom,plataforma FROM jocs WHERE plataforma LIKE '___';
