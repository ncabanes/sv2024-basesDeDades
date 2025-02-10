-- Funcions matemàtiques (1)

-- A partir de les dades de països, has de mostrar:

-- La població (population), en milions de persones.

SELECT name, population/1000000 FROM country;

-- La resta de dividir cada població entre 1000.

SELECT name, MOD(population, 1000) FROM country;

-- Cada GNP elevat al quadrat.

SELECT name, POWER(gnp,2) FROM country;

-- L'arrel quadrada de cada superfície (surfaceArea).

SELECT name, SQRT(surfaceArea) FROM country;
