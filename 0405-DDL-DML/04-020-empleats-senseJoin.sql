
-- Prova la consulta que demana tota la informació d'empleats i departaments 
-- (SELECT * FROM empleats, departaments;). Comprova si la informació que se
-- mostra sembla correcta.

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

SELECT * FROM empleats, departaments;
