-- A partir d'estes dades:

-- Pel·lícules, categories (M:M) i remakes (1:M)

CREATE TABLE pellicules (
  codi VARCHAR(6) PRIMARY KEY,
  nom VARCHAR(30),
  anyEstrena NUMERIC(4),
  valoracio NUMERIC(2),
  remakeDe VARCHAR(6)
);

CREATE TABLE categories (
  codi VARCHAR(3) PRIMARY KEY,
  nom VARCHAR(30)
);

CREATE TABLE pertanyA (
  codiPellicula VARCHAR(6),
  codiCategoria VARCHAR(3),
  PRIMARY KEY (codiPellicula, codiCategoria)
);

INSERT INTO pellicules VALUES ('eco','El caballero oscuro', 2008, 9, NULL);
INSERT INTO pellicules VALUES ('uti','Ultimatum a la Tierra', 1951, 8, NULL);
INSERT INTO pellicules VALUES ('uti2','Ultimatum a la Tierra', 2008, 4, 'uti');
INSERT INTO pellicules VALUES ('tij','The italian job', 1969, 7, NULL);
INSERT INTO pellicules VALUES ('tij2','The italian job', 2003, 7, 'tij');
INSERT INTO pellicules VALUES ('skf','Skyfall', 2012, 8, NULL);
INSERT INTO pellicules VALUES ('lvi','La ventana indiscreta', 1954, 9, NULL);
INSERT INTO pellicules VALUES ('ter','Terror', 1963, 5, NULL);

INSERT INTO categories VALUES ('acc','Acción');
INSERT INTO categories VALUES ('com','Comedia');
INSERT INTO categories VALUES ('cf','Ciencia Ficción');
INSERT INTO categories VALUES ('dr','Drama');
INSERT INTO categories VALUES ('cri','Crimen');
INSERT INTO categories VALUES ('sus','Suspense');
INSERT INTO categories VALUES ('ter','Terror');

INSERT INTO pertanyA VALUES ('eco','acc');
INSERT INTO pertanyA VALUES ('eco','cri');
INSERT INTO pertanyA VALUES ('tij','acc');
INSERT INTO pertanyA VALUES ('tij','com');
INSERT INTO pertanyA VALUES ('uti','cf');
INSERT INTO pertanyA VALUES ('uti','dr');
INSERT INTO pertanyA VALUES ('skf','acc');
INSERT INTO pertanyA VALUES ('skf','sus');
INSERT INTO pertanyA VALUES ('lvi','sus');

-- 01. Nom i any de les pel·lícules la valoració de les quals 
-- siga de 8 o més.

SELECT nom, anyEstrena FROM pellicules
WHERE valoracio >= 8;

-- 02. Nom i any de les pel·lícules la valoració de les quals no 
-- siga 9, ordenades per nom.

SELECT nom, anyEstrena FROM pellicules
WHERE valoracio <> 9
ORDER BY nom;

-- 03, 04. Nom de cada pel·lícula i quantitat de categories 
-- que tenim sobre ella (només per a les pel·lícules de les 
-- quals coneixem alguna categoria), enllaçant les taules de 
-- 2 formes diferents.

-- Pel·licula i codi de categoria

SELECT nom, codiCategoria
FROM pellicules JOIN pertanyA
ON pellicules.codi = pertanyA.codiPellicula;

-- Consulta completa

SELECT nom, COUNT(codiCategoria)
FROM pellicules JOIN pertanyA
ON pellicules.codi = pertanyA.codiPellicula
GROUP BY nom;

-- Amb WHERE

SELECT nom, COUNT(codiCategoria)
FROM pellicules, pertanyA
WHERE pellicules.codi = pertanyA.codiPellicula
GROUP BY nom;


-- 05. Nom de cada pel·lícula i quantitat de categories que 
-- tenim sobre ella (potser cap).

SELECT nom, COUNT(codiCategoria)
FROM pellicules LEFT JOIN pertanyA
ON pellicules.codi = pertanyA.codiPellicula
GROUP BY nom;


-- 06, 07. Pel·lícules que contenen un espai en el seu nom, 
-- de 2 formes diferents.

