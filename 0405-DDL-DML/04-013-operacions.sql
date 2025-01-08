-- Mostra el nom ("name") de cada país (taula "country"), juntament amb 
-- la seua població ("population") en milions d'habitants, utilitzant 
-- àlies perquè no apareguen operacions com a noms de camps.

SELECT name AS nom, population / 1000000 AS poblacioMilions
FROM country 
ORDER BY poblacioMilions DESC;
