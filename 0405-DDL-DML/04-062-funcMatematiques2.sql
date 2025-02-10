-- Exercici 4.62: Funcions matemàtiques (2)

-- A partir de les dades de països, has de mostrar:

-- L'esperança de vida (LifeExpectancy) truncada.

SELECT name, TRUNC(LifeExpectancy) FROM country;

-- L'esperança de vida (LifeExpectancy) arredonida a una xifra decimal.

SELECT name, ROUND(LifeExpectancy, 1) FROM country;

-- Nom, continent i any d'independència (o el text "Desconegut", en comptes de NULL, si esta dada no es coneix).

-- SQLite
SELECT name, continent, IFNULL(indepYear,'Desconegut') FROM country;

-- Oracle
SELECT name, continent, NVL(TO_CHAR(indepYear),'Desconegut') FROM country;
