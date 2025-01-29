-- Empleats i departaments (Part 1)

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


-- 1. Lista el primer apellido de los empleados eliminando los apellidos que 
-- estén repetidos.

SELECT DISTINCT apellido1
FROM empleado;


-- 2. Lista el nombre y apellidos de los empleados en una única columna.

SELECT nombre || ' ' || apellido1 || ' ' || apellido2 AS nombreCompleto
FROM empleado;

-- No en Oracle ("demasiados parámetros" para un CONCAT<<)

SELECT CONCAT(nombre, ' ', apellido1, ' ', apellido2) AS nombreCompleto
FROM empleado;


-- 3. Lista el nombre de cada departamento y el dinero del que dispone. Para 
-- calcular este dato habrá que restar al valor del presupuesto inicial (columna 
-- "presupuesto") los gastos que se han generado (columna gastos).

SELECT nombre, presupuesto - gastos AS dineroDisponible
FROM departamento; 


-- 4. Lista los apellidos y el nombre de todos los empleados, ordenados de 
-- forma alfabética tendiendo en cuenta en primer lugar sus apellidos y luego su 
-- nombre.

SELECT apellido2, apellido1, nombre
FROM empleado
ORDER BY apellido2, apellido1, nombre;


-- 5. Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos 
-- que tienen mayor presupuesto.

-- Oracle

SELECT nombre, presupuesto
FROM departamento
ORDER BY presupuesto DESC
FETCH FIRST 3 ROWS ONLY;

-- SQLite

SELECT nombre, presupuesto
FROM departamento
ORDER BY presupuesto DESC
LIMIT 3; 


-- 6. Devuelve una lista con el nombre de los departamentos y el presupuesto, de 
-- aquellos que tienen un presupuesto entre 100000 y 200000 euros. Hazlo dos 
-- veces: primero con el operador BETWEEN y luego sin él.

SELECT nombre, presupuesto
FROM departamento
WHERE presupuesto BETWEEN 100000 AND 200000; 

SELECT nombre, presupuesto
FROM departamento
WHERE presupuesto >= 100000 AND presupuesto <= 200000; 


-- 7. Lista todos los datos de los empleados cuyo segundo apellido no 
-- conozcamos.

SELECT *
FROM empleado
WHERE apellido2 IS NULL; 


-- 8. Lista todos los datos de los empleados cuyo segundo apellido sea Díaz o 
-- Moreno. Hazlo de 2 formas: primero sin utilizar el operador IN, y después 
-- utilizando dicho operador.

SELECT *
FROM empleado
WHERE apellido2 = 'Díaz' OR apellido2 = 'Moreno'; 

SELECT *
FROM empleado
WHERE apellido2 IN ('Díaz','Moreno');


-- 9. Devuelve un listado con los apellido1, apellido2 y nombre de los 
-- empleados, junto con el nombre de los departamentos donde trabaja cada uno. 
-- Hazlo de 2 formas: primero con INNER JOIN y luego con WHERE.

SELECT apellido1, apellido2, 
  empleado.nombre, departamento.nombre AS dpto
FROM departamento INNER JOIN empleado
ON departamento.id = id_departamento;

SELECT apellido1, apellido2, 
  empleado.nombre, departamento.nombre AS dpto
FROM empleado, departamento
WHERE departamento.id = id_departamento; 


-- 10. Devuelve un listado con el identificador y el nombre del departamento, 
-- solamente de aquellos departamentos que tienen empleados (de al menos 4 formas distintas).

SELECT DISTINCT departamento.id, departamento.nombre 
FROM departamento INNER JOIN empleado
ON departamento.id = id_departamento;

SELECT DISTINCT departamento.id, departamento.nombre 
FROM empleado, departamento
WHERE departamento.id = id_departamento; 

SELECT DISTINCT id, nombre 
FROM departamento WHERE id IN 
(
    SELECT id_departamento FROM empleado
);

SELECT DISTINCT id, nombre 
FROM departamento WHERE id = ANY 
(
    SELECT id_departamento FROM empleado
);

SELECT DISTINCT id, nombre 
FROM departamento WHERE EXISTS
(
    SELECT id_departamento FROM empleado
    WHERE empleado.id_departamento = departamento.id
);

-- Otras dos alternativas menos razonables (innecesariamente complejas)

SELECT DISTINCT departamento.id, departamento.nombre 
FROM departamento LEFT JOIN empleado
ON departamento.id = id_departamento
WHERE empleado.nombre IS NOT NULL;

SELECT departamento.id, departamento.nombre 
FROM departamento LEFT JOIN empleado
ON departamento.id = id_departamento
GROUP BY departamento.id, departamento.nombre
HAVING COUNT(empleado.nombre) > 0;
