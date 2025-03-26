-- Una comunitat de propietaris ens ha demanat que l'ajudem a emmagatzemar 
-- els rebuts que van passant al cobrament a cada veí. Com volen una cosa 
-- molt simplificada, els hem proposat aquestes dues taules:

CREATE TABLE veins (
  codi NUMBER(4) PRIMARY KEY,
  nom VARCHAR(20),
  direccion VARCHAR(40)
);

CREATE TABLE rebuts (
  numMes NUMBER(2),
  numAny NUMBER(4),
  codiVei NUMBER(4),
  numRebutMes NUMBER(2),
  concepte VARCHAR(30),
  import NUMBER(8,2),
  dataPagament DATE,
  PRIMARY KEY(numMes, numAny, codiVei, numRebutMes)
);

-- Les dades dels veïns són aquestes:

INSERT INTO veins VALUES (1, 'Alberto Alvarez', 'Urbanización, puerta 1A');
INSERT INTO veins VALUES (2, 'Benito Blazquez', 'Urbanización, puerta 1B');
INSERT INTO veins VALUES (3, 'Carlota Caballero', 'Urbanización, puerta 2A');
INSERT INTO veins VALUES (4, 'Daniel Duran', 'Urbanización, puerta 2B');

-- I disposem dels següents rebuts:

INSERT INTO rebuts VALUES (5, 2024, 1, 1, 'Comunidad', 108.90, NULL);
INSERT INTO rebuts VALUES (5, 2024, 1, 2, 'Derrama trasteros', 200, NULL);
INSERT INTO rebuts VALUES (5, 2024, 1, 3, NULL, 105, NULL);
INSERT INTO rebuts VALUES (5, 2024, 2, 1, 'Comunidad', 112.75, NULL);
INSERT INTO rebuts VALUES (5, 2024, 3, 1, 'Comunidad', 108.90, NULL);
INSERT INTO rebuts VALUES (5, 2024, 5, 2, 'Derrama trasteros', 200, NULL);

-- 1.- Crea un bloc anònim que mostre tots els rebuts impagats (data de 
-- pagament NULL): codi de veí, nom de veí, mes del rebut i import del 
-- rebut. Has de recórrer-los amb un bucle FOR.

DECLARE
    CURSOR impagats IS
        SELECT codi, nom, numMes, import
        FROM veins INNER JOIN rebuts
        ON codi = codiVei
        WHERE dataPagament IS NULL;
BEGIN

    FOR i in impagats LOOP
        dbms_output.put_line(i.codi  || '  ' || i.nom  || '  '
            || i.numMes  || '  ' || i.import);
    END LOOP;
END;
