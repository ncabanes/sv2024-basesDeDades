CREATE TABLE departaments ( 
  codi NUMERIC(3) PRIMARY KEY, 
  nom VARCHAR(20)
);

CREATE TABLE empleats ( 
  codi VARCHAR(5) PRIMARY KEY, 
  nom VARCHAR(25),
  codiDepartament NUMERIC(3)
);

INSERT INTO departaments VALUES (11, 'Vendes');
INSERT INTO departaments VALUES (12, 'Enginyeria');
INSERT INTO departaments VALUES (13, 'Producció');
INSERT INTO departaments VALUES (14, 'Màrqueting');

INSERT INTO empleats VALUES ('jo', 'Joan', 14);
INSERT INTO empleats VALUES ('la', 'Laia', 11);
INSERT INTO empleats VALUES ('ar', 'Ariadna', 15);
INSERT INTO empleats VALUES ('al', 'Albert', NULL);

-- A partir de les dades de departaments i empleats:

-- Afig un departament amb codi 20 i nom Joan.

INSERT INTO departaments VALUES (20, 'Joan');

--  Mostra noms de departaments i empleats, en una única llista.

SELECT nom FROM empleats
UNION
SELECT nom FROM departaments;

--  Mostra noms d'empleats que coincidisquen amb el nom d'algun departament.

SELECT nom FROM empleats
INTERSECT
SELECT nom FROM departaments;

--  Mostra noms d'empleats que no coincidisquen amb el nom d'algun departament.

-- SQLite i Oracle

SELECT nom FROM empleats
EXCEPT
SELECT nom FROM departaments;

-- Només Oracle

SELECT nom FROM empleats
MINUS
SELECT nom FROM departaments;
