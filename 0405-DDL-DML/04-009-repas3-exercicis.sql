-- Hem decidit crear una base de dades d'exercicis, que ens ajude a repassar quan 
-- arriben les presses. De cada exercici volem anotar un codi numèric (per 
-- exemple, 101), una descripció (per exemple, "BETWEEN per a buscar entre dos 
-- valors"), una assignatura (per exemple, "Bases de dades"), una categoria (per 
-- exemple "SQL - SELECT") i un nivell de dificultat d'1 a 10 (per exemple, 5). 

-- Hauràs de:

-- Crear una única taula que permita emmagatzemar eixa informació.

CREATE TABLE exercicis
(
    codi NUMERIC(5) PRIMARY KEY,
    descripcio VARCHAR(100),
    assignatura VARCHAR(25),
    categoria VARCHAR(20),
    dificultat NUMERIC(2)
)



-- Afegir diverses dades d'exemple. Introduïx almenys un en un orde que no siga
-- el que s'ha usat per a definir la taula i almenys un altre en el qual la 
-- dificultat es deixe en blanc.

INSERT INTO exercicis VALUES(102,'SQL-SELECT','Bases de dades','SQL',7);
INSERT INTO exercicis VALUES(103,'ENTITAT RELACIO','Bases de dades','ER',6);
INSERT INTO exercicis VALUES(104,'MODEL RELACIONAL','Bases de dades','MR',7);
INSERT INTO exercicis VALUES(105,'NORMALITZACIO','Bases de dades','normalitzacio',NULL);

INSERT INTO exercicis (descripcio,assignatura,categoria,dificultat,codi) 
    VALUES('SQL-INSERT','Bases de dades','SQL',7,106);

-- Mostrar:
-- Totes les dades.
-- Les dades de l'assignatura "Bases de dades".
-- Les dades de l'assignatura "Bases de dades" amb una dificultat de 6 o superior.
-- Les dades de l'assignatura "Bases de dades" amb una dificultat entre 6 i 8 (de dos formes distintes).
-- Les dades de l'assignatura "Bases de dades" amb una dificultat de 6 o de 7.
-- Les dades que continguen la paraula "SELECT" en la seua descripció.
-- Les dades per als quals no coneguem la dificultat.

