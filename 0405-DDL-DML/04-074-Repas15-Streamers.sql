-- Streamers y temáticas (relación M:M)

CREATE TABLE streamers (
  codigo VARCHAR(6) PRIMARY KEY,
  nombre VARCHAR(30),
  pais VARCHAR(20)
);

CREATE TABLE tematicas (
  codigo VARCHAR(4) PRIMARY KEY,
  nombre VARCHAR(30)
);

CREATE TABLE hablaSobre (
  codigoStreamer VARCHAR(6),
  codigoTematica VARCHAR(4),
  idioma VARCHAR2(10),
  medio VARCHAR2(20),
  milesSeguidores NUMERIC(6,1),
  PRIMARY KEY (codigoStreamer, codigoTematica)
);

INSERT INTO streamers VALUES ('ill','Ibai Llanos', 'España');
INSERT INTO streamers VALUES ('ap','AuronPlay', 'España');
INSERT INTO streamers VALUES ('ng','Nate Gentile', 'España');
INSERT INTO streamers VALUES ('ltt','Linus Tech Tips', 'Canadá');
INSERT INTO streamers VALUES ('dyip','DYI Perks', NULL);
INSERT INTO streamers VALUES ('ach','Alexandre Chappel', 'Noruega');
INSERT INTO streamers VALUES ('tkn','Tekendo','España');
INSERT INTO streamers VALUES ('cad','Caddac Tech',NULL);

INSERT INTO tematicas VALUES ('inf','Informática');
INSERT INTO tematicas VALUES ('tec','Tecnología en general');
INSERT INTO tematicas VALUES ('gam','Gaming');
INSERT INTO tematicas VALUES ('var','Variado');
INSERT INTO tematicas VALUES ('bri','Bricolaje');
INSERT INTO tematicas VALUES ('via','Viajes');
INSERT INTO tematicas VALUES ('hum','Humor');

INSERT INTO hablaSobre VALUES ('ap','gam','Español','YouTube',29200);
INSERT INTO hablaSobre VALUES ('ill','var','Español','Twitch',12800);
INSERT INTO hablaSobre VALUES ('ap','var','Español','Twitch',14900);
INSERT INTO hablaSobre VALUES ('ng','inf','Español','YouTube',2450);
INSERT INTO hablaSobre VALUES ('ltt','inf','Inglés','YouTube',15200);
INSERT INTO hablaSobre VALUES ('dyip','bri','Inglés','YouTube',4140);
INSERT INTO hablaSobre VALUES ('ach','bri','Inglés','YouTube',370);
INSERT INTO hablaSobre VALUES ('cad','inf','Inglés','YouTube',3);

-- 01. Nombre de las temáticas que tenemos almacenadas, 
-- ordenadas alfabéticamente.

SELECT nombre FROM tematicas ORDER BY nombre;

-- 02. Cantidad de streamers cuyo país es "España".

SELECT COUNT(*) FROM streamers WHERE pais = 'España';

-- 03, 04, 05. Nombres de streamers cuya segunda letra no sea una "B" (quizá en minúsculas), de 3 formas distintas.

SELECT nombre FROM streamers
WHERE NOT UPPER(nombre) LIKE '_B%';

SELECT nombre FROM streamers
WHERE SUBSTR(UPPER(nombre),2,1) <> 'B';

SELECT nombre FROM streamers
WHERE INSTR(UPPER(nombre),'B',2) <> 2;

-- 06. Media de seguidores para los canales cuyo idioma es "Español".

SELECT AVG(milesSeguidores)*1000 AS mediaSeguidores
FROM hablaSobre WHERE idioma = 'Español';

-- 07. Media de seguidores para los canales cuyo streamer es del país "España".

SELECT AVG(milesSeguidores)*1000 AS mediaSeguidores
FROM hablaSobre JOIN streamers
ON hablaSobre.codigoStreamer = streamers.codigo
WHERE pais = 'España';

-- 08. Nombre de cada streamer y medio en el que habla, para aquellos 
-- que tienen entre 5.000 y 15.000 miles de seguidores, usando BETWEEN.

