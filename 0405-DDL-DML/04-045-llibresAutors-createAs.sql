-- 1. Mostra el títol de cada llibre juntament amb el nom del seu autor, si existix.

-- Sintaxi en SQLite, MySQL, PostgreSQL i Oracle

CREATE TABLE autorsILlibres AS
    SELECT llibres.titol, autors.nom
    FROM llibres, autors, escriure
    WHERE autors.codi = escriure.codiAutor
    AND llibres.codi = escriure.codiLlibre;

SELECT * FROM autorsILlibres;

-- Sintaxi en SQL Server de Microsoft

SELECT llibres.titol, autors.nom
INTO autorsILlibres2
FROM llibres, autors, escriure
WHERE autors.codi = escriure.codiAutor
AND llibres.codi = escriure.codiLlibre;
