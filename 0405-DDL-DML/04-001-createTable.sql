-- Amb SQLite, ja siga instal·lat o en línia, crea una taula 
-- per a guardar informació d'estudiants 
-- (nia -clau-, nom, cognoms, email).

-- (Pots usar ".open estudiants" abans perquè els canvis es guarden)

CREATE TABLE estudiants
(
    nia NUMERIC(10) PRIMARY KEY,
    nom VARCHAR(20), 
    cognoms VARCHAR(40),
    email VARCHAR(100)
);
