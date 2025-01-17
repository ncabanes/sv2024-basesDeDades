-- Segona versió de la base de dades de llibres

CREATE TABLE autors
(
    codi VARCHAR(5) PRIMARY KEY,
    nom VARCHAR(30)
);

CREATE TABLE llibres
(
    codi NUMERIC(10) PRIMARY KEY,
    titol VARCHAR(40),
    codiAutor VARCHAR(5),
    numeroPagines NUMERIC(4),
    ubicacio VARCHAR(30)
);


INSERT INTO autors VALUES ('fk','Franz Kafka');
INSERT INTO autors VALUES ('eap','Edgar Allan Poe');
INSERT INTO autors VALUES ('jr','John Romero');
INSERT INTO autors VALUES ('mc','Michael Crichton');
INSERT INTO autors VALUES ('shak','William Shakespeare');
INSERT INTO autors VALUES ('cerv','Miguel de Cervantes');
INSERT INTO autors VALUES ('sk','Stephen King');

INSERT INTO llibres VALUES (1,'El proceso','fk',296,'e1b2');
INSERT INTO llibres VALUES (2,'Parque Jurásico','mc',480,'e1b2');
INSERT INTO llibres VALUES (3,'Doom Guy: Life in First Person','jr',370,NULL);
INSERT INTO llibres VALUES (4,'Ensayos y Poesía Completa','eap',480,'e1b3');
INSERT INTO llibres VALUES (5,'La metamorfosis','fk',128,'e1b3');
INSERT INTO llibres VALUES (6,'América','fk',320,'e1b4');
INSERT INTO llibres VALUES (7,'Maleficio','sk',332,'s1b2');
INSERT INTO llibres VALUES (8,'Ojos de fuego','sk',429,'s1b2');
INSERT INTO llibres VALUES (9,'El umbral de la noche','sk',NULL,'s1b2');
INSERT INTO llibres VALUES (10,'la zona muerta','sk',NULL,'s1b2');
INSERT INTO llibres VALUES (11,'Sol naciente','mc',419,'e1b2');
INSERT INTO llibres VALUES (12,'La tabla de Flandes',NULL,NULL,'s1b2');
