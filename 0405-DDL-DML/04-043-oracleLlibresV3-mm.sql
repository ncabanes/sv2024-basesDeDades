-- Crea una versió de les taules de llibres i d'autors (exercici 4.36) usant 
-- sintaxi de Oracle, amb una relació "molts a molts" (cada llibre pot ser de 
-- diversos autors).
-- 
-- Has de tindre en compte estes restriccions (amb sintaxis de Oracle): les claus 
-- primàries, les claus alienes, el nom de l'autor i el títol del llibre no han de 
-- ser nuls, el nombre de pàgines ha de ser no negatiu inferior a 5000, el nom de 
-- l'autor ha de ser únic.

CREATE TABLE autors
(
    codi VARCHAR2(5),
    nom VARCHAR2(30) NOT NULL,
    CONSTRAINT pk_autors PRIMARY KEY (codi),
    CONSTRAINT uk_autors UNIQUE(nom)
);

CREATE TABLE llibres
(
    codi NUMBER(10),
    titol VARCHAR2(40) NOT NULL,
    -- codiAutor VARCHAR2(5),
    numeroPagines NUMBER(4),
    ubicacio VARCHAR2(30),
    CONSTRAINT pk_llibres PRIMARY KEY (codi),
    CONSTRAINT ck_llibres_numeroPagines 
        CHECK (numeroPagines >= 0 AND numeroPagines < 5000)
    --CONSTRAINT fk_llibres_autors FOREIGN KEY (codiAutor) REFERENCES autors(codi)
);

CREATE TABLE escriure
(
    codiAutor VARCHAR2(5),
    codiLlibre NUMBER(10),
    CONSTRAINT pk_escriure PRIMARY KEY (codiAutor , codiLlibre),
    CONSTRAINT fk_escriure_autors FOREIGN KEY (codiAutor) REFERENCES autors(codi),
    CONSTRAINT fk_escriure_llibres FOREIGN KEY (codiLlibre) REFERENCES llibres(codi)
);

-- ---------------

INSERT INTO autors VALUES ('fk','Franz Kafka');
INSERT INTO autors VALUES ('eap','Edgar Allan Poe');
INSERT INTO autors VALUES ('jr','John Romero');
INSERT INTO autors VALUES ('mc','Michael Crichton');
INSERT INTO autors VALUES ('shak','William Shakespeare');
INSERT INTO autors VALUES ('cerv','Miguel de Cervantes');
INSERT INTO autors VALUES ('sk','Stephen King');

INSERT INTO llibres VALUES (1,'El proceso',296,'e1b2');
INSERT INTO llibres VALUES (2,'Parque Jurásico',480,'e1b2');
INSERT INTO llibres VALUES (3,'Doom Guy: Life in First Person',370,NULL);
INSERT INTO llibres VALUES (4,'Ensayos y Poesía Completa',480,'e1b3');
INSERT INTO llibres VALUES (5,'La metamorfosis',128,'e1b3');
INSERT INTO llibres VALUES (6,'América',320,'e1b4');
INSERT INTO llibres VALUES (7,'Maleficio',332,'s1b2');
INSERT INTO llibres VALUES (8,'Ojos de fuego',429,'s1b2');
INSERT INTO llibres VALUES (9,'El umbral de la noche',NULL,'s1b2');
INSERT INTO llibres VALUES (10,'La zona muerta',NULL,'s1b2');
INSERT INTO llibres VALUES (11,'Sol naciente',419,'e1b2');
INSERT INTO llibres VALUES (12,'La tabla de Flandes',NULL,'s1b2');

INSERT INTO escriure VALUES ('fk',1);
INSERT INTO escriure VALUES ('fk',5);
INSERT INTO escriure VALUES ('fk',6);
INSERT INTO escriure VALUES ('sk',7);
INSERT INTO escriure VALUES ('sk',8);
INSERT INTO escriure VALUES ('sk',9);
INSERT INTO escriure VALUES ('sk',10);
INSERT INTO escriure VALUES ('mc',2);
INSERT INTO escriure VALUES ('mc',11);
INSERT INTO escriure VALUES ('jr',3);
INSERT INTO escriure VALUES ('eap',4);

INSERT INTO autors VALUES ('au1','Autor 1');
INSERT INTO autors VALUES ('au2','Autor 2');
INSERT INTO llibres VALUES (100,'Multilibro',NULL,NULL);
INSERT INTO escriure VALUES ('au1',100);
INSERT INTO escriure VALUES ('au2',100);

-- ---------------
