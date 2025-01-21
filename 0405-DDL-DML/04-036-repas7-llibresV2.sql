-- Segona versió de la base de dades de llibres

-- A partir d'estes taules:

CREATE TABLE autors
(
    codi VARCHAR(5) PRIMARY KEY,
    nom VARCHAR(30)
);

CREATE TABLE llibres
(
    codi NUMERIC(10) PRIMARY KEY,
    titol VARCHAR(40),
    codiAutor VARCHAR(5),
    numeroPagines NUMERIC(4),
    ubicacio VARCHAR(30)
);

INSERT INTO autors VALUES ('fk','Franz Kafka');
INSERT INTO autors VALUES ('eap','Edgar Allan Poe');
INSERT INTO autors VALUES ('jr','John Romero');
INSERT INTO autors VALUES ('mc','Michael Crichton');
INSERT INTO autors VALUES ('shak','William Shakespeare');
INSERT INTO autors VALUES ('cerv','Miguel de Cervantes');
INSERT INTO autors VALUES ('sk','Stephen King');

INSERT INTO llibres VALUES (1,'El proceso','fk',296,'e1b2');
INSERT INTO llibres VALUES (2,'Parque Jurásico','mc',480,'e1b2');
INSERT INTO llibres VALUES (3,'Doom Guy: Life in First Person','jr',370,NULL);
INSERT INTO llibres VALUES (4,'Ensayos y Poesía Completa','eap',480,'e1b3');
INSERT INTO llibres VALUES (5,'La metamorfosis','fk',128,'e1b3');
INSERT INTO llibres VALUES (6,'América','fk',320,'e1b4');
INSERT INTO llibres VALUES (7,'Maleficio','sk',332,'s1b2');
INSERT INTO llibres VALUES (8,'Ojos de fuego','sk',429,'s1b2');
INSERT INTO llibres VALUES (9,'El umbral de la noche','sk',NULL,'s1b2');
INSERT INTO llibres VALUES (10,'La zona muerta','sk',NULL,'s1b2');
INSERT INTO llibres VALUES (11,'Sol naciente','mc',419,'e1b2');
INSERT INTO llibres VALUES (12,'La tabla de Flandes',NULL,NULL,'s1b2');


