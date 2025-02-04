-- Empleats i departaments

-- Basat en https://josejuansanchez.org/bd/ejercicios-consultas-sql/index.html#gesti%C3%B3n-de-empleados

CREATE TABLE departamento (
  id NUMBER(3),
  nombre VARCHAR2(100) NOT NULL,
  presupuesto NUMBER(8),
  gastos NUMBER(8),
  CONSTRAINT pk_departamento PRIMARY KEY(id)
);

CREATE TABLE empleado (
  id NUMBER(5),
  nif VARCHAR2(9) NOT NULL,
  nombre VARCHAR2(100) NOT NULL,
  apellido1 VARCHAR2(100) NOT NULL,
  apellido2 VARCHAR2(100),
  id_departamento NUMBER(3),
  CONSTRAINT pk_empleado PRIMARY KEY(id),
  CONSTRAINT uk_empleado_nif UNIQUE(nif),
  CONSTRAINT fk_empleado_departamento 
    FOREIGN KEY (id_departamento) REFERENCES departamento(id)
);

INSERT INTO departamento VALUES(1, 'Desarrollo', 120000, 6000);
INSERT INTO departamento VALUES(2, 'Sistemas', 150000, 21000);
INSERT INTO departamento VALUES(3, 'Recursos Humanos', 280000, 25000);
INSERT INTO departamento VALUES(4, 'Contabilidad', 110000, 3000);
INSERT INTO departamento VALUES(5, 'I+D', 375000, 380000);
INSERT INTO departamento VALUES(6, 'Proyectos', 0, 0);
INSERT INTO departamento VALUES(7, 'Publicidad', 0, 1000);

INSERT INTO empleado VALUES(1, '32481596F', 'Aarón', 'Rivero', 'Gómez', 1);
INSERT INTO empleado VALUES(2, 'Y5575632D', 'Adela', 'Salas', 'Díaz', 2);
INSERT INTO empleado VALUES(3, 'R6970642B', 'Adolfo', 'Rubio', 'Flores', 3);
INSERT INTO empleado VALUES(4, '77705545E', 'Adrián', 'Suárez', NULL, 4);
INSERT INTO empleado VALUES(5, '17087203C', 'Marcos', 'Loyola', 'Méndez', 5);
INSERT INTO empleado VALUES(6, '38382980M', 'María', 'Santana', 'Moreno', 1);
INSERT INTO empleado VALUES(7, '80576669X', 'Pilar', 'Ruiz', NULL, 2);
INSERT INTO empleado VALUES(8, '71651431Z', 'Pepe', 'Ruiz', 'Santana', 3);
INSERT INTO empleado VALUES(9, '56399183D', 'Juan', 'Gómez', 'López', 2);
INSERT INTO empleado VALUES(10, '46384486H', 'Diego','Flores', 'Salas', 5);
INSERT INTO empleado VALUES(11, '67389283A', 'Marta','Herrera', 'Gil', 1);
INSERT INTO empleado VALUES(12, '41234836R', 'Irene','Salas', 'Flores', NULL);
INSERT INTO empleado VALUES(13, '82635162B', 'Juan Antonio','Sáez', 'Guerrero', NULL);


-- 11. Devuelve el nombre del departamento donde trabaja el empleado Pepe Ruiz Santana.

SELECT d.nombre
FROM departamento d
    JOIN empleado e 
    ON d.id = e.id_departamento
WHERE e.nombre = 'Pepe' 
    AND e.apellido1 = 'Ruiz' 
    AND e.apellido2 = 'Santana';


-- 12. Devuelve un listado con los datos de los empleados que trabajan en el 
-- departamento de I+D. Ordena el resultado alfabéticamente por apellido1, 
-- apellido2 y nombre, en ese orden.

SELECT e.*
FROM empleado e
    JOIN departamento d 
    ON e.id_departamento = d.id
WHERE d.nombre = 'I+D'
ORDER BY e.apellido1, e.apellido2, e.nombre;


-- 13. Devuelve una lista con el nombre de los empleados que tienen los 
-- departamentos que no tienen un presupuesto entre 100000 y 200000 euros.

SELECT e.nombre, e.apellido1, e.apellido2
FROM empleado e
    JOIN departamento d 
    ON e.id_departamento = d.id
WHERE d.presupuesto NOT BETWEEN 100000 AND 200000;


-- 14. Devuelve un listado con todos los empleados junto con los datos de los 
-- departamentos donde trabajan. Este listado también debe incluir los empleados 
-- que no tienen ningún departamento asociado.

SELECT e.*, d.*
FROM empleado e
    LEFT JOIN departamento d 
    ON e.id_departamento = d.id;


-- 15. Devuelve un listado con todos los empleados junto con los datos de los 
-- departamentos donde trabajan. El listado debe incluir los empleados que no 
-- tienen ningún departamento asociado y los departamentos que no tienen ningún 
-- empleado asociado. Ordene el listado alfabéticamente por el nombre del 
-- departamento.

SELECT e.*, d.*
FROM empleado e
    FULL OUTER JOIN departamento d 
    ON e.id_departamento = d.id
ORDER BY d.nombre;


-- 16. Calcula la suma, la media y el valor mínimo del presupuesto de todos los 
-- departamentos.

