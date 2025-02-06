-- Inspirado en:
-- https://josejuansanchez.org/bd/ejercicios-consultas-sql/index.html#jardiner%C3%ADa

CREATE TABLE oficina (
  codigo_oficina VARCHAR(10) NOT NULL,
  ciudad VARCHAR(30) NOT NULL,
  pais VARCHAR(20) NOT NULL,
  valoracion NUMERIC(3,1),
  PRIMARY KEY (codigo_oficina)
);

CREATE TABLE empleado (
  codigo_empleado NUMERIC(6) NOT NULL,
  nombre VARCHAR(30) NOT NULL,
  apellido1 VARCHAR(30) NOT NULL,
  codigo_oficina VARCHAR(10) NOT NULL,
  codigo_jefe NUMERIC(6) DEFAULT NULL,
  puesto VARCHAR(20) DEFAULT NULL,
  PRIMARY KEY (codigo_empleado),
  FOREIGN KEY (codigo_oficina) REFERENCES oficina (codigo_oficina),
  FOREIGN KEY (codigo_jefe) REFERENCES empleado (codigo_empleado)
);

-- Datos
INSERT INTO oficina VALUES ('BCN-ES','Barcelona','España', 7.4);
INSERT INTO oficina VALUES ('BOS-USA','Boston','EEUU', 7.7);
INSERT INTO oficina VALUES ('LON-UK','Londres','Inglaterra', 8.2);
INSERT INTO oficina VALUES ('MAD-ES','Madrid','España', 9.8);
INSERT INTO oficina VALUES ('PAR-FR','Paris','Francia', 6.4);
INSERT INTO oficina VALUES ('SFC-USA','San Francisco','EEUU', 8.9);
INSERT INTO oficina VALUES ('SYD-AU','Sydney','Australia', 8.7);
INSERT INTO oficina VALUES ('TAL-ES','Talavera de la Reina','España', 8.4);
INSERT INTO oficina VALUES ('TOK-JP','Tokyo','Japón', 7.7);

INSERT INTO empleado VALUES (1,'Marcos','Magaña','TAL-ES',NULL,'Director Gen.');
INSERT INTO empleado VALUES (2,'Ruben','López','TAL-ES',1,'Subdirector Mark.');
INSERT INTO empleado VALUES (3,'Alberto','Soria','TAL-ES',2,'Subdirector Ven.');
INSERT INTO empleado VALUES (4,'Maria','Solís','TAL-ES',2,'Secretaria');
INSERT INTO empleado VALUES (5,'Felipe','Rosas','TAL-ES',3,'Representante');
INSERT INTO empleado VALUES (6,'Juan Carlos','Martínez','TAL-ES',3,'Representante');
INSERT INTO empleado VALUES (7,'Carlos','Soria','MAD-ES',3,'Director');
INSERT INTO empleado VALUES (8,'Mariano','López','MAD-ES',7,'Representante');
INSERT INTO empleado VALUES (9,'Lucio','Campoamor','MAD-ES',7,'Representante');
INSERT INTO empleado VALUES (10,'Hilario','Rodriguez','MAD-ES',7,'Representante');
INSERT INTO empleado VALUES (11,'Emmanuel','Magaña','BCN-ES',3,'Director');
INSERT INTO empleado VALUES (12,'José Manuel','Martinez','BCN-ES',11,'Representante');
INSERT INTO empleado VALUES (13,'David','Palma','BCN-ES',11,'Representante');
INSERT INTO empleado VALUES (14,'Oscar','Palma','BCN-ES',11,'Representante');
INSERT INTO empleado VALUES (15,'Francois','Fignon','PAR-FR',3,'Director');
INSERT INTO empleado VALUES (16,'Lionel','Narvaez','PAR-FR',15,'Representante');
INSERT INTO empleado VALUES (17,'Laurent','Serra','PAR-FR',15,'Representante');
INSERT INTO empleado VALUES (18,'Michael','Sydney','SFC-USA',3,'Director');
INSERT INTO empleado VALUES (19,'Walter Santiago','Castillo','SFC-USA',18,'Representante');
INSERT INTO empleado VALUES (20,'Hilary','Washington','BOS-USA',3,'Director');
INSERT INTO empleado VALUES (21,'Marcus','Paxton','BOS-USA',20,'Representante');


