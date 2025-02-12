-- Exercicis de SQL (Repàs 11)

CREATE TABLE exercici (
  codi CHAR(5) PRIMARY KEY,
  nom VARCHAR2(100),
  dificultat NUMERIC(3,1)
);

CREATE TABLE tema (
  codi CHAR(8) PRIMARY KEY,
  nom VARCHAR2(80) NOT NULL
);

CREATE TABLE tractaDe (
  codiExercici CHAR(5),
  codiTema CHAR(8),
  PRIMARY KEY(codiExercici, codiTema),
  FOREIGN KEY (codiExercici) REFERENCES exercici(codi),
  FOREIGN KEY (codiTema) REFERENCES tema(codi)
);

INSERT INTO exercici VALUES('04061', 'Func. Matem. 1', 6);
INSERT INTO exercici VALUES('04062', 'Func. Matem. 2', 7);
INSERT INTO exercici VALUES('04006', 'LIKE', 4);
INSERT INTO exercici VALUES('04060', 'Repàs 10', 9.2);
INSERT INTO exercici VALUES('04063', 'Func. cadenes', NULL);

INSERT INTO tema VALUES('MOD', 'MOD (Resta de divisió)');
INSERT INTO tema VALUES('POWER', 'POWER (Potència)');
INSERT INTO tema VALUES('SQRT', 'SQRT (Arrel)');
INSERT INTO tema VALUES('ROUND', 'ROUND (Arredonir)');
INSERT INTO tema VALUES('TRUNC', 'TRUNC (Truncar)');
INSERT INTO tema VALUES('LIKE', 'LIKE (Cerca per contingut)');
INSERT INTO tema VALUES('SUBC', 'Subconsultes');

INSERT INTO tractaDe VALUES('04006', 'LIKE');
INSERT INTO tractaDe VALUES('04060', 'LIKE');
INSERT INTO tractaDe VALUES('04061', 'MOD');
INSERT INTO tractaDe VALUES('04061', 'POWER');
INSERT INTO tractaDe VALUES('04061', 'SQRT');
INSERT INTO tractaDe VALUES('04062', 'ROUND');
INSERT INTO tractaDe VALUES('04062', 'TRUNC');

-- -------------------------------------------------------------------------

-- 1. Noms de temes que comencen per S (potser amb majúscules distintes), usant comodins.

SELECT nom FROM tema WHERE UPPER(nom) LIKE 'S%';


-- 2. Noms de temes que comencen per S (potser amb majúscules distintes), usant SUBSTR.

SELECT nom FROM tema WHERE SUBSTR(UPPER(nom),1,1) = 'S';


-- 3. Noms de temes que comencen per S (potser amb majúscules distintes), usant INSTR.

SELECT nom FROM tema WHERE INSTR(UPPER(nom), 'S') = 1;


-- 4. Quantitat d'exercicis del tema anomenat "LIKE".

SELECT COUNT(*) FROM exercici 
JOIN tractaDe ON exercici.codi = tractaDe.codiExercici
JOIN tema on tema.codi = tractaDe.codiTema
WHERE tema.nom = 'LIKE (Cerca per contingut)';


-- 5. Nom de cada tema i quantitat d'exercicis d'eixe tema, per als temes dels quals tenim més d'un exercici.

-- Previ:

SELECT nom, COUNT(codiExercici)
FROM tema JOIN tractaDe ON tema.codi = tractaDe.codiTema
GROUP BY nom;

-- Solució real

SELECT nom, COUNT(codiExercici)
FROM tema JOIN tractaDe ON tema.codi = tractaDe.codiTema
GROUP BY nom
HAVING COUNT(codiExercici) > 1;


-- 6. Nom de cada exercici i nom del tema al qual pertany, enllaçant amb WHERE.

SELECT exercici.nom, tema.nom 
FROM exercici, tractaDe, tema
WHERE exercici.codi = tractaDe.codiExercici
AND tema.codi = tractaDe.codiTema;


-- 7. Nom de cada exercici i nom del tema al qual pertany, enllaçant amb INNER JOIN.

SELECT exercici.nom, tema.nom FROM exercici 
INNER JOIN tractaDe ON exercici.codi = tractaDe.codiExercici
INNER JOIN tema ON tema.codi = tractaDe.codiTema;


-- 8. Nom de cada exercici i nom del tema al qual pertany, fins i tot per als exercicis que no pertanyen a cap tema.

