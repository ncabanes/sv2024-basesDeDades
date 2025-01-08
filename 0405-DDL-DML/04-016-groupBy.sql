-- A partir de les dades de països (country), has d'obtindre:

-- El nom de cada continent (continent) i la seua població 
-- (population) mitjana.

SELECT continent, AVG(population) AS poblacioMitjana
FROM country
GROUP BY continent
ORDER BY continent;

-- El producte nacional brut (GNP) màxim de cada continent.

SELECT continent, MAX(gnp)
FROM country
GROUP BY continent;

-- La quantitat de països que hi ha en cada regió (region), 
-- ordenada de la regió amb més països a la regió amb menys.

SELECT region, COUNT(*) AS quantitatPaisos
FROM country
GROUP BY region
ORDER BY quantitatPaisos DESC;
