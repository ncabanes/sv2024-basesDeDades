-- Mostra el nom ("name") de cada país (taula "country"), juntament amb 
-- la seua població ("population"). Has d'ordenar del país més poblat al 
-- menys poblat. En cas de coincidir la població, ordena alfabèticament 
-- per nom.

SELECT name, population FROM country
ORDER BY population DESC, name ASC;