-- 1. Devuelve el puesto, nombre, apellido y ciudad en la que trabaja 
-- el empleado 1, empleando INNER JOIN.

SELECT puesto, nombre, apellido1, ciudad
FROM empleado INNER JOIN oficina
ON empleado.codigo_oficina = oficina.codigo_oficina
WHERE codigo_empleado = 1;


-- 2. Devuelve el puesto, nombre, apellido y ciudad en la que trabaja
-- el empleado 1, empleando WHERE.

SELECT puesto, nombre, apellido1, ciudad
FROM empleado, oficina
WHERE empleado.codigo_oficina = oficina.codigo_oficina
AND codigo_empleado = 1;


-- 3. Nombre de cada puesto y cantidad de empleados que ocupan 
-- ese puesto, ordenado alfabéticamente.

SELECT puesto, COUNT(*)
FROM empleado
GROUP BY puesto
ORDER BY puesto;


-- 4. Nombre de cada ciudad y cantidad de empleados que trabajan 
-- en ella (quizá 0), ordenado de mayor a menor cantidad de empleados, 
-- y en caso de coincidir esta, por nombre de ciudad (de al A a la Z)..


SELECT ciudad, COUNT(codigo_empleado)
FROM oficina LEFT JOIN empleado
ON oficina.codigo_oficina = empleado.codigo_oficina
GROUP BY ciudad
ORDER BY COUNT(codigo_empleado) DESC, ciudad ASC;


-- 5. Nombre y apellido de los empleados cuyo código está entre el
-- 10 y el 20, y cuyo puesto además contiene el fragmento "repre" 
-- (quizá con mayúsculas distintas).

SELECT nombre, apellido1
FROM empleado
WHERE codigo_empleado BETWEEN 10 AND 20
AND LOWER(puesto) LIKE '%repre%';


-- 6. Nombre y apellido de los empleados, cuyo apellido coincida 
-- con el nombre de una ciudad, usando IN o NOT IN.

SELECT nombre, apellido1
FROM empleado
WHERE apellido1 IN
( 
    SELECT ciudad FROM oficina 
);


-- 7. Nombre y apellido de los empleados, cuyo apellido coincida con 
-- el nombre de una ciudad, usando ANY o ALL.

SELECT nombre, apellido1
FROM empleado
WHERE apellido1 = ANY
( 
    SELECT ciudad FROM oficina 
);


-- 8. Nombre y apellido de los empleados, cuyo apellido coincida 
-- con el nombre de una ciudad, usando EXISTS o NOT EXISTS.

SELECT nombre, apellido1
FROM empleado
WHERE EXISTS
( 
    SELECT 1 FROM oficina 
    WHERE ciudad = apellido1
);


-- 9. Nombre y apellido de los empleados, cuyo apellido 
-- coincida con el nombre de una ciudad, usando INNER JOIN.

SELECT nombre, apellido1
FROM empleado INNER JOIN oficina
ON ciudad = apellido1;


-- 10, 11, 12. Nombre de las ciudades en las que aún no 
-- nos aparezcan ningún empleado, de 3 formas distintas.

SELECT ciudad FROM oficina
WHERE codigo_oficina
NOT IN 
(
    SELECT codigo_oficina FROM empleado
);

SELECT ciudad FROM oficina
WHERE codigo_oficina <> ALL
(
    SELECT codigo_oficina FROM empleado
);

SELECT ciudad FROM oficina
WHERE NOT EXISTS
( 
    SELECT 1 FROM empleado 
    WHERE empleado.codigo_oficina = oficina.codigo_oficina
);

SELECT ciudad 
FROM oficina
    LEFT JOIN empleado
    ON oficina.codigo_oficina = empleado.codigo_oficina
GROUP BY ciudad
    HAVING COUNT(empleado.codigo_empleado) = 0;
    
SELECT ciudad 
FROM oficina
    LEFT JOIN empleado
    ON oficina.codigo_oficina = empleado.codigo_oficina
WHERE empleado.codigo_empleado IS NULL;


-- 13. Nombre y apellido de cada empleado, junto con el nombre 
-- de la ciudad, usando NATURAL JOIN.

-- Lo que sabíamos hacer

SELECT puesto, nombre, apellido1, ciudad
FROM empleado INNER JOIN oficina
ON empleado.codigo_oficina = oficina.codigo_oficina;

