--A partir de la taula de països:

-- Mostra els països d'Àfrica (Africa) el producte interior brut 
-- dels quals (GNP) siga major que el d'algun d'Europa (Europe), 
-- usant una subconsulta

SELECT name, gnp
FROM country
WHERE continent = 'Africa'
AND gnp >= 
(
    SELECT MIN(gnp)
    FROM country
    WHERE continent = 'Europe'
)
ORDER BY gnp;

-- No en SQLite, només Oracle

SELECT name, gnp
FROM country
WHERE continent = 'Africa'
AND gnp >= ANY 
(
    SELECT gnp
    FROM country
    WHERE continent = 'Europe'
)
ORDER BY gnp;
