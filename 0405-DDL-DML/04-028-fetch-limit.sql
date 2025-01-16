-- A partir de la taula de països (country):

-- Mostra els tres països més poblats.
-- Mostra el tercer, quart i quint país més poblats.

-- Tres països més poblats

SELECT name, population 
FROM country
ORDER BY population DESC
LIMIT 3;

-- Tercer, quart i quint

SELECT name, population 
FROM COUNTRY
ORDER BY population DESC
LIMIT 2, 3;

-- Tres països més poblats, sintaxi d'Oracle

SELECT name, population 
FROM COUNTRY
ORDER BY population DESC
FETCH NEXT 3 ROWS ONLY;