SELECT nombre, medio
FROM streamers JOIN hablaSobre
ON streamers.codigo = hablaSobre.codigoStreamer
WHERE milesSeguidores BETWEEN 5000 AND 15000;

-- 09. Nombre de cada streamer y medio en el que habla, para aquellos 
-- que tienen entre 5.000 y 15.000 miles de seguidores, sin usar BETWEEN.

SELECT nombre, medio
FROM streamers JOIN hablaSobre
ON streamers.codigo = hablaSobre.codigoStreamer
WHERE milesSeguidores >= 5000 AND milesSeguidores <= 15000;

-- 10. Nombre de cada temática y nombre de los idiomas en que tenemos
-- canales de esa temática (quizá ninguno), sin duplicados.

SELECT DISTINCT nombre, idioma
FROM tematicas LEFT JOIN hablaSobre
ON tematicas.codigo = hablaSobre.codigoTematica;

-- 11. Nombre de cada streamer, nombre de la temática de la que 
-- habla y del medio en el que habla de esa temática, usando INNER JOIN.

SELECT s.nombre AS streamer, t.nombre AS tema, medio
FROM streamers s
    INNER JOIN hablaSobre
        ON s.codigo = hablaSobre.codigoStreamer
    INNER JOIN tematicas t
        ON hablaSobre.codigoTematica = t.codigo;

-- 12. Nombre de cada streamer, temática y medio en el que habla 
-- de esa temática, usando WHERE.

SELECT s.nombre AS streamer, t.nombre AS tema, medio
FROM streamers s, hablaSobre, tematicas t
WHERE s.codigo = hablaSobre.codigoStreamer
AND hablaSobre.codigoTematica = t.codigo;

-- 13. Nombre de cada streamer, del medio en el que habla y
-- de la temática de la que habla en ese medio, incluso si de algún 
-- streamer no tenemos dato del medio o de la temática.

SELECT s.nombre AS streamer, t.nombre AS tema, medio
FROM streamers s
    LEFT JOIN hablaSobre
        ON s.codigo = hablaSobre.codigoStreamer
    LEFT JOIN tematicas t
        ON hablaSobre.codigoTematica = t.codigo;

-- 14. Nombre de cada medio y cantidad de canales que tenemos 
-- anotados en él, ordenado alfabéticamente por el nombre del medio.

SELECT medio, COUNT(*)
FROM hablaSobre
GROUP BY medio;

-- 15, 16, 17, 18. Medio en el que se emite el canal de más
-- seguidores, de 4 formas distintas.

-- Order By

SELECT medio , milesSeguidores FROM hablaSobre
ORDER BY milesSeguidores DESC
FETCH NEXT 1 ROWS ONLY;

-- Max

SELECT medio FROM hablaSobre
WHERE milesSeguidores = 
(
    SELECT MAX(milesSeguidores) FROM hablaSobre
);

-- All

SELECT medio FROM hablaSobre
WHERE milesSeguidores >= ALL
(
    SELECT milesSeguidores FROM hablaSobre
);

-- Not Exists

SELECT medio FROM hablaSobre h1
WHERE NOT EXISTS
(
    SELECT 1 FROM hablaSobre h2
    WHERE h2.milesSeguidores > h1.milesSeguidores
);

-- 19. Temáticas de las que tenemos 2 o más canales.

SELECT nombre, COUNT(*) AS canales
FROM tematicas
    JOIN hablaSobre
    ON tematicas.codigo = hablaSobre.codigoTematica
GROUP BY nombre
HAVING COUNT(*) >= 2;

-- 20. Temáticas de las que no tenemos anotado ningún canal, 
-- ordenadas, empleando COUNT.

SELECT nombre
FROM tematicas
    LEFT JOIN hablaSobre
    ON tematicas.codigo = hablaSobre.codigoTematica
GROUP BY nombre
HAVING COUNT(hablaSobre.codigoStreamer) = 0
ORDER BY nombre;

