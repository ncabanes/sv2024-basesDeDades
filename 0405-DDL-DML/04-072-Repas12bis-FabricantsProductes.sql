-- Fabricantes y productos (ampliación)

CREATE TABLE fabricantes (
  id number PRIMARY KEY,
  nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE productos (
  id number PRIMARY KEY,
  nombre VARCHAR2(100) NOT NULL,
  precio number,
  id_fabricante number NOT NULL,
  FOREIGN KEY (id_fabricante) REFERENCES fabricantes(id)
);

INSERT INTO fabricantes VALUES(1, 'Asus');
INSERT INTO fabricantes VALUES(2, 'Lenovo');
INSERT INTO fabricantes VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricantes VALUES(4, 'Samsung');
INSERT INTO fabricantes VALUES(5, 'Seagate');
INSERT INTO fabricantes VALUES(6, 'Crucial');
INSERT INTO fabricantes VALUES(7, 'Gigabyte');
INSERT INTO fabricantes VALUES(8, 'Huawei');
INSERT INTO fabricantes VALUES(9, 'Xiaomi');

INSERT INTO productos VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO productos VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO productos VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO productos VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO productos VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 7);
INSERT INTO productos VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO productos VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO productos VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO productos VALUES(9, 'Portátil Ideapad 320', 444, 2);
INSERT INTO productos VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO productos VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);


-- 100. Crea una vista v_producto_fabricante, que incluya el nombre de cada producto, el nombre del fabricante y el precio. 

-- Previo:

SELECT p.nombre, f.nombre, precio
FROM productos p LEFT JOIN fabricantes f
ON p.id_fabricante = f.id;

CREATE VIEW v_producto_fabricante AS
    SELECT p.nombre AS producto, f.nombre AS fabricante, precio
    FROM productos p LEFT JOIN fabricantes f
    ON p.id_fabricante = f.id;

SELECT * FROM v_producto_fabricante;

-- 101. Crea una tabla productosYFabricantes con la misma información que la vista v_producto_fabricante, además del código de producto.

CREATE TABLE productosYFabricantes AS
    SELECT p.id, p.nombre AS producto, f.nombre AS fabricante, precio
    FROM productos p LEFT JOIN fabricantes f
    ON p.id_fabricante = f.id;

SELECT * FROM productosYFabricantes;

-- 102. Añade un nuevo producto en la tabla "productos", con código 12, nombre "SSD P3 Plus 2 TB", precio desconocido (pero no debes usar la palabra NULL), del fabricante 6. Comprueba si aparece en la vista y si aparece en la nueva tabla.

INSERT INTO productos (id, nombre, id_fabricante)
VALUES(12, 'SSD P3 Plus 2 TB', 6);

SELECT * FROM v_producto_fabricante;

SELECT * FROM productosYFabricantes;

-- 103. Añade a la tabla productosYFabricantes un nuevo campo llamado "comentario", de tipo TEXT.

ALTER TABLE productosYFabricantes
ADD (comentario CLOB);

-- 104. Añade a la tabla la restricción de que el código de producto actúe como clave primaria.

ALTER TABLE productosYFabricantes
ADD CONSTRAINT pk_prodFabr PRIMARY KEY(id);

DESCRIBE productosYFabricantes;

-- 105. Renombra la tabla "productosYFabricantes" para que pase a llamarse "productosFabricantes".

ALTER TABLE productosYFabricantes
RENAME TO productosFabricantes;

SELECT * FROM user_all_tables;

-- 106. Renombra el campo "comentario" de "productosFabricantes" para que pase a llamarse "comentarios".

ALTER TABLE productosFabricantes
RENAME COLUMN comentario TO comentarios;

DESCRIBE productosFabricantes;

-- 107. Vacía la tabla "productosFabricantes", conservando su estructura.

TRUNCATE TABLE productosFabricantes;

-- 108. Borra por completo la tabla "productosFabricantes".

DROP TABLE productosFabricantes;

