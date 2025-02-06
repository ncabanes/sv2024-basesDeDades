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


-- 1. Devuelve el puesto, nombre, apellido y ciudad en la que trabaja el empleado 1, empleando INNER JOIN.

-- 2. Devuelve el puesto, nombre, apellido y ciudad en la que trabaja el empleado 1, empleando WHERE.

-- 3. Nombre de cada puesto y cantidad de empleados que ocupan ese puesto, ordenado alfabéticamente.

-- 4. Nombre de cada ciudad y cantidad de empleados que trabajan en ella (quizá 0), ordenado de mayor a menor cantidad de empleados, y en caso de coincidir esta, por nombre de ciudad (de al A a la Z)..

-- 5. Nombre y apellido de los empleados cuyo código está entre el 10 y el 20, y cuyo puesto además contiene el fragmento "repre" (quizá con mayúsculas distintas).

-- 6. Nombre y apellido de los empleados, cuyo apellido coincida con el nombre de una ciudad, usando IN o NOT IN.

-- 7. Nombre y apellido de los empleados, cuyo apellido coincida con el nombre de una ciudad, usando ANY o ALL.

-- 8. Nombre y apellido de los empleados, cuyo apellido coincida con el nombre de una ciudad, usando EXISTS o NOT EXISTS.

-- 9. Nombre y apellido de los empleados, cuyo apellido coincida con el nombre de una ciudad, usando INNER JOIN.

-- 10, 11, 12. Nombre de las ciudades en las que aún no nos aparezcan ningún empleado, de 3 formas distintas.

-- 13. Nombre y apellido de cada empleado, junto con el nombre de la ciudad, usando NATURAL JOIN.

-- 14. Nombre (y apellido) de cada empleado junto con el nombre (y apellido) de su jefe, si existe.

-- 15. Nombre (y apellido) de cada empleado junto con el nombre (y apellido) de su jefe, si existe, y el nombre (y apellido) del jefe de su jefe, si existe.

-- 16. Nombre de los países en los que trabajen al menos 5 personas.

-- 17. Cantidad media de empleados que trabajan en cada ciudad (aproximación, dividiendo la cantidad de empleados entre la cantidad de oficinas en que trabajan).

-- 18. Ciudad y país de las dos oficinas con más empleados.

-- 19. Nombre de la ciudad en la que está la oficina que tiene la valoración más alta, con una subconsulta y MAX.

-- 20. Nombre de la ciudad en la que está la oficina que tiene la valoración más alta, con una subconsulta y EXISTS o NOT EXISTS.

-- 21. Nombre de la ciudad en la que está la oficina que tiene la valoración más alta, con una subconsulta y ALL o ANY

-- 22. Nombre de la ciudad en la que está la oficina que tiene la valoración más alta, con LIMIT.

-- 23. Código y ciudad de las oficinas que están en el mismo país que la oficina que tiene la valoración más alta.

-- 23. Código y ciudad de las oficinas que tengan la misma valoración que alguna otra.

-- 24. Código y ciudad de las oficinas cuya valoración esté por encima de la media de su país.

-- 25. Crea una vista "v_empleados" que, para cada empleado, muestre su nombre, la ciudad de la oficina y el país de la oficina.

-- 26. Cantidad de empleados que trabajan en cada ciudad, empleando la vista "v_empleados".

-- 27. Ciudad y país de las dos oficinas con más empleados, empleando la vista "v_empleados".

-- 28. Crea una tabla de "productos". Para cada producto querremos un código (5 letras), una descripción (hasta 50 letras), un importe (5 cifras a la izquierda de la coma decimal y 2 a su derecha) y una fecha de alta. El código actuará como clave primaria. Usa sintaxis de Oracle.

-- 29. Añade a la tabla de productos la restricción de que la descripción debe ser única.

-- 30. Añade 3 datos de ejemplo en la tabla de productos. Para uno indicarás todos los campos, para otro no indicarás la fecha ayudándote de NULL y para el tercero no indicarás la fecha porque no detallarás todos los nombres de los campos.

-- 31. Borra el tercer dato de ejemplo que has añadido en la tabla de productos, a partir de su código.

-- 32. Modifica el segundo dato de ejemplo que has añadido en la tabla de productos, a partir de su código, para que su fecha de alta sea la de hoy.

-- 33. Crea una tabla "backup_productos", volcando en ella el código la descripción y el importe de los datos que hay en la tabla de productos.

-- 34. Vacía la tabla de productos, conservando su estructura.

-- 35. Elimina la tabla de productos.

