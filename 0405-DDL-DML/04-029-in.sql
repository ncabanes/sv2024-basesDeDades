-- A partir de la taula de pa�sos (continent):

-- Mostra els pa�sos el continent dels quals siga
-- Europa (Europe), �sia (Asia) o Ant�rtida (Antarctica)

SELECT name, continent
FROM COUNTRY
WHERE continent in ('Europe','Asia','Antarctica')
ORDER BY population name;
