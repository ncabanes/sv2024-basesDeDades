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


-- Mostra els llibres dels quals no tinguem anotada la ubicació.


-- Mostra autor i títol dels llibres que tinguen entre 1000 i 2000 pàgines.


-- Mostra els llibres de l'autor "Franz Kafka" que estiguen en la ubicació "e1b2" o en "e1b3".


-- Mostra la mitjana de pàgines que tenen els nostres llibres.


-- Mostra la llista d'ubicacions, sense duplicats, ordenada.


-- Mostra el nom de cada autor, juntament amb la quantitat de llibres que tenim seus.


-- Mostra el nom de cada autor, juntament amb la quantitat de llibres que 
-- tenim seus, però només per als autors dels quals tinguem 3 o més llibres.