SELECT * FROM pellicules
WHERE nom LIKE '% %';

SELECT * FROM pellicules
WHERE INSTR(nom, ' ') > 0;


-- 08. Valoració mitjana de les pel·lícules el nom de les 
-- quals comença per "T" (en majúscules), arredonida a 1 decimal.

SELECT ROUND(AVG(valoracio),1) FROM pellicules
WHERE nom LIKE 'T%';


-- 09. Valoració més alta d'una pel·lícula el nom de la qual 
-- comence per "T" (potser en minúscules).

SELECT MAX(valoracio) FROM pellicules
WHERE UPPER(nom) LIKE 'T%';


-- 10. Nom de cada pel·lícula, any, valoració i categoria 
-- (només per a les que coneguem almenys una categoria), 
-- ordenada per títol (nom).

SELECT pellicules.nom, anyEstrena, valoracio, categories.nom
FROM pellicules 
    INNER JOIN pertanyA ON pellicules.codi = pertanyA.codiPellicula
    INNER JOIN categories ON categories.codi = pertanyA.codiCategoria;


-- 11. Nom de cada pel·lícula, any, valoració i categoria (fins i 
-- tot per a les que no coneguem la categoria), ordenada per 
-- valoració, de la més alta a la més baixa.

SELECT pellicules.nom, anyEstrena, valoracio, categories.nom
FROM pellicules 
    LEFT JOIN pertanyA ON pellicules.codi = pertanyA.codiPellicula
    LEFT JOIN categories ON categories.codi = pertanyA.codiCategoria
ORDER BY valoracio DESC;


-- 12. Nom, any i valoració de la/les pel·lícula/pel·lícules amb
-- la valoració més alta, emprant ORDER BY.

SELECT nom, anyEstrena, valoracio
FROM pellicules 
ORDER BY valoracio DESC
FETCH NEXT 1 ROWS WITH TIES;


-- 13. Nom, any i valoració de la/les pel·lícula/pel·lícules amb 
-- la valoració més alta, emprant MAX.

SELECT nom, anyEstrena, valoracio
FROM pellicules WHERE valoracio =
(
    SELECT MAX(valoracio) FROM pellicules
);

-- 14. Nom, any i valoració de la/les pel·lícula/pel·lícules 
-- amb la valoració més alta, emprant ANY o ALL.

SELECT nom, anyEstrena, valoracio
FROM pellicules WHERE valoracio >= ALL
(
    SELECT valoracio FROM pellicules
);


-- 15. Nom, any i valoració de la/les pel·lícula/pel·lícules 
-- amb la valoració més alta, emprant EXISTS o NOT EXISTS.

SELECT nom, anyEstrena, valoracio
FROM pellicules p1 WHERE NOT EXISTS
(
    SELECT 1 FROM pellicules p2
    WHERE p2.valoracio > p1.valoracio
);


-- 16. Mostra les pel·lícules que siguen "remakes" d'alguna 
-- anterior: nom, any i valoració de la pel·lícula moderna, 
-- juntament amb nom, any i valoració de la pel·lícula original.

SELECT 
    moderna.nom, moderna.anyEstrena, moderna.valoracio,
    antiga.nom, antiga.anyEstrena, antiga.valoracio
FROM pellicules moderna JOIN pellicules antiga 
ON moderna.remakeDe = antiga.codi;


-- 17. Crea una vista "v_remakes" que mostre eixa informació, 
-- ordenada de la pel·lícula (moderna) més recent a la més antiga, 
-- i ordenant per nom en cas que coincidisca l'any.

CREATE VIEW v_remakes AS
    SELECT 
        moderna.nom AS nomModerna, 
        moderna.anyEstrena AS anyModerna, 
        moderna.valoracio AS valoracModerna,
        antiga.nom AS nomAntiga,
        antiga.anyEstrena AS anyAntiga, 
        antiga.valoracio AS valoracAntiga
    FROM pellicules moderna JOIN pellicules antiga 
    ON moderna.remakeDe = antiga.codi
    ORDER BY anyModerna DESC, nomModerna ASC;