-- Alternativa, con NATURAL JOIN

SELECT puesto, nombre, apellido1, ciudad
FROM empleado NATURAL JOIN oficina;


-- 14. Nombre (y apellido) de cada empleado junto con el 
-- nombre (y apellido) de su jefe, si existe.

SELECT e.nombre, e.apellido1, jefe.nombre, jefe.apellido1
FROM empleado e LEFT JOIN empleado jefe
ON e.codigo_jefe = jefe.codigo_empleado;


-- 15. Nombre (y apellido) de cada empleado junto con el nombre (y 
-- apellido) de su jefe, si existe, y el nombre (y apellido) del jefe 
-- de su jefe, si existe.

SELECT e.nombre AS nombre_empleado, e.apellido1 AS apellido_empleado,
       jefe.nombre AS nombre_jefe, jefe.apellido1 AS apellido_jefe,
       jefeSupremo.nombre AS nombre_jefeSupremo, 
           jefeSupremo.apellido1 AS apellido_jefeSupremo
FROM empleado e
LEFT JOIN empleado jefe ON e.codigo_jefe = jefe.codigo_empleado
LEFT JOIN empleado jefeSupremo ON jefe.codigo_jefe = jefeSupremo.codigo_empleado;


-- 16. Nombre de los países en los que trabajen al menos 5 personas.

SELECT pais, COUNT(codigo_empleado)
FROM oficina LEFT JOIN empleado
ON oficina.codigo_oficina = empleado.codigo_oficina
GROUP BY pais
HAVING COUNT(codigo_empleado) > 5;

-- 17. Cantidad media de empleados que trabajan en cada ciudad
-- (aproximación, dividiendo la cantidad de empleados entre 
-- la cantidad de oficinas en que trabajan).

SELECT COUNT(*) / COUNT (DISTINCT codigo_oficina) 
FROM empleado;

-- 18. Ciudad y país de las dos oficinas con más empleados.

SELECT ciudad, pais, COUNT(codigo_empleado)
FROM oficina LEFT JOIN empleado
ON oficina.codigo_oficina = empleado.codigo_oficina
GROUP BY ciudad, pais
ORDER BY COUNT(codigo_empleado) DESC
LIMIT 2;

-- FETCH NEXT 2 ROWS ONLY (en Oracle)


-- 19. Nombre de la ciudad en la que está la oficina que tiene 
-- la valoración más alta, con una subconsulta y MAX.

-- Valoración más alta

SELECT MAX(valoracion) FROM oficina;

-- Consulta completa

SELECT ciudad FROM oficina
WHERE valoracion = (SELECT MAX(valoracion) FROM oficina);


-- 20. Nombre de la ciudad en la que está la oficina que tiene
-- la valoración más alta, con una subconsulta y EXISTS o NOT EXISTS.

SELECT ciudad FROM oficina o1
WHERE NOT EXISTS
(
    SELECT valoracion FROM oficina o2
    WHERE o2.valoracion > o1.valoracion
    AND o1.codigo_oficina <> o2.codigo_oficina
);


-- 21. Nombre de la ciudad en la que está la oficina que tiene 
-- la valoración más alta, con una subconsulta y ALL o ANY

SELECT ciudad FROM oficina
WHERE valoracion >= ALL
(
    SELECT valoracion FROM oficina
);


-- 22. Nombre de la ciudad en la que está la oficina que tiene 
-- la valoración más alta, con LIMIT.

SELECT ciudad FROM oficina
ORDER BY valoracion DESC LIMIT 1;


-- 23. Código y ciudad de las oficinas que están en el mismo
-- país que la oficina que tiene la valoración más alta.

-- A partir de las anteriores. La más breve:

SELECT codigo_oficina, ciudad FROM oficina
WHERE pais = 
(
    SELECT pais FROM oficina
    ORDER BY valoracion DESC LIMIT 1
);

-- Las demás suponen 2 subconsultas:

SELECT codigo_oficina, ciudad FROM oficina
WHERE pais = 
(
    SELECT pais FROM oficina
    WHERE valoracion >= ALL
    (
        SELECT valoracion FROM oficina
    )
);


-- 23b. Código y ciudad de las oficinas que tengan la misma 
-- valoración que alguna otra.

