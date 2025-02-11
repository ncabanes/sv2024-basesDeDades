-- 4.66: Contacte amb les dates
-- Crea una taula "amics" (codi, nom, cognoms, email, data de naixemenent):

CREATE TABLE amics (
    codi CHAR(5) PRIMARY KEY,
    nom VARCHAR(20),
    cognoms VARCHAR(40),
    email VARCHAR(40),
    data_naixement DATE
);

-- Afig tres dades d'exemple

INSERT INTO amics VALUES
('jo','Joan', 'García Pérez', 'joan.garcia@amics.com', '2002-01-15'),
('la','Laia', 'López Martí', 'laia.lopez@amics.com', '2004-02-16'),
('ar','Ariadna', 'Andreu Vidal', 'ariadna.andreu@amics.com', '2006-03-17');

-- Mostra totes les dades

SELECT * FROM amics;

-- Mostra nom, cognoms i data de naixement, ordenats del més jove al més vell

SELECT nom, cognoms, data_naixement
FROM amics
ORDER BY data_naixement DESC;
