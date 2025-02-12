-- A partir d'esta taules y estes dades, usant sintaxi d'Oracle:

CREATE TABLE amics (
    codi CHAR(5),
    nom VARCHAR2(20),
    cognoms VARCHAR2(40),
    email VARCHAR2(40),
    data_naixement DATE,
    CONSTRAINT pk_amics PRIMARY KEY(codi)
);

INSERT INTO amics VALUES
('jo','Joan', 'García Pérez', 'joan.garcia@amics.com', TO_DATE('2002-01-15','YYYY-MM-DD'));

INSERT INTO amics VALUES
('la','Laia', 'López Martí', 'laia.lopez@amics.com', TO_DATE('2004-02-16','YYYY-MM-DD'));

INSERT INTO amics VALUES
('ar','Ariadna', 'Andreu Vidal', 'ariadna.andreu@amics.com', TO_DATE('2006-03-17','YYYY-MM-DD'));

-- Mostra (els cognoms, el nom i) l'edat que els teus amics tenen actualment

SELECT cognoms, nom, TRUNC((SYSDATE - data_naixement) / 365) AS edat_actual
FROM amics;

--  Mostra la data que era 10 dies després que nasquera cada amic

SELECT cognoms, nom, data_naixement + 10 AS data_10_dies_despres
FROM amics;

-- Mostra la data que era 2 mesos després que nasquera cada amic 

SELECT cognoms, nom, ADD_MONTHS(data_naixement, 2) AS data_2_mesos_despres
FROM amics;

-- Mostra els mesos que han transcorregut entre la data actual 
-- i la data de naixement de cada amic

SELECT cognoms, nom, 
    ROUND(MONTHS_BETWEEN(SYSDATE, data_naixement)) AS mesos_transcorreguts
FROM amics;

-- Mostra l'edat que els alumnes tenien el 2 de març de 2010 

SELECT cognoms, nom, 
    ROUND((TO_DATE('2010-03-02', 'YYYY-MM-DD') - data_naixement) / 365) 
    AS edat_en_marc_2010
FROM amics;

-- Mostra quants dies faltaven fins a final de mes quan van nàixer

SELECT cognoms, nom, 
    LAST_DAY(data_naixement) - data_naixement AS dies_restants
FROM amics;

-- Data del dilluns següent al seu naixement

SELECT nom, cognoms, 
    NEXT_DAY(data_naixement, 'Monday') AS properDilluns
FROM amics;

-- Dia de la setmana de naixement

SELECT nom, cognoms, TO_CHAR(data_naixement, 'Day') AS diaSetmana
FROM amics;