-- 1.- Mostra els títols de tots els llibres (sense duplicats), ordenats alfabèticament.
-- 
-- 2.- Mostra els títols dels llibres que continguen la paraula "doom" (potser amb majúscules distintes).
-- 
-- 3.- Mostra els títols dels llibres l'autor dels quals no coneguem.
-- 
-- 4.- Mostra els títols dels llibres la quantitat de pàgines dels quals siga inferior a 100 o bé estiga entre 200 i 300, de 2 formes distintes.
-- 
-- 5.- Mostra els noms d'autors que tinguen una lletra "i" en la seua segona posició.
-- 
-- 6.- Mostra els noms dels autors i els títols dels llibres, com a part d'una única columna.
-- 
-- 7.- Mostra els noms d'autors que coincidisquen amb títols de llibres (potser amb majúscules distintes) usant operacions de conjunts.
-- 
-- 8.- Mostra els noms d'autors que coincidisquen amb títols de llibres (potser amb majúscules distintes) usant JOIN.
-- 
-- 9.- Mostra els noms d'autors que coincidisquen amb títols de llibres (potser amb majúscules distintes) usant WHERE.
-- 
-- 10.- Mostra els noms d'autors que coincidisquen amb títols de llibres (potser amb majúscules distintes) usant una subconsulta i IN.
-- 
-- 11.- Mostra el títol de cada llibre al costat del nombre de pàgines impreses (suposarem que seran les que formen el llibre en si, més altres 6 pàgines per a portada, contraportada i dades sobre l'edició). Usa un àlies anomenat "paginesTotals".
-- 
-- 12 i 13.- Mostra el títol de cada llibre juntament amb el nom del seu autor, per als llibres dels quals coneixem l'autor, ordenat per autor i (en cas de coincidir) per títol, de 2 formes distintes.
-- 
-- 14.- Mostra el títol de cada llibre juntament amb el nom del seu autor, fins i tot per als llibres dels quals no coneixem l'autor, ordenats per títol.
-- 
-- 15 i 16.- Mostra els títols dels llibres de Stephen King la quantitat de pàgines dels quals estiga entre 300 i 500, les dos inclusivament, de 2 formes distintes.
-- 
-- 17.- Mostra el nom de cada autor i la quantitat de llibres (potser 0) que tenim seus.
-- 
-- 18.- Mostra el nom de cada autor i la quantitat de llibres que tenim seus, només per als autors dels quals tinguem 2 o més llibres.
-- 
-- 19.- Mostra la quantitat de pàgines que té el llibre de més pàgines de la nostra biblioteca.
-- 
-- 20.- Mostra el títol i la quantitat de pàgines del llibre amb més pàgines de la nostra biblioteca, usant FETCH i ORDER BY.
-- 
-- 21.- Mostra el títol i la quantitat de pàgines del llibre amb més pàgines de la nostra biblioteca, usant MAX i una subconsulta.
-- 
-- 22.- Mostra el títol i la quantitat de pàgines del llibre amb més pàgines de la nostra biblioteca, usant ALL i una subconsulta.
-- 
-- 23.- Mostra l'autor (precedit per "Autor: ", com a part de la mateixa columna) i el títol (precedit per "Títol: ", com a part de la mateixa columna) dels llibres que tinguen més de 400 pàgines.
-- 
-- 24.- Mostra títol i nombre de pàgines, per als llibres que tenen més pàgines que la mitjana, ordenant els resultats del llibre amb més pàgines al llibre amb menys pàgines i, en cas de coincidir les pàgines, per títol.
-- 
-- 25.- Mostra autor, títol i nombre de pàgines, per als llibres que tenen més pàgines que la mitjana de llibres de Stephen King, però que no estan escrits per Stephen King.
-- 
-- -- ----------------------------------------------------------------------
-- 
-- 1.- Muestra los títulos de todos los libros (sin duplicados), ordenados alfabéticamente.
-- 
-- 2.- Muestra los títulos de los libros que contengan la palabra "doom" (quizá con mayúsculas distintas).
-- 
-- 3.- Muestra los títulos de los libros cuyo autor no conozcamos.
-- 
-- 4.- Muestra los títulos de los libros cuya cantidad de páginas sea inferior a 100 o bien esté entre 200 y 300, de 2 formas distintas.
-- 
-- 5.- Muestra los nombres de autores que tengan una letra "i" en su segunda posición.
-- 
-- 6.- Muestra los nombres de los autores y los títulos de los libros, como parte de una única lista.
-- 
-- 7.- Muestra los nombres de autores que coincidan con títulos de libros (quizá con mayúsculas distintas) usando operaciones de conjuntos.
-- 
-- 8.- Muestra los nombres de autores que coincidan con títulos de libros (quizá con mayúsculas distintas) usando JOIN.
-- 
-- 9.- Muestra los nombres de autores que coincidan con títulos de libros (quizá con mayúsculas distintas) usando WHERE.
-- 
-- 10.- Muestra los nombres de autores que coincidan con títulos de libros (quizá con mayúsculas distintas) usando una subconsulta e IN.
-- 
-- 11.- Muestra el título de cada libro junto al número de páginas impresas (supondremos que serán las que forman el libro en sí, más otras 6 páginas para portada, contraportada y datos sobre la edición). Usa un alias llamado "paginasTotales".
-- 
-- 12 y 13.- Muestra el título de cada libro junto con el nombre de su autor, para los libros de los que conocemos el autor, ordenado por autor y (en caso de coincidir) por título, de 2 formas distintas.
-- 
-- 14.- Muestra el título de cada libro junto con el nombre de su autor, incluso para los libros de los que no conocemos el autor, ordenados por título.
-- 
-- 15 y 16.- Muestra los títulos de los libros de Stephen King cuya cantidad de páginas esté entre 300 y 500, ambas inclusive, de 2 formas distintas.
-- 
-- 17.- Muestra el nombre de cada autor y la cantidad de libros (quizás 0) que tenemos suyos.
-- 
-- 18.- Muestra el nombre de cada autor y la cantidad de libros que tenemos suyos, sólo para los autores de los que tengamos 2 o más libros.
-- 
-- 19.- Muestra la cantidad de páginas que tiene el libro de más páginas de nuestra biblioteca.
-- 
-- 20.- Muestra el título y la cantidad de páginas del libro con más páginas de nuestra biblioteca, usando FETCH y ORDER BY.
-- 
-- 21.- Muestra el título y la cantidad de páginas del libro con más páginas de nuestra biblioteca, usando MAX y una subconsulta.
-- 
-- 22.- Muestra el nombre y la cantidad de páginas del libro con más páginas de nuestra biblioteca, usando ALL y una subconsulta.
-- 
-- 23.- Muestra el autor (precedido por "Autor: ", como parte de la misma columna) y el título (precedido por "Título: ", como parte de la misma columna) de los libros que tengan más de 400 páginas.
-- 
-- 24.- Muestra título y número de páginas, para los libros que tienen más páginas que la media, ordenando los resultados del libro con más páginas al libro con menos páginas y, en caso de coincidir las páginas, por título.
-- 
-- 25.- Muestra autor, título y número de páginas, para los libros que tienen más páginas que la media de libros de Stephen King, pero que no están escritos por Stephen King.
-- 
