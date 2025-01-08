-- Mostra el nom ("name") de cada país (taula "country"), juntament amb la 
-- seua població ("population"), utilitzant àlies perquè els noms dels 
-- camps apareguen en valencià.

SELECT paisos.name AS nom, paisos.population AS poblacio
FROM country AS paisos
ORDER BY nom;
