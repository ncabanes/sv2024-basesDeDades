CREATE VIEW v_ciutats_paisos AS
SELECT city.name, country.name 
FROM city JOIN country
ON city.countryCode = country.code;

SELECT * FROM v_ciutats_paisos;

-- Preferible

DROP VIEW v_ciutats_paisos;

CREATE VIEW v_ciutats_paisos AS
SELECT city.name AS ciutat, country.name AS pais
FROM city JOIN country
ON city.countryCode = country.code;

-- Consultes

SELECT  * FROM v_ciutats_paisos
WHERE pais = 'Spain'
AND ciutat LIKE 'A%'
ORDER BY ciutat;