-- 01. Crea una tabla para gastos: id numérico autoincremental, descripción, importe, fecha, categoría:

CREATE TABLE categorias
(
    idCategoria CHAR(6),
    nombreCategoria VARCHAR2(50),
    CONSTRAINT pk_categorias PRIMARY KEY(idCategoria)
);

CREATE TABLE gastos
(
    id NUMBER(6),
    descripcion VARCHAR2(100),
    importe NUMBER(8,2),
    fecha DATE,
    idCategoria CHAR(6),
    CONSTRAINT pk_gastos PRIMARY KEY(id),
    CONSTRAINT fk_gastos_categorias 
        FOREIGN KEY(idCategoria) 
        REFERENCES categorias(idCategoria)  
        ON UPDATE CASCADE  
);

-- 02. Introduce 2 categorías y 2 gastos

INSERT INTO categorias (idCategoria, nombreCategoria)
VALUES ('casa', 'Casa');

INSERT INTO categorias 
VALUES ('ocio', 'Ocio');

INSERT INTO gastos VALUES(1,'Luz',98.75,
    TO_DATE('2025-02-25', 'YYYY-MM-DD'), 'casa');
INSERT INTO gastos VALUES(2,'Matrícula Física de partículas',3200,
    TO_DATE('2025-02-26', 'YYYY-MM-DD'), NULL);

-- 03. Descripción de los gastos y nombre de su categoría (para los que pertenecen a alguna categoría), usando INNER JOIN

SELECT descripcion, nombreCategoria
FROM gastos INNER JOIN categorias
ON gastos.idCategoria = categorias.idCategoria;

-- 04. Descripción de los gastos y nombre de su categoría (para los que pertenecen a alguna categoría), usando NATURAL JOIN

SELECT descripcion, nombreCategoria
FROM gastos NATURAL JOIN categorias;

-- 05. Descripción de todos los gastos y nombre de su categoría (si existe)

SELECT descripcion, nombreCategoria
FROM gastos LEFT JOIN categorias
ON gastos.idCategoria = categorias.idCategoria;

-- 06. Descripción de cada gasto, importe y fecha una semana después

SELECT descripcion, importe, fecha+7
FROM gastos;

-- 07. Descripción de cada gasto, importe, tiempo transcurrido y nombre de la categoría (o [Desconocida] si no la sabemos).

SELECT descripcion, importe, 
    ROUND(SYSDATE-fecha) AS antiguedad, 
    NVL(nombreCategoria, '[Desconocida]') AS categoria
FROM gastos LEFT JOIN categorias
ON gastos.idCategoria = categorias.idCategoria;

-- 08. Los importes deben estar entre -100.000 y 100.000

ALTER TABLE gastos
    ADD CONSTRAINT chk_gastos_importe 
        CHECK(importe BETWEEN -100000 AND 100000);

INSERT INTO gastos VALUES(3,'Ferrari',375000, NULL, NULL);

-- 09. Saber qué restricciones tengo

SELECT * FROM user_constraints;

SELECT * FROM user_constraints
WHERE table_name = 'CATEGORIAS';

-- 10. Quitar esa restricción

ALTER TABLE gastos
    DROP CONSTRAINT chk_gastos_importe;