SELECT codigo_oficina, ciudad FROM oficina o1
WHERE EXISTS 
(
    SELECT 1 FROM oficina o2
    WHERE o1.valoracion = o2.valoracion
    AND o1.codigo_oficina <> o2.codigo_oficina
);


-- 24. Código y ciudad de las oficinas cuya valoración esté 
-- por encima de la media de su país.

SELECT codigo_oficina, ciudad FROM oficina o1
WHERE valoracion > 
(
    SELECT AVG(valoracion) FROM oficina o2
    WHERE o1.pais = o2.pais
);


-- 25. Crea una vista "v_empleados" que, para cada empleado, 
-- muestre su nombre, la ciudad de la oficina y el país de 
-- la oficina.

CREATE VIEW v_empleados AS
    SELECT nombre, apellido1, ciudad, pais
    FROM empleado LEFT JOIN oficina
        ON empleado.codigo_oficina = oficina.codigo_oficina;


-- 26. Cantidad de empleados que trabajan en cada ciudad, 
-- empleando la vista "v_empleados".

SELECT ciudad, COUNT(*)
FROM v_empleados
GROUP BY ciudad;


-- 27. Ciudad y país de las dos oficinas con más empleados, 
-- empleando la vista "v_empleados".

SELECT ciudad, pais, COUNT(*)
FROM v_empleados
GROUP BY ciudad, pais
ORDER BY COUNT(*) DESC
LIMIT 2;


-- 28. Crea una tabla de "productos". Para cada producto querremos un 
-- código (5 letras), una descripción (hasta 50 letras), un importe (5 
-- cifras a la izquierda de la coma decimal y 2 a su derecha) y una fecha 
-- de alta. El código actuará como clave primaria. Usa sintaxis de Oracle.

CREATE TABLE productos (
    codigo CHAR(5),
    descripcion VARCHAR2(50),
    importe NUMBER(7,2),
    fecha_alta DATE,
    CONSTRAINT productos_pk PRIMARY KEY(codigo)
);

-- 29. Añade a la tabla de productos la restricción de que la 
-- descripción debe ser única.

-- (Funciona en Oracle, no en SQLite)

ALTER TABLE productos
    ADD CONSTRAINT productos_uk_descripc UNIQUE(descripcion);


-- 30. Añade 3 datos de ejemplo en la tabla de productos. Para uno 
-- indicarás todos los campos, para otro no indicarás la fecha ayudándote 
-- de NULL y para el tercero no indicarás la fecha porque no detallarás 
-- todos los nombres de los campos.

-- Con sintaxis de SQLite y MySQL

INSERT INTO productos (codigo, descripcion, importe, fecha_alta)
VALUES ('P1', 'Producto 1', 25, '2025-02-05');

INSERT INTO productos (codigo, descripcion, importe, fecha_alta)
VALUES ('P2', 'Producto 2', 35.75, NULL);

INSERT INTO productos (codigo, descripcion, importe)
VALUES ('P3', 'Producto 3', 150);

-- Con sintaxis de Oracle, el cambio sería:

INSERT INTO productos (codigo, descripcion, importe, fecha_alta)
VALUES ('P1', 'Producto 1', 25, TO_DATE('2025-02-05', 'YYYY-MM-DD'));


-- 31. Borra el tercer dato de ejemplo que has añadido en la tabla de 
-- productos, a partir de su código.

DELETE FROM productos WHERE codigo = 'P3';


-- 32. Modifica el segundo dato de ejemplo que has añadido en la tabla 
-- de productos, a partir de su código, para que su fecha de alta sea la 
-- de hoy.

-- Con sintaxis de SQLite y MySQL

UPDATE productos
SET fecha_alta = '2025-02-05'
WHERE codigo = 'P2';

-- Con sintaxis de Oracle

UPDATE productos
SET fecha_alta = TO_DATE('2025-02-05', 'YYYY-MM-DD')
WHERE codigo = 'P2';


-- 33. Crea una tabla "backup_productos", volcando en ella el código, la 
-- descripción y el importe de los datos que hay en la tabla de productos.

CREATE TABLE backup_productos AS
SELECT codigo, descripcion, importe
FROM productos;


-- 34. Vacía la tabla de productos, conservando su estructura.

-- En Oracle

TRUNCATE TABLE productos;

-- En SQLite

DELETE FROM productos;


-- 35. Elimina la tabla de productos.

DROP TABLE productos;
