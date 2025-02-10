-- Funcions de cadenes (3)

-- A partir de les dades de països, has de mostrar:

-- Les quatre primeres lletres de les regions.

SELECT DISTINCT SUBSTR(Region,1,4) FROM country;

-- Regions, reemplaçant "Europe" per "Eu.".

SELECT DISTINCT REPLACE(Region,'Europe','Eu.') FROM country;

-- Regions, reemplaçant "Europe" per "Eu." i "America" per "Am.".

SELECT DISTINCT REPLACE(REPLACE(Region,'Europe','Eu.'),'America','Am.')
FROM country;