-- 18. A partir d'eixa vista "v_remakes", mostra el nom de
-- la pel·lícula moderna i els anys de diferència amb la
-- pel·lícula original.

SELECT nomModerna, anyModerna - anyAntiga AS anys FROM v_remakes;


-- 19. Mostra els noms de les categories de les quals tenim 
-- 2 o més pel·lícules.

SELECT categories.nom, COUNT(codiPellicula)
FROM categories 
    LEFT JOIN pertanyA ON categories.codi = pertanyA.codiCategoria
    LEFT JOIN pellicules ON pellicules.codi = pertanyA.codiPellicula
GROUP BY categories.nom
HAVING COUNT(codiPellicula) >= 2;


-- 20. Categories de les quals no coneixem cap pel·lícula, 
-- usant IN / NOT IN.

SELECT nom
FROM categories WHERE codi NOT IN
(
    SELECT codiCategoria FROM pertanyA
);


-- 21. Categories de les quals no coneixem cap pel·lícula, 
-- usant ALL / ANY.

SELECT nom
FROM categories WHERE codi <> ALL
(
    SELECT codiCategoria FROM pertanyA
);


-- 22. Categories de les quals no coneixem cap pel·lícula, 
-- usant EXISTS / NOT EXISTS.

SELECT nom
FROM categories WHERE NOT EXISTS
(
    SELECT codiCategoria FROM pertanyA
    WHERE codiCategoria = categories.codi
);


-- 23. Categories de les quals no coneixem cap pel·lícula, 
-- usant COUNT.

-- Basat en el 19

SELECT categories.nom
FROM categories 
    LEFT JOIN pertanyA ON categories.codi = pertanyA.codiCategoria
    LEFT JOIN pellicules ON pellicules.codi = pertanyA.codiPellicula
GROUP BY categories.nom
HAVING COUNT(codiPellicula) = 0;


-- 24. Afig un índex a la taula de pel·lícules, perquè les cerques 
-- per títol (nom) siguen més ràpides.

CREATE INDEX idx_pellicules_nom ON pellicules(nom);


-- 25. Crea una taula de "persones". Per a cada persona voldrem un
-- codi (6 lletres, clau primària), un nom (fins a 40 lletres, 
-- no nul) i la seua data de naixement (data). Usa sintaxi de Oracle.

CREATE TABLE persones (
  codi CHAR(6),
  nom VARCHAR2(40) NOT NULL,
  dataNaixement DATE,
  CONSTRAINT pk_persones PRIMARY KEY(codi)
);


-- 26. Afig a la taula "persones" la restricció que 
-- el codi ha d'estar en majúscules.

ALTER TABLE persones
    ADD CONSTRAINT ck_persones_codi CHECK( codi = UPPER(codi) );

-- 27. Afig dos persones: Christopher Nolan (codi CNOLAN), 
-- nascut el 30 de juliol de 1970, i Alfred Hitchcock (codi AHITCH), 
-- la data de naixement del qual no coneixem.

INSERT INTO persones VALUES('CNOLAN', 'Christopher Nolan', 
    TO_DATE('1970-07-30','YYYY-MM-DD'));
INSERT INTO persones (codi, nom) VALUES('AHITCH', 'Alfred Hitchcock');


-- 28. Afig a la taula de pel·lícules un camp anomenat "director", 
-- de 6 lletres, que serà clau aliena a la taula de persones.

ALTER TABLE pellicules
    ADD (director CHAR(6));

ALTER TABLE pellicules
    ADD CONSTRAINT fk_pellicules_persones
    FOREIGN KEY (director) REFERENCES persones(codi);


-- 29. Indica que Nolan va dirigir "El caballero oscuro" i 
-- que Hitchock va dirigir "La ventana indiscreta" (pots usar tant 
-- els codis dels directors com els de les pel·lícules).

UPDATE pellicules
    SET director = 'CNOLAN' WHERE codi = 'eco';
UPDATE pellicules    
    SET director = 'AHITCH' WHERE codi = 'lvi';

    
