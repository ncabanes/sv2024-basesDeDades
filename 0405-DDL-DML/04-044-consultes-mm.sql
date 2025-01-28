-- A partir de les dades d'autors i llibres (V3, M:M):

-- 1. Mostra el títol de cada llibre juntament amb el nom del seu autor, si existix.

-- Primera aproximació

SELECT llibres.titol, autors.nom
FROM llibres, autors, escriure
WHERE autors.codi = escriure.codiAutor
AND llibres.codi = escriure.codiLlibre;

-- Forma correcta

SELECT llibres.titol, autors.nom
FROM llibres 
    LEFT JOIN escriure
        ON llibres.codi = escriure.codiLlibre
    LEFT JOIN autors
        ON escriure.codiAutor = autors.codi;


-- 2. Mostra el nom de cada autor juntament amb la quantitat de llibres seus que tenim.

SELECT autors.nom, COUNT(codiLlibre)
FROM autors 
    LEFT JOIN escriure
        ON autors.codi = escriure.codiAutor
GROUP BY autors.nom;

-- 3. Mostra els noms d'autors dels quals no tinguem llibres, usant COUNT i HAVING.

SELECT autors.nom
FROM autors 
    LEFT JOIN escriure ON autors.codi = escriure.codiAutor
GROUP BY autors.nom
HAVING COUNT(escriure.codiLlibre) = 0;

-- 4. Mostra els noms d'autors dels quals no tinguem llibres, usant IN (o NOT IN).

SELECT nom
FROM autors
WHERE codi NOT IN 
(
    SELECT codiAutor FROM escriure
);

-- 5. Mostra els noms d'autors dels quals no tinguem llibres, usant ALL o ANY.

-- No en SQLite

SELECT nom
FROM autors
WHERE codi <> ALL
(
    SELECT codiAutor FROM escriure
);

-- 6. Mostra els noms d'autors dels quals no tinguem llibres, usant EXISTS o NOT EXISTS.

SELECT nom
FROM autors
WHERE NOT EXISTS 
(
    SELECT 1 
    FROM escriure 
    WHERE codiAutor = autors.codi
);

-- -------------------


-- A partir de los datos de autores y libros (V3, M:M):

-- 1. Muestra el nombre de cada libro junto con el nombre de su autor, si existe.

-- 2. Muestra el nombre de cada autor junto con la cantidad de libros suyos que tenemos.

-- 3. Muestra los nombres de autores de los que no tengamos libros, usando COUNT y HAVING.

-- 4. Muestra los nombres de autores de los que no tengamos libros, usando IN (o NOT IN).

-- 5. Muestra los nombres de autores de los que no tengamos libros, usando ALL o ANY.

-- 6. Muestra los nombres de autores de los que no tengamos libros, usando EXISTS o NOT EXISTS.
