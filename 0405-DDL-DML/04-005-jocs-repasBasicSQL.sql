-- Crea una taula per a guardar informació de jocs (codi -clau-, nom, plataforma, any).

.open jocsV1

CREATE TABLE jocs
(
    codi CHAR(5) PRIMARY KEY,
    nom VARCHAR(20),
    plataforma VARCHAR(15),
    anyLlancament NUMERIC(4)
);

-- Afig dades d'exemple per a 5 jocs. 
-- Almenys un d'ells no ha de tindre any i almenys un ha de tindre 
-- les dades en ordre "no natural".

INSERT INTO jocs VALUES ('tlou', 'The last of us', 'ps3', 2013);
INSERT INTO jocs VALUES ('rdr2', 'Read dead redemption 2', 'steam', 2019);

INSERT INTO jocs VALUES ('mmc', 'Manic Miner', 'Amstrad CPC', NULL);
INSERT INTO jocs (codi, nom, plataforma) VALUES ('mmz', 'Manic Miner', 'Zx Spectrum');

INSERT INTO jocs (nom, plataforma, anyLlancament, codi)
VALUES ('Super Mario Galaxy 2', 'wii', 2010, 'smg2');

-- Mostra totes les dades de tots els jocs

SELECT * FROM jocs;

-- Mostra nom i plataforma de tots els jocs

SELECT nom, plataforma FROM jocs;

-- Mostra nom dels jocs la plataforma dels quals siga PS3

SELECT nom FROM jocs WHERE plataforma = 'PS3';

-- Mostra nom i plataforma dels jocs la plataforma dels quals no siga PS4

SELECT nom, plataforma FROM jocs
WHERE plataforma <> 'PS4';

-- Mostra plataforma i nom i plataforma dels jocs anteriors a 2010

SELECT plataforma, nom
FROM jocs
WHERE anyLlancament < 2010;


-- Nom i plataforma de tots els jocs presentats entre 2008 i 2014, de 2 maneres distintes

SELECT nom, plataforma FROM jocs
WHERE anyLlancament 
BETWEEN 2008 AND 2014;

SELECT nom, plataforma FROM jocs
WHERE anyLlancament >= 2008 
AND anyLlancament <= 2014;

