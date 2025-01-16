-- A partir de la taula de països (country) y la taula de ciutats (city):

-- Nom de cada ciutat i nom del país, ordenat per país i per nom

-- Amb WHERE

SELECT city.name, country.name
FROM country, city
WHERE country.code = city.CountryCode
ORDER BY country.name, city.name;

-- Amb JOIN

SELECT city.name, country.name
FROM country INNER JOIN city
ON country.code = city.CountryCode
ORDER BY country.name, city.name;


-- Nom de tots els països i de les seues ciutats (si n'hi ha), 
-- ordenat per país i per nom

SELECT country.name, city.name
FROM country LEFT JOIN city
ON country.code = city.CountryCode
ORDER BY country.name, city.name;


-- Nom de cada país i quantitat de ciutats que hi ha en ell

SELECT country.name, COUNT(city.name)
FROM country LEFT JOIN city
ON country.code = city.CountryCode
GROUP BY country.name
ORDER BY country.name;

-- Nom de cada país i quantitat de ciutats 
--(només per als que tenen 10 o més)

SELECT country.name, COUNT(city.name)
FROM country LEFT JOIN city
ON country.code = city.CountryCode
GROUP BY country.name
HAVING COUNT(city.name) >= 10
ORDER BY country.name;

-- Nom de cada país i quantitat de ciutats 
-- per als països d'Àfrica (només per 
-- als que tenen 10 o més)

SELECT country.name, COUNT(city.name)
FROM country LEFT JOIN city
ON country.code = city.CountryCode
WHERE continent = 'Africa'
GROUP BY country.name
HAVING COUNT(city.name) >= 10
ORDER BY country.name;
