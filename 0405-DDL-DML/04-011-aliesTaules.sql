-- Mostra el nom ("name") de cada país (taula "country") que pertanga 
-- al continent anomenat "Europa", ordenats alfabèticament. Usa l’àlies 
-- "paisos" per a la taula "country".

SELECT paisos.name
FROM country AS paisos
WHERE paisos.continent = 'Europe';