SELECT exercici.nom, tema.nom FROM exercici 
LEFT JOIN tractaDe ON exercici.codi = tractaDe.codiExercici
LEFT JOIN tema on tema.codi = tractaDe.codiTema;


-- 9. Noms d'exercicis que coincidixen amb el codi d'algun tema, enllaçant amb ANY o ALL.

-- Només Oracle

SELECT nom FROM exercici 
WHERE nom = ANY
(
    SELECT codi FROM tema
);


-- 10. Noms d'exercicis que coincidixen amb el codi d'algun tema, enllaçant amb EXISTS o NOT EXISTS.

SELECT nom FROM exercici 
WHERE EXISTS
(
    SELECT codi FROM tema
    WHERE tema.codi = exercici.nom
);


-- 11. Noms d'exercicis que coincidixen amb el codi d'algun tema, enllaçant amb IN o NOT IN.

SELECT nom FROM exercici 
WHERE nom IN
(
    SELECT codi FROM tema
);


-- 12. Noms d'exercicis que coincidixen amb el codi d'algun tema, enllaçant amb INNER JOIN.

SELECT exercici.nom 
FROM exercici INNER JOIN tema
ON exercici.nom = tema.codi;


-- 13. Noms d'exercicis que coincidixen amb el codi d'algun tema, enllaçant amb operacions de conjunts.

SELECT nom FROM exercici 
INTERSECT
SELECT codi FROM tema;


-- 14. Nom i dificultat dels exercicis més difícils que la mitjana.

SELECT nom, dificultat FROM exercici 
WHERE dificultat > ( SELECT AVG(dificultat) FROM exercici );


-- 15. Nom i dificultat dels 3 exercicis més difícils, ordenats del més difícil al més fàcil, usant sintaxi d'Oracle.

-- SQLite

SELECT nom, dificultat FROM exercici 
ORDER BY dificultat DESC
LIMIT 3;

-- Oracle

SELECT nom, dificultat FROM exercici 
ORDER BY dificultat DESC
FETCH NEXT 3 ROWS ONLY;


-- 16. Nom de cada tema i dificultat mitjana dels seus exercicis, arredonida a una xifra decimal.

SELECT tema.nom, ROUND(AVG(dificultat), 1) 
FROM tema 
    JOIN tractaDe ON tema.codi = tractaDe.codiTema
    JOIN exercici ON exercici.codi = tractaDe.codiExercici
GROUP BY tema.nom;


-- 17. Nom dels exercicis, en majúscules, per a aquells amb dificultat entre 5 i 7 (inclosos), ordenats del més difícil al més fàcil, i, en cas de coincidir, per nom.

SELECT UPPER(nom) FROM exercici 
WHERE dificultat BETWEEN 5 AND 7
ORDER BY dificultat DESC, nom ASC;


-- 18. Nom dels exercicis la dificultat dels quals no coneguem, reemplaçant els espais per guions.

SELECT REPLACE(nom, ' ', '-') FROM exercici 
WHERE dificultat IS NULL;


-- 19. Noms dels temes per als quals existisca algun exercici la dificultat del qual no coneguem.

-- Afegim dades de prova

INSERT INTO exercici VALUES('04069', 'Repàs 11', NULL);
INSERT INTO tractaDe VALUES('04069', 'ROUND');
INSERT INTO tractaDe VALUES('04069', 'LIKE');

-- Previ: exercicis sense dificultat

SELECT nom 
FROM exercici
WHERE dificultat IS NULL;

-- Consulta completa: temes d'eixos exercicis

SELECT DISTINCT tema.nom 
FROM tema 
    JOIN tractaDe ON tema.codi = tractaDe.codiTema
    JOIN exercici ON exercici.codi = tractaDe.codiExercici
WHERE dificultat IS NULL;


-- 20, 21. Codi i nom dels exercicis que pertanyen al tema de codi "LIKE" o del codi "MOD", de 2 formes distintes.

SELECT codi, nom FROM exercici 
JOIN tractaDe ON exercici.codi = tractaDe.codiExercici
WHERE tractaDe.codiTema = 'LIKE' OR tractaDe.codiTema = 'MOD';

SELECT codi, nom FROM exercici 
JOIN tractaDe ON exercici.codi = tractaDe.codiExercici
WHERE tractaDe.codiTema IN ('LIKE', 'MOD');


-- 22. Crea una taula "repassos", amb la data, el codi d'exercici (formant una clau composta) i el comentari sobre l'exercici.

-- SQLite

