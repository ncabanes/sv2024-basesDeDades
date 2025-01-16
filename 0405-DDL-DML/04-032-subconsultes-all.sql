-- A partir de la taula de països:

-- Mostra els països el producte interior brut dels quals (GNP) 
-- siga major que el de tots els d'Àfrica (Africa), usant una 
-- subconsulta

SELECT name, gnp
FROM country
WHERE gnp > 
(
    SELECT MAX(gnp)
    FROM country
    WHERE continent = 'Africa'
)
ORDER BY gnp;

-- No en SQLite, només Oracle

SELECT name, gnp
FROM country
WHERE gnp > ALL
(
    SELECT gnp
    FROM country
    WHERE continent = 'Africa'
)
ORDER BY gnp;