SELECT SUM(presupuesto), AVG(presupuesto), MIN(presupuesto)
FROM departamento;


-- 17. Calcula el nombre del departamento y el presupuesto que tiene asignado, 
-- del departamento con menor presupuesto.

-- SQLite, MySQL, PostgreSQL

SELECT nombre, presupuesto
FROM departamento
ORDER BY presupuesto ASC
LIMIT 1;

-- Oracle, MS SQL Server

SELECT nombre, presupuesto
FROM departamento
ORDER BY presupuesto ASC
FETCH NEXT 1 ROWS ONLY;


-- 18. Calcula el número total de empleados que hay en la tabla empleado.

SELECT COUNT(*)
FROM empleado;


-- 19. Calcula el número de empleados que hay en cada departamento. Tienes que 
-- devolver dos columnas, una con el nombre del departamento y otra con el número 
-- de empleados que tiene asignados.

SELECT d.nombre, COUNT(e.id)
FROM departamento d
    JOIN empleado e 
    ON d.id = e.id_departamento
GROUP BY d.nombre;


-- 20. Calcula el nombre de los departamentos que tienen más de 2 empleados. El 
-- resultado debe tener dos columnas, una con el nombre del departamento y otra 
-- con el número de empleados que tiene asignados.

SELECT d.nombre, COUNT(e.id)
FROM departamento d
    LEFT JOIN empleado e 
    ON d.id = e.id_departamento
GROUP BY d.nombre
    HAVING COUNT(e.id) > 2;


-- 21. Calcula el número de empleados que trabajan en cada uno de los 
-- departamentos. El resultado de esta consulta también tiene que incluir aquellos 
-- departamentos que no tienen ningún empleado asociado.

SELECT d.nombre, COUNT(e.id)
FROM departamento d
    LEFT JOIN empleado e 
    ON d.id = e.id_departamento
GROUP BY d.nombre;


-- 22. Devuelve el nombre del departamento con mayor presupuesto y la cantidad 
-- que tiene asignada.

SELECT nombre, presupuesto
FROM departamento
ORDER BY presupuesto DESC
FETCH NEXT 1 ROWS ONLY;


-- 23. Devuelve los nombres de los departamentos que no tienen empleados 
-- asociados. (Utilizando ALL o ANY).

SELECT nombre FROM departamento
WHERE id <> ALL
(
   SELECT id_departamento FROM empleado
);

-- Si los nulos dan problemas

SELECT nombre FROM departamento
WHERE id <> ALL
(
   SELECT id_departamento FROM empleado
   WHERE id_departamento IS NOT NULL
);


-- 24. Devuelve los nombres de los departamentos que no tienen empleados 
-- asociados. (Utilizando IN o NOT IN).

SELECT nombre FROM departamento
WHERE id NOT IN
(
   SELECT id_departamento FROM empleado
);

-- Si los nulos dan problemas

SELECT nombre FROM departamento
WHERE id NOT IN
(
   SELECT id_departamento FROM empleado
   WHERE id_departamento IS NOT NULL
);


-- 25. Devuelve los nombres de los departamentos que no tienen empleados 
-- asociados. (Utilizando EXISTS o NOT EXISTS).

SELECT nombre FROM departamento
WHERE NOT EXISTS
(
   SELECT 1 FROM empleado
   WHERE id_departamento = departamento.id
);

-- Alternativo, con alias

SELECT nombre FROM departamento d
WHERE NOT EXISTS
(
   SELECT 1 FROM empleado
   WHERE id_departamento = d.id
);


-- 26. Muestra el nombre los departamentos, para los que tienen más empleados 
-- que la media.

-- Previo 1: departamentos que tienen más presupuesto que la media
-- Esta es la forma que NO funciona

SELECT nombre FROM departamento
WHERE presupuesto > AVG(presupuesto);

-- Previo 2: departamentos que tienen más presupuesto que la media
-- Esta es la forma que SÍ funciona

SELECT nombre FROM departamento
WHERE presupuesto > 
(
	SELECT AVG(presupuesto) FROM departamento
);

-- Previo 3: departamentos y números de empleados, mirando en "empleado"

SELECT id_departamento, COUNT(*)
FROM empleado 
GROUP BY id_departamento;

-- Previo 4, más fiable: departamentos y números de empleados, mirando en "departamento"

SELECT d.nombre, COUNT(e.id)
FROM departamento d
    LEFT JOIN empleado e 
    ON d.id = e.id_departamento
GROUP BY d.nombre;

-- Previo 5: media de esa cantidad de empleados

SELECT AVG(cantidad) FROM
(
    SELECT COUNT(e.id) AS cantidad
    FROM departamento d
        LEFT JOIN empleado e 
        ON d.id = e.id_departamento
    GROUP BY d.nombre
);

-- Consulta final: recorremos departamentos, 
-- contamos empleados y deben estar por encima de esa media

SELECT d.nombre
FROM departamento d
    JOIN empleado e 
    ON d.id = e.id_departamento
GROUP BY d.nombre
    HAVING COUNT(e.id) > 
(
    SELECT AVG(cantidad) FROM
    (
        SELECT COUNT(e.id) AS cantidad
        FROM departamento d
            LEFT JOIN empleado e 
            ON d.id = e.id_departamento
        GROUP BY d.nombre
    )
);
