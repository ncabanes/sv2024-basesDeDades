-- 4.66: Contacte amb les dates
-- Crea una taula "amics" (codi, nom, cognoms, email, data de naixemenent):

CREATE TABLE amics (
    codi CHAR(5),
    nom VARCHAR2(20),
    cognoms VARCHAR2(40),
    email VARCHAR2(40),
    data_naixement DATE,
    CONSTRAINT pk_amics PRIMARY KEY(codi)
);

-- Afig tres dades d'exemple

INSERT INTO amics VALUES
('jo','Joan', 'García Pérez', 'joan.garcia@amics.com', TO_DATE('2002-01-15','YYYY-MM-DD')),

INSERT INTO amics VALUES
('la','Laia', 'López Martí', 'laia.lopez@amics.com', TO_DATE('2004-02-16','YYYY-MM-DD')),

INSERT INTO amics VALUES
('ar','Ariadna', 'Andreu Vidal', 'ariadna.andreu@amics.com', TO_DATE('2006-03-17','YYYY-MM-DD'));

-- Mostra totes les dades

SELECT * FROM amics;

-- Mostra nom, cognoms i data de naixement, ordenats del més jove al més vell

SELECT nom, cognoms, data_naixement
FROM amics
ORDER BY data_naixement DESC;
