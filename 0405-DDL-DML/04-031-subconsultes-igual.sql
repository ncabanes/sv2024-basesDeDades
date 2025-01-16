-- A partir de la taula de països:

-- Mostra els països el continent dels quals siga el mateix 
-- que el de Mèxic (Mexico), usant una subconsulta

SELECT name, continent
FROM country
WHERE continent = 
(
    SELECT continent
    FROM country
    WHERE LOWER(name) = 'mexico'
)
ORDER BY name;
