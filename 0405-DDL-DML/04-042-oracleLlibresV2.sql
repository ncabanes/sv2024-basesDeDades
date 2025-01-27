-- Crea una versió de les taules de llibres i d'autors (exercici 4.36) usant 
-- sintaxi d'Oracle. Inclou una clau aliena.

CREATE TABLE autors
(
    codi VARCHAR2(5),
    nom VARCHAR2(30),
    CONSTRAINT pk_autors PRIMARY KEY (codi)
);

CREATE TABLE llibres
(
    codi NUMBER(10),
    titol VARCHAR2(40),
    codiAutor VARCHAR2(5),
    numeroPagines NUMBER(4),
    ubicacio VARCHAR2(30),
    CONSTRAINT pk_llibres PRIMARY KEY (codi),
    CONSTRAINT fk_llibres_autors FOREIGN KEY (codiAutor) REFERENCES autors(codi)
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
INSERT INTO llibres VALUES (10,'La zona muerta','sk',NULL,'s1b2');
INSERT INTO llibres VALUES (11,'Sol naciente','mc',419,'e1b2');
INSERT INTO llibres VALUES (12,'La tabla de Flandes',NULL,NULL,'s1b2');