-- 21. Temáticas de las que no tenemos anotado ningún canal, ordenadas, 
-- empleando IN / NOT IN.

SELECT nombre
FROM tematicas
WHERE codigo NOT IN (SELECT codigoTematica FROM hablaSobre)
ORDER BY nombre;

-- 22. Temáticas de las que no tenemos anotado ningún canal, ordenadas, 
-- empleando ALL / ANY.

SELECT nombre
FROM tematicas
WHERE codigo <> ALL (SELECT codigoTematica FROM hablaSobre)
ORDER BY nombre;


-- 23. Temáticas de las que no tenemos ningún canal, ordenadas,
-- empleando EXISTS / NOT EXISTS.

SELECT nombre
FROM tematicas
WHERE NOT EXISTS 
(
    SELECT codigoTematica FROM hablaSobre
    WHERE tematicas.codigo = hablaSobre.codigoTematica
)
ORDER BY nombre;

-- 24. Tres primeras letras de cada país y tres primeras 
-- letras de cada idioma, en una misma lista.

SELECT SUBSTR(pais,1,3) FROM streamers
UNION
SELECT SUBSTR(idioma,1,3) FROM hablaSobre;

-- 25, 26, 27, 28. Tres primeras letras de países que coincidan 
-- con las tres primeras letras de un idioma, sin duplicados, 
-- de cuatro formas distintas.

-- Intersección

SELECT SUBSTR(pais,1,3) FROM streamers
INTERSECT
SELECT SUBSTR(idioma,1,3) FROM hablaSobre;

-- IN

SELECT DISTINCT SUBSTR(pais,1,3) FROM streamers
WHERE SUBSTR(pais,1,3) IN 
(
    SELECT SUBSTR(idioma,1,3) FROM hablaSobre
);

-- ANY

SELECT DISTINCT SUBSTR(pais,1,3) FROM streamers
WHERE SUBSTR(pais,1,3) = ANY
(
    SELECT SUBSTR(idioma,1,3) FROM hablaSobre
);

-- EXISTS

SELECT DISTINCT SUBSTR(pais,1,3) FROM streamers
WHERE EXISTS
(    
    SELECT 1 FROM hablaSobre
    WHERE SUBSTR(idioma,1,3) = SUBSTR(pais,1,3)
);

-- JOIN

SELECT DISTINCT SUBSTR(pais,1,3) FROM streamers JOIN hablaSobre
ON SUBSTR(idioma,1,3) = SUBSTR(pais,1,3);

-- WHERE

SELECT DISTINCT SUBSTR(pais,1,3) FROM streamers, hablaSobre
WHERE SUBSTR(idioma,1,3) = SUBSTR(pais,1,3);

-- 29. Nombre de streamer, nombre de medio y nombre de temática, 
-- para los canales que están por encima de la media de seguidores.

-- Previo, basado en el 11

SELECT s.nombre AS streamer, medio, t.nombre AS tema, milesSeguidores
FROM streamers s
    INNER JOIN hablaSobre
        ON s.codigo = hablaSobre.codigoStreamer
    INNER JOIN tematicas t
        ON hablaSobre.codigoTematica = t.codigo;
        
-- Completo

SELECT s.nombre AS streamer, medio, t.nombre AS tema 
FROM streamers s
    INNER JOIN hablaSobre
        ON s.codigo = hablaSobre.codigoStreamer
    INNER JOIN tematicas t
        ON hablaSobre.codigoTematica = t.codigo
