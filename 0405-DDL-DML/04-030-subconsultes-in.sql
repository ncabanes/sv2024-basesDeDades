-- A partir de la taula de països (continent):

-- Mostra els països el continent dels quals siga el 
-- mateix que el de Mèxic (Mexico) o que el 
-- de la Xina (China), usant una subconsulta.

SELECT name, continent
FROM country
WHERE continent IN 
(
    SELECT continent
    FROM country
    WHERE name = 'China' OR name = 'Mexico'
)
ORDER BY name;
