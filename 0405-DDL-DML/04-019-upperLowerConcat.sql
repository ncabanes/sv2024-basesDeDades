-- A partir de les dades de països, has de mostrar:

-- Nom (name) i regió (region), tots dos en majúscules

SELECT UPPER(name), UPPER(region) FROM country;

-- Regions en minúscules, sense repetits, precedides per "Regió: "

SELECT DISTINCT CONCAT('Regió: ', LOWER(region)) FROM country;

SELECT DISTINCT 'Regió: ' || LOWER(region) FROM country;