WHERE milesSeguidores > (SELECT AVG(milesSeguidores) FROM hablaSobre;

-- 30. Nombre de streamer y medio, para los canales que hablan 
-- de la temática "Bricolaje".

-- Basado en 11

SELECT s.nombre AS streamer, medio 
FROM streamers s
    INNER JOIN hablaSobre
        ON s.codigo = hablaSobre.codigoStreamer
    INNER JOIN tematicas t
        ON hablaSobre.codigoTematica = t.codigo
WHERE t.nombre = 'Bricolaje';

-- 31. Crea una tabla de "juegos". Para cada juego querremos un 
-- código (5 cifras, clave primaria), un nombre (hasta 20 letras, 
-- no nulo) y una referencia al streamer que más habla de él 
-- (clave ajena a la tabla "streamers"). Usa sintaxis de Oracle.

CREATE TABLE juegos (
    codigo NUMBER(5) ,
    nombre VARCHAR2(20) NOT NULL,
    codigoStreamer VARCHAR2(6),
    CONSTRAINT pk_juegos PRIMARY KEY(codigo),
    CONSTRAINT fk_juegos_streamers 
        FOREIGN KEY(codigoStreamer) REFERENCES streamers(codigo)
);

-- 32. Añade a la tabla de juegos la restricción de que el código 
-- debe ser 1000 o superior.

ALTER TABLE juegos
ADD CONSTRAINT ck_juegos_codigo CHECK(codigo >= 1000);

-- 33. Añade 3 datos de ejemplo en la tabla de juegos. Para uno 
-- indicarás todos los campos, para otro no indicarás el streamer, 
-- ayudándote de NULL, y para el tercero no indicarás el streamer 
-- porque no detallarás todos los nombres de los campos.

INSERT INTO juegos VALUES(1001, 'Fortnite', 'tkn');
INSERT INTO juegos VALUES(1002, 'Alien isolation', NULL);
INSERT INTO juegos (codigo, nombre) VALUES (1003, 'World War Z');

-- 34. Borra el segundo dato de ejemplo que has añadido en 
-- la tabla de juegos, a partir de su código.

DELETE FROM juegos WHERE codigo = 1002;

-- 35. Muestra el nombre de cada juego junto al nombre del streamer
-- que más habla de él, si existe. Los datos aparecerán ordenados 
-- por nombre de juego y, en caso de coincidir éste, por streamer.

SELECT j.nombre AS juego, s.nombre AS personita
FROM juegos j LEFT JOIN streamers s
ON j.codigoStreamer = s.codigo
ORDER BY juego, personita;

-- 36. Modifica el último dato de ejemplo que has añadido 
-- en la tabla de juegos, para que sí tenga asociado un streamer
-- que hable de él.

-- A partir del código (suficiente)

UPDATE juegos SET codigoStreamer = 'ill'
WHERE codigo = 103;

-- Sin usar códigos, buscándolos (más avanzado, no se pedía)

UPDATE juegos SET codigoStreamer = 
    (SELECT codigo FROM streamers WHERE nombre = 'Ibai Llanos')
WHERE codigo = 
    (SELECT MAX(codigo) FROM juegos);

-- Comprobación

SELECT * FROM juegos;

-- 37. Crea una tabla "juegosStreamers", volcando en ella el nombre 
-- de cada juego (con el alias "juego") y el nombre del streamer 
-- que habla de él (con el alias "streamer").

CREATE TABLE juegosStreamers AS
    SELECT j.nombre AS juego, s.nombre AS streamer
    FROM juegos j LEFT JOIN streamers s
    ON j.codigoStreamer = s.codigo;

SELECT * FROM juegosStreamers;

-- 38. Añade a la tabla "juegosStreamers" un campo "fechaPrueba".

ALTER TABLE juegosStreamers
    ADD fechaPrueba DATE;

-- 39. Pon la fecha de hoy (prefijada, sin usar SYSDATE) en el 
-- campo "fechaPrueba" de todos los registros de la tabla
-- "juegosStreamers".

UPDATE juegosStreamers
SET fechaPrueba = TO_DATE('26-02-2025', 'DD-MM-YYYY');

-- 40. Muestra juego, streamer y fecha de ayer (día anterior al 
-- valor del campo "fechaPrueba") para todos los registros de la
-- tabla "juegosStreamers".

SELECT juego, streamer, fechaPrueba-1 AS fechaAyer FROM juegosStreamers;

-- 41. Muestra todos los datos de los registros de la tabla
-- "juegosStreamers" que sean del año actual de 2 formas distintas
-- (por ejemplo, usando comodines o funciones de cadenas).

SELECT * FROM juegosStreamers
WHERE TO_CHAR(fechaPrueba, 'YYYY-MM-DD') LIKE '2025%';

SELECT * FROM juegosStreamers
WHERE SUBSTR(TO_CHAR(fechaPrueba, 'YYYY-MM-DD'),1,4) = '2025';

-- 42. Elimina la columna "streamer" de la tabla "juegosStreamers".

ALTER TABLE juegosStreamers
DROP COLUMN streamer;

-- Comprobación

DESCRIBE juegosStreamers;

-- 43. Vacía la tabla de "juegosStreamers", conservando su estructura.

TRUNCATE TABLE juegosStreamers;

-- 44. Elimina por completo la tabla de "juegosStreamers".

DROP TABLE juegosStreamers;

-- 45. Borra los canales del streamer "Caddac Tech".

DELETE FROM hablaSobre
WHERE codigoStreamer =
(
    SELECT codigo FROM streamers WHERE nombre = 'Caddac Tech'
);

-- 46. Muestra la diferencia entre el canal con más seguidores 
-- y la media, mostrada en millones de seguidores. 
-- Usa el alias "diferenciaMillones".

SELECT (MAX(milesSeguidores) - AVG(milesSeguidores)) / 1000 AS diferenciaMillones
FROM hablaSobre;

-- 47. Medios en los que tienen canales los creadores de código "ill",
-- "ng" y "ltt", sin duplicados, usando IN (pero no en una subconsulta).

SELECT DISTINCT medio FROM hablaSobre
WHERE codigoStreamer IN ('ill', 'ng', 'ltt');

-- 48. Medios en los que tienen canales los creadores "ill", "ng" y 
-- "ltt", sin duplicados, sin usar IN.

SELECT DISTINCT medio FROM hablaSobre
WHERE codigoStreamer = 'ill'
OR codigoStreamer = 'ng'
OR codigoStreamer = 'ltt';

-- 49. Nombre de streamer y nombre del medio en el que habla, para
-- aquellos de los que no conocemos el país.

SELECT s.nombre AS streamer, medio 
FROM streamers s
    INNER JOIN hablaSobre
        ON s.codigo = hablaSobre.codigoStreamer
WHERE pais IS NULL;

-- 50. Nombre del streamer y medio de los canales que sean del 
-- mismo medio que el canal de Ibai Llanos que tiene 12800 miles
-- de seguidores (puede aparecer el propio Ibai Llanos).

-- Previo 1: código de Ibai Llanos

SELECT codigo FROM streamers
WHERE nombre = 'Ibai Llanos';

-- Previo 2: medio de ese canal

SELECT medio FROM hablaSobre
WHERE milesSeguidores = 12800 AND codigoStreamer =
(
    SELECT codigo FROM streamers
    WHERE nombre = 'Ibai Llanos'
);

-- Consulta completa

SELECT s.nombre AS streamer, medio 
FROM streamers s 
    INNER JOIN hablaSobre
        ON s.codigo = hablaSobre.codigoStreamer
WHERE medio = 
(
    SELECT medio FROM hablaSobre
    WHERE milesSeguidores = 12800 AND codigoStreamer =
    (
        SELECT codigo FROM streamers
        WHERE nombre = 'Ibai Llanos'
    )
);


-- 51. Nombre del streamer y medio de los canales que sean del 
-- mismo medio que el canal de Ibai Llanos que tiene 12800 miles 
-- de seguidores (sin incluir a Ibai Llanos).

-- A partir de la anterior

SELECT s.nombre AS streamer, medio 
FROM streamers s 
    INNER JOIN hablaSobre
        ON s.codigo = hablaSobre.codigoStreamer
WHERE medio = 
(
    SELECT medio FROM hablaSobre
    WHERE milesSeguidores = 12800 AND codigoStreamer =
    (
        SELECT codigo FROM streamers
        WHERE nombre = 'Ibai Llanos'
    )
)
AND nombre <> 'Ibai Llanos';

-- 52. Nombre de cada streamer, medio y temática, incluso si 
-- para algún streamer no aparece ningún canal o para alguna temática 
-- no aparece ningún canal.

-- Ya hecho: 13

SELECT s.nombre AS streamer, t.nombre AS tema, medio
FROM streamers s
    LEFT JOIN hablaSobre
        ON s.codigo = hablaSobre.codigoStreamer
    LEFT JOIN tematicas t
        ON hablaSobre.codigoTematica = t.codigo;


-- 53. Nombre de medio y nombre de cada temática, como parte de 
-- una única lista (quizá desordenada).

SELECT medio FROM hablaSobre
UNION
SELECT nombre FROM tematicas;


-- 54. Nombre de medio y nombre de cada temática, como parte de
-- una única lista ordenada alfabéticamente.

-- En la mayoria de gestores basta con esto 
-- (mayor prioridad de UNION que de ORDER BY):

SELECT medio AS nombre FROM hablaSobre
UNION
SELECT nombre FROM tematicas
ORDER BY nombre;

-- Alternativa que funcionaría en cualquier circunstancia

SELECT * FROM
(
    SELECT medio AS nombre FROM hablaSobre
    UNION
    SELECT nombre FROM tematicas
)
ORDER BY nombre;


-- 55. Nombre de medio y cantidad media de seguidores en ese medio, 
-- para los que están por encima de la media de seguidores de los canales.

-- Previo: media y seguidores en promedio

SELECT medio, AVG(milesSeguidores * 1000) AS mediaSeguidores
FROM hablaSobre
GROUP BY medio;

-- Consulta completa

SELECT medio, AVG(milesSeguidores * 1000) AS mediaSeguidores
FROM hablaSobre
GROUP BY medio
HAVING mediaSeguidores > 
(
    SELECT AVG(milesSeguidores * 1000) 
    FROM hablaSobre
);


-- 56. Nombre de los streamers que emiten en YouTube y que o bien 
-- hablan en español o bien sus miles de seguidores están por encima 
-- de 12.000.

SELECT s.nombre
FROM streamers s
    LEFT JOIN hablaSobre
        ON s.codigo = hablaSobre.codigoStreamer
    WHERE medio = 'YouTube'
    AND (idioma = 'Español' OR milesSeguidores > 12000);


-- 57. Añade información ficticia sobre ti: datos como streamer, 
-- temática sobre la que hablas y medio en el que hablas 
-- sobre ella, sin indicar cantidad de seguidores. Crea una consulta
-- que muestre todos esos datos a partir de tu código.

INSERT INTO streamers VALUES ('sy','Super yo', 'España');
INSERT INTO hablaSobre VALUES ('sy','bri','Español','TikiTaka',NULL);

SELECT *
FROM streamers s
    LEFT JOIN hablaSobre
        ON s.codigo = hablaSobre.codigoStreamer
WHERE codigo = 'sy';


-- 58. Muestra el nombre de cada streamer, medio en el que emite y 
-- cantidad de seguidores, en millones, redondeados a 1 decimal.

SELECT s.nombre, 
    medio, ROUND(milesSeguidores / 1000, 1) AS millonesSeguidores
FROM streamers s
    LEFT JOIN hablaSobre
        ON s.codigo = hablaSobre.codigoStreamer;


-- 59. Muestra el nombre de cada streamer y el país de origen. 
-- Si no se sabe este dato, deberá aparecer "(País desconocido)".

-- Oracle

SELECT nombre, NVL(pais, '(País desconocido)') 
FROM streamers;

-- SQLite

SELECT nombre, IFNULL(pais, '(País desconocido)') 
FROM streamers;

-- 60. Muestra, para cada streamer, su nombre, el medio en el que 
-- emite (precedido por "Emite en: ") y el idioma de su canal 
-- (precedido por "Idioma: ")

SELECT s.nombre, 
    CONCAT('Emite en: ', medio), 
    CONCAT('Idioma: ', idioma)
FROM streamers s
    LEFT JOIN hablaSobre
        ON s.codigo = hablaSobre.codigoStreamer;
