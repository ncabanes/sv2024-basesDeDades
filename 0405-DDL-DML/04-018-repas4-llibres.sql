-- Crea una primera versió d'una primera base de dades de llibres. Per a cada 
-- llibre voldrem un codi numèric, un títol, un autor, un número de pàgines i una 
-- ubicació.

CREATE TABLE llibres
(
    codi NUMERIC(10) PRIMARY KEY,
    titol VARCHAR(40),
    autor VARCHAR(30),
    numeroPagines NUMERIC(4),
    ubicacio VARCHAR(30)
);

-- Afig almenys 5 dades d'exemple.
INSERT INTO llibres VALUES (1,'El proceso','Franz Kafka',200,'e1b2');
INSERT INTO llibres VALUES (2,'Jurassic Park','Michael Crichton',1200,'e1b2');
INSERT INTO llibres VALUES (3,'Doom Guy: Life in First Person','John Romero',400,NULL);
INSERT INTO llibres VALUES (4,'Poemas esenciales','Edgar Allan Poe',2000,'e1b3');
INSERT INTO llibres VALUES (5,'La metamorfosis','Franz Kafka',1500,'e1b3');
INSERT INTO llibres VALUES (6,'América','Franz Kafka',900,'e1b4');

-- Mostra els llibres que continguen la paraula "poema".
SELECT * FROM llibres WHERE titol LIKE '%Poema%';

-- Mostra els llibres dels quals no tinguem anotada la ubicació.
SELECT * FROM llibres WHERE ubicacio IS NULL;

-- Mostra autor i títol dels llibres que tinguen entre 1000 i 2000 pàgines.
SELECT autor, titol FROM llibres WHERE numeroPagines BETWEEN 1000 AND 2000;

SELECT autor, titol 
FROM llibres 
WHERE numeroPagines >= 1000 AND numeroPagines <= 2000;

-- Mostra els llibres de l'autor "Franz Kafka" que estiguen en la ubicació "e1b2" o en "e1b3".
SELECT * FROM llibres WHERE autor IS 'Franz Kafka' AND (ubicacio='e1b2' OR ubicacio='e1b3');

-- Mostra la mitjana de pàgines que tenen els nostres llibres.
SELECT AVG(numeroPagines)
FROM llibres;

-- Mostra la llista d'ubicacions, sense duplicats, ordenada.
SELECT DISTINCT ubicacio
FROM llibres
ORDER BY ubicacio;

-- Títol del llibre, nom de l'autor i número de pàgines, ordenat en primer 
-- lloc per autor i després del que té més pàgines al qual té menys.

SELECT titol, autor, numeroPagines 
FROM llibres 
ORDER BY autor ASC, numeroPagines DESC;

-- Mostra el nom de cada autor, juntament amb la quantitat de llibres que tenim seus.
SELECT autor, COUNT(*)
FROM llibres
GROUP BY autor;

-- Mostra el nom de cada autor, juntament amb la quantitat de llibres que 
-- tenim seus, però només per als autors dels quals tinguem 3 o més llibres.
SELECT autor, COUNT(titol) AS totalLlibres
FROM llibres
GROUP BY autor
HAVING totalLlibres >= 3;
