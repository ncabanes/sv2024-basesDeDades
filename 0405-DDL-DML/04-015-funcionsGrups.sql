-- A partir de les dades de països, has d'obtindre:

-- La quantitat de dades introduïdes.

SELECT COUNT(*) FROM country;

-- La població ("population") del país més poblat.

SELECT MAX(population) FROM country;

-- La població del país menys poblat.

SELECT MIN(population) FROM country;

-- La població mitjana dels països de la base de dades.

SELECT AVG(population) FROM country;

-- La població total entre tots els països registrats.

SELECT SUM(population) FROM country;

-- La quantitat de continents.

SELECT COUNT(DISTINCT continent) FROM country;