-- 109. Muestra nombre y precio del producto más caro de la tabla "productos", usando ORDER BY. Asegúrate de que los nulos no hacen que se comporte mal.

-- Sin considerar nulos, todos los datos

SELECT nombre, precio FROM productos
ORDER BY precio DESC;

-- Sólo el primero

SELECT nombre, precio FROM productos
ORDER BY precio DESC
FETCH FIRST 1 ROW ONLY;

-- Esquivando nulos

SELECT nombre, precio FROM productos
WHERE precio IS NOT NULL
ORDER BY precio DESC
FETCH FIRST 1 ROW ONLY;

-- 110. Muestra nombre y precio del producto más caro de la tabla "productos", usando ALL / ANY. Asegúrate de que los nulos no hacen que se comporte mal.

-- Sin considerar nulos

SELECT nombre, precio FROM productos
WHERE precio >= ALL
(
    SELECT precio FROM productos
);

-- Esquivando nulos

SELECT nombre, precio FROM productos
WHERE precio >= ALL
(
    SELECT precio FROM productos
    WHERE precio IS NOT NULL
);

-- 111. Muestra nombre y precio del producto más caro de la tabla "productos", usando EXISTS / NOT EXISTS. Asegúrate de que los nulos no hacen que se comporte mal.

-- Sin considerar nulos

SELECT nombre, precio FROM productos p1
WHERE NOT EXISTS
(
    SELECT precio FROM productos p2
    WHERE p2.precio > p1.precio
);

-- Esquivando nulos

SELECT nombre, precio FROM productos p1
WHERE NOT EXISTS
(
    SELECT precio FROM productos p2
    WHERE p2.precio > p1.precio
)
AND precio IS NOT NULL;

-- 112. Haz que el nombre de cada producto pueda actuar como índice para acelerar las búsquedas.

CREATE INDEX idx_productos_nombre
ON productos ( nombre );

-- 113. Haz que se pueda usar el sinónimo "producto" para la tabla "productos".

CREATE SYNONYM
producto FOR productos;

SELECT * FROM producto;

-- 114. Muestra el nombre de cada producto y su precio, redondeado a la potencia de 10 más cercana.

SELECT nombre, ROUND(precio, -1)
FROM productos;

-- 115. Muestra el nombre de cada producto, cambiando los espacios en blanco por guiones.

SELECT REPLACE(nombre, ' ', '-')
FROM productos;

-- 116. Muestra el nombre de cada producto, alineado a la derecha, rellenando con puntos hasta una anchura de 45 caracteres.

SELECT LPAD(nombre, 45, '.')
FROM productos;

-- 117. Muestra el nombre de cada producto junto con su precio (si no sabemos precio, deberá aparecer "[Desconocido]").

SELECT nombre, 
    NVL(TO_CHAR(precio), '[Desconocido]')
FROM productos;

-- 118, 119, 120. Muestra los nombres de los productos que tengan una "o" en la segunda posición de su nombre, de 3 formas distintas.

SELECT nombre FROM productos
WHERE nombre LIKE '_o%';

SELECT nombre FROM productos
WHERE SUBSTR(nombre,2,1) = 'o';

SELECT nombre FROM productos
WHERE INSTR(nombre,'o',2) = 2;

-- 121. Modifica el producto de código 12 para indicar que su precio es 125.

UPDATE productos
SET precio = 125 WHERE id = 12;

-- 122. Borra el producto de código 12.

DELETE FROM productos
WHERE id = 12;

-- 123. Muestra la estructura de la tabla "productos".

DESCRIBE productos;

-- 124. Muestra los nombres de los productos cuyas primeras 7 letras sean las mismas que las de algún otro producto.

SELECT nombre FROM productos p1
WHERE EXISTS
(
    SELECT 1 FROM productos p2
    WHERE SUBSTR(p1.nombre, 1, 7)
        = SUBSTR(p2.nombre, 1, 7)
    AND p1.id <> p2.id
);

