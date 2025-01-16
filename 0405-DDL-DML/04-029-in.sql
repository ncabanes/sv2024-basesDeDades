-- A partir de la taula de països (continent):

-- Mostra els països el continent dels quals siga
-- Europa (Europe), Àsia (Asia) o Antàrtida (Antarctica)

SELECT name, continent
FROM COUNTRY
WHERE continent in ('Europe','Asia','Antarctica')
ORDER BY population name;