-- 30. Esborra el registre del director anomenat "Uwe Boll",
-- si existix.

DELETE FROM persones WHERE nom = 'Uwe Boll';


-- 31. Modifica el registre d'Alfred Hitchcock, per a 
-- indicar que va nàixer el 13 d'agost de 1899.

UPDATE persones SET dataNaixement = TO_DATE('1899-08-13','YYYY-MM-DD')
WHERE codi = 'AHITCH';


-- 32. Crea una taula "pelliculesDirectors", bolcant a ella 
-- el títol (nom) i any de cada pel·lícula, juntament amb el nom 
-- del seu director, que potser no coneixem (i en eixe cas hauria
--  de guardar-se com a valor nul).

CREATE TABLE pelliculesDirectors AS
    SELECT 
        pellicules.nom AS titol, 
        anyEstrena, 
        persones.nom AS director
    FROM pellicules LEFT JOIN persones
    ON pellicules.director = persones.codi;

-- 33, 34. A partir d'eixa taula, mostra títol i any per a les 
-- pel·lícules que estiguen entre l'any 1980 i el 2010, 
-- tots dos inclusivament, de dos formes diferents.

SELECT titol, anyEstrena 
FROM pelliculesDirectors
WHERE anyEstrena BETWEEN 1980 AND 2010;

SELECT titol, anyEstrena 
FROM pelliculesDirectors
WHERE anyEstrena >= 1980 AND anyEstrena <= 2010;


-- 35, 36. Mostra les pel·lícules que siguen dels anys 2008 o 2012
-- i que tinguen una valoració de 8 o superior, de 2 formes diferents.

SELECT * FROM pellicules
WHERE valoracio >= 8
AND anyEstrena IN (2008, 2012);

SELECT * FROM pellicules
WHERE valoracio >= 8
AND (anyEstrena = 2008 OR anyEstrena = 2012);


-- 37. Mostra la quantitat de pel·lícules que tenim de cada 
-- categoria (potser cap).

SELECT categories.nom, COUNT(codiPellicula)
FROM categories 
    LEFT JOIN pertanyA ON categories.codi = pertanyA.codiCategoria
    LEFT JOIN pellicules ON pellicules.codi = pertanyA.codiPellicula
GROUP BY categories.nom;


-- 38. Mostra la quantitat de pel·lícules que tenim de cada 
-- categoria, però només per a aquelles categories en les quals 
-- tenim 2 pel·lícules o més.

-- Igual al 19 !!!

SELECT categories.nom, COUNT(codiPellicula)
FROM categories 
    LEFT JOIN pertanyA ON categories.codi = pertanyA.codiCategoria
    LEFT JOIN pellicules ON pellicules.codi = pertanyA.codiPellicula
GROUP BY categories.nom
HAVING COUNT(codiPellicula) >= 2;


-- 39. Afig a la taula "pelliculesDirectors" un camp addicional, 
-- la "categoriaPrincipal", que serà un text de fins a 30 lletres.

ALTER TABLE pelliculesDirectors
    ADD (categoriaPrincipal VARCHAR(30));


-- 40. Elimina la columna "categoriaPrincipal" de la taula 
-- "pelliculesDirectors".

ALTER TABLE pelliculesDirectors
    DROP (categoriaPrincipal);


-- 41. Buida la taula de "pelliculesDirectors", conservant la seua estructura.

TRUNCATE TABLE pelliculesDirectors;


-- 42. Elimina per complet la taula de "pelliculesDirectors".

DROP TABLE pelliculesDirectors;

-- 43, 44, 45. Mostra les pel·lícules el títol de les quals (nom) comença per T (potser en minúscules), de 3 formes diferents.

SELECT * FROM pellicules
WHERE UPPER(nom) LIKE 'T%';

SELECT * FROM pellicules
WHERE SUBSTR(UPPER(nom),1,1) = 'T';

SELECT * FROM pellicules
WHERE INSTR(UPPER(nom),'T') = 1;


-- 46, 47, 48. Mostra les pel·lícules el títol de les quals (nom) acaba en "a", de 3 formes diferents.

