-- 1- Crea una taula per a guardar informació de sèries de televisió (codi alfanumèric, títol, canal de TV, valoració numèrica).

CREATE TABLE series (
    codi VARCHAR(10) PRIMARY KEY,
    titol VARCHAR(100) NOT NULL,
    canal VARCHAR(100) NOT NULL,
    valoracio NUMERIC(3,1)
);

-- 2- Afig 2 dades d'exemple.

INSERT INTO series (codi, titol, canal, valoracio)
VALUES ('S001', 'Breaking Bad', 'AMC', 10),
       ('S002', 'Stranger Things', 'Netflix', 9),
       ('S003', 'Skeleton Crew', 'Disney+', 7);

-- 3- Mostra els títols de les sèries la valoració de les quals estiga entre 8 i 10, ordenades alfabèticament.

SELECT titol
FROM series
WHERE valoracio BETWEEN 8 AND 10
ORDER BY titol;

-- 4- Mostra el canal en el qual està la sèrie millor valorada.

SELECT canal
FROM series
WHERE valoracio = (SELECT MAX(valoracio) FROM series);

-- 5- Mostra les sèries que estan en el mateix canal que la millor valorada.

SELECT titol
FROM series
WHERE canal = 
(
    SELECT canal
    FROM series
    WHERE valoracio = 
    (
        SELECT MAX(valoracio) FROM series
    )
);

-- Alternatiu, LIMIT o FETCH

SELECT titol
FROM series
WHERE canal = (SELECT canal FROM series ORDER BY valoracio DESC LIMIT 1);

-- 6- Mostra la valoració mitjana de les sèries de cada canal.

SELECT canal, AVG(valoracio) AS valoracio_mitjana
FROM series
GROUP BY canal;

-- 7- Modifica una de les sèries que has afegit, indicant que ara passa a estar en un altre canal.

UPDATE series
SET canal = 'HBO'
WHERE codi = 'S002';

-- 8- Esborra una de les sèries que has afegit.

DELETE FROM series
WHERE codi = 'S001';

-- -------------------------------------

-- 1- Crea una tabla para guardar información de series de televisión (código alfanumérico, título, canal de TV, valoración numérica).
-- 2- Añade 2 datos de ejemplo.
-- 3- Muestra los títulos de las series cuya valoración esté entre 8 y 10, ordenadas alfabéticamente.
-- 4- Muestra el canal en el que está la serie mejor valorada.
-- 5- Muestra las series que están en el mismo canal que la mejor valorada.
-- 6- Muestra la valoración media de las series de cada canal.
-- 7- Modifica una de las series que has añadido, indicando que ahora pasa a estar en otro canal.
-- 8- Borra una de las series que has añadido.
