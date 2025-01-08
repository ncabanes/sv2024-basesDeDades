-- A partir de les dades de països (country), has d'obtindre:

-- El nom de cada continent (continent) i la seua població 
-- (population) mitjana, per als continents amb una població 
-- mitjana superior a 3000000.

SELECT continent, AVG(population)
FROM country
GROUP BY continent
HAVING AVG(population) > 3000000;

-- El producte nacional brut (GNP) màxim de cada continent, 
-- per als continents amb un GNP inferior a 2000.

SELECT continent, MAX(gnp)
FROM country
GROUP BY continent
HAVING MAX(gnp) < 2000;

-- El nom de cada continent (continent) i la seua població 
-- (population) mitjana, per als continents el nom dels quals 
-- comence amb A.

SELECT continent, AVG(population)
FROM country
WHERE continent LIKE 'A%'
GROUP BY continent;