SELECT * FROM pellicules
WHERE nom LIKE '%a';

SELECT * FROM pellicules
WHERE SUBSTR(nom,LENGTH(nom),1) = 'a';

SELECT * FROM pellicules
WHERE INSTR(nom,'a',LENGTH(nom)) = LENGTH(nom);


-- 49. Mostra la valoració mitjana de les pel·lícules de la categoria "Acción".

SELECT AVG(valoracio)
FROM pellicules 
    LEFT JOIN pertanyA ON pellicules.codi = pertanyA.codiPellicula
    LEFT JOIN categories ON categories.codi = pertanyA.codiCategoria
WHERE categories.nom = 'Acción';


-- 50. Mostra les pel·lícules (nom, any i valoració) la valoració 
-- de la qual està per damunt de la mitjana.

SELECT nom, anyEstrena, valoracio
FROM pellicules
WHERE valoracio >= 
( 
    SELECT AVG(valoracio)
    FROM pellicules
);

-- 51. Mostra les pel·lícules (nom, any i valoració) que tinguen 
-- la segona millor valoració (haurien d'aparéixer-te les dos
-- pel·lícules que estan valorades amb un 8).

SELECT nom, anyEstrena, valoracio
FROM pellicules
WHERE valoracio < 
( 
    SELECT MAX(valoracio)
    FROM pellicules
)
ORDER BY valoracio DESC
FETCH NEXT 1 ROWS WITH TIES;


-- 52. Mostra, en una única columna, els títols (noms) 
-- de pel·lícules, els noms de directors i els de categories,
-- tot això ordenat alfabèticament.

SELECT nom FROM pellicules
UNION
SELECT nom FROM persones
UNION
SELECT nom FROM categories
ORDER BY nom;


-- 53. Mostra els noms de pel·lícules que no es diuen igual que
-- cap categoria (no hauria d'aparéixer-te "Terror"), usant 
-- operacions de conjunts. 

SELECT nom FROM pellicules
MINUS
SELECT nom FROM categories;


-- 54. Mostra els noms de pel·lícules que no es diuen igual que 
-- cap categoria, usant IN / NOT IN. 

SELECT nom FROM pellicules
WHERE nom NOT IN
(
    SELECT nom FROM categories
);


-- 55. Mostra els noms de pel·lícules que no es diuen igual que 
-- cap categoria, usant ALL / ANY. 

SELECT nom FROM pellicules
WHERE nom <> ALL
(
    SELECT nom FROM categories
);


-- 56. Mostra els noms de pel·lícules que no es diuen igual que 
-- cap categoria, usant EXISTS / NOT EXISTS. 

SELECT nom FROM pellicules
WHERE NOT EXISTS
(
    SELECT 1 FROM categories
    WHERE categories.nom = pellicules.nom
);


-- 57. Mostra el nom de cada pel·lícula, any i codi de pel·lícula 
-- de la qual és remake, o bé el text "(Original)", si no és 
-- remake de cap anterior.

SELECT nom, anyEstrena, NVL(remakeDe, '(Original)')
FROM pellicules;

-- 58. Mostra el nom de cada pel·lícula (precedit per "Pel·lícula: ") 
-- i el nom del seu director (potser buit, precedit per "Director: ").

-- A partir de 32

SELECT 
    CONCAT('Pel·lícula: ', pellicules.nom) AS titol, 
    CONCAT('Director: ', persones.nom) AS director
FROM pellicules LEFT JOIN persones
ON pellicules.director = persones.codi;


-- 59. Afig al director "Ridley Scott", amb codi "RSCOTT". Mostra el 
-- títol (nom) de totes les pel·lícules que tenim, juntament amb el nom 
-- del seu director. Han d'aparéixer totes les pel·lícules (fins i tot si 
-- d'alguna no coneixem el director) i tots els directors (fins i tot si 
-- no coneixem cap pel·lícula seua).

INSERT INTO persones VALUES('RSCOTT', 'Ridley Scott', NULL);

SELECT 
    pellicules.nom AS titol, 
    persones.nom AS director
FROM pellicules FULL JOIN persones
ON pellicules.director = persones.codi;


