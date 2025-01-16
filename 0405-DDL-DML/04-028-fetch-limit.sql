-- A partir de la taula de pa�sos (country):

-- Mostra els tres pa�sos m�s poblats.
-- Mostra el tercer, quart i quint pa�s m�s poblats.

-- Tres pa�sos m�s poblats

SELECT name, population 
FROM country
ORDER BY population DESC
LIMIT 3;

-- Tercer, quart i quint

SELECT name, population 
FROM COUNTRY
ORDER BY population DESC
LIMIT 2, 3;

-- Tres pa�sos m�s poblats, sintaxi d'Oracle

SELECT name, population 
FROM COUNTRY
ORDER BY population DESC
FETCH NEXT 3 ROWS ONLY;
