-- Nom (name) del país amb codi (code) TKL

SELECT name FROM country WHERE code = 'TKL';

-- Noms (name) i superfícies (surfaceArea) dels països amb superfície inferior a 100

SELECT name, surfaceArea FROM country WHERE surfaceArea < 100;

-- Noms i superfícies dels països amb superfície entre 200 i 300

SELECT name, surfaceArea FROM country WHERE surfaceArea BETWEEN 200 AND 300;
SELECT name, surfaceArea FROM country WHERE surfaceArea >= 200 AND surfaceArea <= 300;

-- Noms de països el nom dels quals conté la paraula "French"

SELECT name FROM country WHERE name LIKE '%French%';

-- Noms de països la data d'independència (indepYear) dels quals no coneixem

SELECT name FROM country WHERE indepYear IS NULL;

-- Nom (name) i continent (continent) dels països la regió (region) dels quals siga "Polynesia" o "Caribbean"

SELECT name, continent FROM country WHERE region = 'Polynesia' OR region = 'Caribbean';
