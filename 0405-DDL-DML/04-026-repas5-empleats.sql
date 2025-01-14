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


-- 1. Noms dels empleats el codi de departament dels quals siga el 11, ordenats 
-- alfabèticament.

SELECT nom FROM empleats 
WHERE codiDepartament = 11
ORDER BY nom;

-- 2. Nom i codi dels empleats el nom dels quals comença per "A".

SELECT nom, codi FROM empleats 
WHERE nom LIKE 'A%'; 

SELECT nom, codi FROM empleats 
WHERE UPPER(nom) LIKE 'A%'; 

-- 3. Nom dels empleats per als quals no coneixem el departament.

SELECT nom FROM empleats 
WHERE codiDepartament IS NULL;

-- 4 i 5. Codi i nom dels departaments el codi dels quals està entre 12 i 20, 
-- de 2 formes diferents.

SELECT codi, nom FROM departaments 
WHERE codi BETWEEN 12 AND 20;

SELECT codi, nom FROM departaments 
WHERE codi >= 12 AND codi <= 20;

-- 6. Quantitat d'empleats.

SELECT COUNT(*) FROM empleats;

SELECT COUNT(*) AS quantitat FROM empleats;

-- 7. Codis de departament en els quals realment hi ha empleats, sense duplicats.

-- Mirant només en la taula d'empleats:

SELECT DISTINCT codiDepartament
FROM empleats;

-- Millor (sense nuls):

SELECT DISTINCT codiDepartament
FROM empleats
WHERE codiDepartament IS NOT NULL;

-- No cal agrupar. Alternativa innecessàriament complexa:

SELECT codiDepartament, COUNT(*)
FROM empleats
GROUP BY codiDepartament
HAVING COUNT(*) >= 1;

-- 8. Codi de cada departament que apareix en la taula d'empleats, juntament 
-- amb la quantitat d'empleats que conté.

SELECT codiDepartament, COUNT(*) FROM empleats
WHERE codiDepartament IS NOT NULL
GROUP BY codiDepartament;

-- 9. Codi de cada departament que apareix en la taula d'empleats, juntament 
-- amb la quantitat d'empleats que conté, però només per als departaments amb 2 o 
-- més empleats.

INSERT INTO empleats VALUES ('xa', 'Xavier', 14);

SELECT codiDepartament, COUNT(*) FROM empleats
WHERE codiDepartament IS NOT NULL
GROUP BY codiDepartament
HAVING COUNT(*) >= 2;

-- 10. Nom de cada empleat i nom del departament en el qual treballa.

SELECT empleats.nom, departaments.nom 
FROM empleats JOIN departaments
ON empleats.codiDepartament = departaments.codi;

SELECT empleats.nom AS empleat, departaments.nom AS depart
FROM empleats JOIN departaments
ON empleats.codiDepartament = departaments.codi;

-- Per a veure tots

SELECT empleats.nom AS empleat, departaments.nom AS depart
FROM empleats LEFT JOIN departaments
ON empleats.codiDepartament = departaments.codi;