CREATE TABLE repassos
(
    data DATE,
    codiExercici CHAR(5), 
    comentari VARCHAR(100),
    PRIMARY KEY (data, codiExercici)
);

-- Oracle

CREATE TABLE repassos
(
    data DATE,
    codiExercici CHAR(5), 
    comentari VARCHAR2(100),
    CONSTRAINT pk_repassos PRIMARY KEY (data, codiExercici)
);


-- 23. Bolca a la taula repassos, amb data de hui i sense comentari, els dos exercicis amb la dificultat més baixa.

-- Previ 1: dos exercicis amb la dificultat més baixa

SELECT codi, nom, dificultat FROM exercici
WHERE dificultat IS NOT NULL
ORDER BY dificultat LIMIT 2;

-- Real, SQLite

INSERT INTO repassos
    SELECT DATE('now'), codi, NULL
    FROM exercici
    WHERE dificultat IS NOT NULL
    ORDER BY dificultat LIMIT 2;

SELECT * FROM repassos;

-- Real, Oracle

INSERT INTO repassos
    SELECT SYSDATE, codi, NULL
    FROM exercici
    WHERE dificultat IS NOT NULL
    ORDER BY dificultat FETCH NEXT 2 ROWS ONLY;

SELECT * FROM repassos;


-- 24. Modifica la dificultat de l'exercici de codi "04063", per a indicar que val 7.

UPDATE exercici SET dificultat = 7
WHERE codi = '04063';


-- 25. Esborra de la taula de repassos l'exercici més difícil que apareix en ella.

-- Mirant en exercici (potser no correcte, si no apareix en repassos)

-- Previ: codi del exercici més difícil

SELECT codi FROM exercici 
WHERE dificultat = (SELECT MAX(dificultat) FROM exercici);

-- Consulta completa

DELETE FROM repassos WHERE codiExercici =
(
    SELECT codi FROM exercici 
    WHERE dificultat = 
    (
        SELECT MAX(dificultat) FROM exercici
    )
);

-- Correcta: mirant en repassos i en exercici

-- Previ: codi del exercici de repàs més difícil 

SELECT codi, dificultat 
FROM repassos 
    JOIN exercici ON repassos.codiExercici = exercici.codi
ORDER BY dificultat DESC LIMIT 1;

-- Consulta completa, SQLite

DELETE FROM repassos WHERE codiExercici =
(
    SELECT codi
    FROM repassos 
        JOIN exercici ON repassos.codiExercici = exercici.codi
    ORDER BY dificultat DESC LIMIT 1
);

-- Consulta completa, Oracle

DELETE FROM repassos WHERE codiExercici =
(
    SELECT codi
    FROM repassos 
        JOIN exercici ON repassos.codiExercici = exercici.codi
    ORDER BY dificultat DESC FETCH NEXT 1 ROWS ONLY
);


-- Prova

SELECT * FROM repassos;

-- 26. Bolca el contingut de la taula de repassos a una nova taula anomenat "repassos_backup".

CREATE TABLE repassos_backup AS
    SELECT * FROM repassos;

SELECT * FROM repassos_backup;


-- 27. Buida el contingut de la taula de repassos, conservant la seua estructura.

-- Oracle

TRUNCATE TABLE repassos;

-- SQLite

DELETE FROM repassos;


-- 28. Crea una vista "v_exercicis" que retorne el nom de cada exercici, el seu codi, la seua dificultat i, precedit per "Tema: ", el nom de la categoria a la qual pertany.

-- Previ

SELECT exercici.nom, exercici.codi, dificultat, tema.nom FROM exercici 
INNER JOIN tractaDe ON exercici.codi = tractaDe.codiExercici
INNER JOIN tema on tema.codi = tractaDe.codiTema;

-- Real

CREATE VIEW v_exercicis AS
    SELECT exercici.nom, exercici.codi, dificultat, 
    CONCAT('Tema: ', tema.nom ) AS tema
    FROM exercici 
        INNER JOIN tractaDe ON exercici.codi = tractaDe.codiExercici
        INNER JOIN tema on tema.codi = tractaDe.codiTema;

SELECT * FROM v_exercicis;


-- 29. Usant eixa vista, mostra el nom i la dificultat dels exercicis la dificultat dels quals està per damunt de la mitjana.

SELECT DISTINCT nom, dificultat FROM v_exercicis 
WHERE dificultat > (SELECT AVG(dificultat) FROM v_exercicis);