-- 60. Nom i valoració de les pel·lícules que no tinguen ni la 
-- valoració més alta de la nostra base de dades ni la valoració més baixa.

SELECT nom, valoracio
FROM pellicules
WHERE valoracio < 
( 
    SELECT MAX(valoracio)
    FROM pellicules
)
AND valoracio >
( 
    SELECT MIN(valoracio)
    FROM pellicules
);

-- 61. Nom i valoració de la pel·lícula més valorada de cada categoria.

-- La consulta més difícil! (probablement)

-- Previ 1: nom, categoria y valoracio (exercici 10)

SELECT pellicules.nom, categories.nom, valoracio
FROM pellicules 
    INNER JOIN pertanyA ON pellicules.codi = pertanyA.codiPellicula
    INNER JOIN categories ON categories.codi = pertanyA.codiCategoria;

-- Previ 2: valoració màxima de cada categoria

SELECT categories.nom, MAX(valoracio)
FROM pellicules 
    INNER JOIN pertanyA ON pellicules.codi = pertanyA.codiPellicula
    INNER JOIN categories ON categories.codi = pertanyA.codiCategoria
GROUP BY categories.nom;

-- O només amb codi

SELECT codiCategoria, MAX(valoracio)
FROM pellicules 
    INNER JOIN pertanyA ON pellicules.codi = pertanyA.codiPellicula
GROUP BY codiCategoria;


-- Consulta completa

SELECT c.nom, p1.nom, valoracio
FROM pellicules p1
    INNER JOIN pertanyA pert1 ON p1.codi = pert1.codiPellicula
    INNER JOIN categories c ON c.codi = pert1.codiCategoria
WHERE valoracio = 
(
    SELECT MAX(valoracio)
    FROM pellicules p2
        INNER JOIN pertanyA pert2 ON p2.codi = pert2.codiPellicula
    WHERE pert2.codiCategoria = c.codi
);


-- 62. Mostra les pel·lícules (codi, nom i any) que coincidixen en 
-- alguna categoria amb "El caballero oscuro".

-- Previ: Categories d'eixa pel·lícula

SELECT pertanyA.codiCategoria
FROM pellicules
    INNER JOIN pertanyA ON pellicules.codi = pertanyA.codiPellicula
WHERE nom = 'El caballero oscuro';

-- Consulta completa

SELECT codi, nom, anyEstrena
FROM pellicules
    INNER JOIN pertanyA ON pellicules.codi = pertanyA.codiPellicula
WHERE codiCategoria IN
(
    SELECT pertanyA.codiCategoria
    FROM pellicules
        INNER JOIN pertanyA ON pellicules.codi = pertanyA.codiPellicula
    WHERE nom = 'El caballero oscuro'
);

-- Sense eixa pel·lícula (opcional)

SELECT codi, nom, anyEstrena
FROM pellicules
    INNER JOIN pertanyA ON pellicules.codi = pertanyA.codiPellicula
WHERE codiCategoria IN
(
    SELECT pertanyA.codiCategoria
    FROM pellicules
        INNER JOIN pertanyA ON pellicules.codi = pertanyA.codiPellicula
    WHERE nom = 'El caballero oscuro'
)
AND nom <> 'El caballero oscuro';


-- 63. Mostra les pel·lícules (codi, nom i any) que coincidixen en 
-- alguna categoria amb "El caballero oscuro" o amb "La ventana indiscreta".

SELECT codi, nom, anyEstrena
FROM pellicules
    INNER JOIN pertanyA ON pellicules.codi = pertanyA.codiPellicula
WHERE codiCategoria IN
(
    SELECT pertanyA.codiCategoria
    FROM pellicules
        INNER JOIN pertanyA ON pellicules.codi = pertanyA.codiPellicula
    WHERE nom = 'El caballero oscuro'
)
OR codiCategoria IN
(
    SELECT pertanyA.codiCategoria
    FROM pellicules
        INNER JOIN pertanyA ON pellicules.codi = pertanyA.codiPellicula
    WHERE nom = 'La ventana indiscreta'
);