-- 30. Mostra codi i nom dels exercicis que pertanyen a temes distints del tema (o temes) de l'exercici més difícil.

-- Previ 1: codi del exercici del més difícil

SELECT codi FROM exercici 
WHERE dificultat = 
(
    SELECT MAX(dificultat) FROM exercici
);

-- Previ 2: codi de temes del exercici més difícil

SELECT codiTema FROM tractaDe WHERE codiExercici =
(
    SELECT codi FROM exercici 
    WHERE dificultat = 
    (
        SELECT MAX(dificultat) FROM exercici
    )
);

-- Final:

SELECT DISTINCT codi, nom
FROM exercici JOIN tractaDe ON codi = codiExercici
WHERE codiTema NOT IN
(
    SELECT codiTema FROM tractaDe WHERE codiExercici =
    (
        SELECT codi FROM exercici 
        WHERE dificultat = 
        (
            SELECT MAX(dificultat) FROM exercici
        )
    )
);
 


-- -------------------------------------------------------------------------

-- 1. Nombres de temas que comienzan por S (quizá con mayúsculas distintas), usando comodines.

-- 2. Nombres de temas que comienzan por S (quizá con mayúsculas distintas), usando SUBSTR.

-- 3. Nombres de temas que comienzan por S (quizá con mayúsculas distintas), usando INSTR.

-- 4. Cantidad de ejercicios del tema llamado "LIKE".

-- 5. Nombre de cada tema y cantidad de ejercicios de ese tema, para los temas de los que tenemos más de un ejercicio.

-- 6. Nombre de cada ejercicio y nombre del tema al que pertenece, enlazando con WHERE.

-- 7. Nombre de cada ejercicio y nombre del tema al que pertenece, enlazando con INNER JOIN.

-- 8. Nombre de cada ejercicio y nombre del tema al que pertenece, incluso para los ejercicios que no pertenecen a ningún tema.

-- 9. Nombres de ejercicios que coinciden con el código de algún tema, enlazando con ANY o ALL.

-- 10. Nombres de ejercicios que coinciden con el código de algún tema, enlazando con EXISTS o NOT EXISTS.

-- 11. Nombres de ejercicios que coinciden con el código de algún tema, enlazando con IN o NOT IN.

-- 12. Nombres de ejercicios que coinciden con el código de algún tema, enlazando con INNER JOIN.

-- 13. Nombres de ejercicios que coinciden con el código de algún tema, enlazando con operaciones de conjuntos.

-- 14. Nombre y dificultad de los ejercicios más difíciles que la media.

-- 15. Nombre y dificultad de los 3 ejercicios más difíciles, ordenados del más difícil al más fácil, usando sintaxis de Oracle.

-- 16. Nombre de cada tema y dificultad media de sus ejercicios, redondeada a una cifra decimal.

-- 17. Nombre de los ejercicios, en mayúsculas, para aquellos con dificultad entre 5 y 7 (incluidos), ordenados del más difícil al más fácil, y, en caso de coincidir, por nombre.

-- 18. Nombre de los ejercicios cuya dificultad no conozcamos, reemplazando los espacios por guiones.

-- 19. Nombres de los temas para los que exista algún ejercicio cuya dificultad no conozcamos.

-- 20, 21. Código y nombre de los ejercicios que pertenecen al tema de código "LIKE" o del código "MOD", de 2 formas distintas.

-- 22. Crea una tabla "repasos", con la fecha, el código de ejercicio (ambos forman una clave compuesta) y el comentario sobre el ejercicio.

-- 23. Vuelca a la tabla repasos, con fecha de hoy y sin comentario, los dos ejercicios con la dificultad más baja.

-- 24. Modifica la dificultad del ejercicio de código "04063", para indicar que vale 7.

-- 25. Borra de la tabla de repasos el ejercicio más difícil que aparece en ella.

-- 26. Vuelca el contenido de la tabla de repasos a una nueva tabla llamado "repasos_backup".

-- 27. Vacía el contenido de la tabla de repasos, conservando su estructura.

-- 28. Crea una vista "v_exercicis" que devuelva el nombre de cada ejercicio, su código, su dificultad y, precedido por "Tema: ", el nombre de la categoría a la que pertenece.

-- 29. Usando esa vista, muestra el nombre y la dificultad de los ejercicios cuya dificultad está por encima de la media.

-- 30. Muestra código y nombre de los ejercicios que pertenecen a temas distintos del tema (o temas) del ejercicio más difícil.
