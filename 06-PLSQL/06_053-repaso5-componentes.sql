-- Ordenadores + componentes + M:M

CREATE TABLE portatiles(
    codigo NUMBER(6),
    modelo VARCHAR2(100),
    precio NUMBER(7,2),
    gama VARCHAR2(30),
    CONSTRAINT pk_portatiles_codigo PRIMARY KEY (codigo)
);

CREATE TABLE componentes(
    codigo VARCHAR2(6),
    nombre VARCHAR2(100),
    categoria VARCHAR2(30),
    CONSTRAINT pk_componentes_codigo PRIMARY KEY (codigo)
);

CREATE TABLE contiene(
    codigoPortatil NUMBER(6),
    codigoComponente VARCHAR2(6),
    CONSTRAINT pk_contiene PRIMARY KEY (codigoPortatil, codigoComponente),
    CONSTRAINT fk_contiene_portatil FOREIGN KEY (codigoPortatil) REFERENCES portatiles(codigo),
    CONSTRAINT fk_contiene_componente FOREIGN KEY (codigoComponente) REFERENCES componentes(codigo)
);


INSERT INTO portatiles VALUES(1,'PcCom Legend', 1999.98, 'gaming');
INSERT INTO portatiles VALUES(2,'MSI Cyborg 15', 999.00, 'gaming');

INSERT INTO componentes VALUES('i713', 'i7-13650HX', 'Procesador' );
INSERT INTO componentes VALUES('i513', 'i5-13450HX', 'Procesador' );
INSERT INTO componentes VALUES('M32', '32GB a 4800 MT/s', 'Memoria' );
INSERT INTO componentes VALUES('M64', '64GB a 4800 MT/s', 'Memoria' );
INSERT INTO componentes VALUES('S058', 'SSD NVMe PCIe M.2 de 512 GB 2280', 'Almacenamiento' );

INSERT INTO contiene VALUES(1,'i713');
INSERT INTO contiene VALUES(1,'M64');
INSERT INTO contiene VALUES(1,'S058');
INSERT INTO contiene VALUES(2,'i513');
INSERT INTO contiene VALUES(2,'M32');


-- 1. Muestra nombre y precio del portátil más caro, de 4 formas distintas.

-- 1a. ORDER BY + FETCH

SELECT modelo, precio 
FROM portatiles
ORDER BY precio DESC
FETCH NEXT 1 ROWS ONLY;

SELECT modelo, precio 
FROM portatiles
ORDER BY precio DESC
FETCH FIRST 1 ROW ONLY;

-- SQLite , MySQL

SELECT modelo, precio 
FROM portatiles
ORDER BY precio DESC
LIMIT 1;

-- 1b. Lo que NO funciona

SELECT modelo, precio 
FROM portatiles WHERE precio = MAX(precio);

-- 1c. Subconsulta con MAX

SELECT modelo, precio 
FROM portatiles WHERE precio =
(
    SELECT MAX(precio)
    FROM portatiles
);


-- 1d. Subconsulta con ANY / ALL

SELECT modelo, precio 
FROM portatiles WHERE precio >= ALL
(
    SELECT precio
    FROM portatiles
);


-- 1e. Subconsulta con EXISTS / NOT EXISTS

SELECT modelo, precio 
FROM portatiles p1 WHERE NOT EXISTS
(
    SELECT modelo FROM portatiles p2
    WHERE p2.precio > p1.precio
);



-- 2. Muestra componentes huérfanos, de (al menos) 3 formas distintas

INSERT INTO componentes VALUES('izip', 'iOmega ZIP 100MB', 'Almacenamiento' );


-- 2a. IN / NOT IN

SELECT nombre FROM componentes
WHERE codigo NOT IN
(
    SELECT codigoComponente FROM contiene
);

-- 2b. ALL / ANY

SELECT nombre FROM componentes
WHERE codigo <> ALL
(
    SELECT codigoComponente FROM contiene
);

-- 2c. EXISTS / NOT EXISTS

SELECT nombre FROM componentes
WHERE NOT EXISTS
(
    SELECT codigoComponente FROM contiene
    WHERE codigoComponente = componentes.codigo
);

-- 2d. JOIN

SELECT nombre 
FROM componentes LEFT JOIN contiene
    ON codigoComponente = componentes.codigo
WHERE codigoPortatil IS NULL;

-- 2e. EXCEPT (sólo el código)

SELECT codigo FROM componentes
EXCEPT
SELECT codigoComponente FROM contiene;


-- 3. Cantidad de componentes de cada portátil

INSERT INTO portatiles VALUES(3,'Asus ROG Ally X', 899, 'consola');

SELECT modelo, COUNT(codigoComponente)
FROM portatiles LEFT JOIN contiene
    ON contiene.codigoPortatil = portatiles.codigo
GROUP BY modelo;


-- 4. Cantidad de componentes de cada portátil, para los que realmente conozcamos componentes

SELECT modelo, COUNT(codigoComponente)
FROM portatiles LEFT JOIN contiene
    ON contiene.codigoPortatil = portatiles.codigo
GROUP BY modelo
HAVING COUNT(codigoComponente) > 0;

SELECT modelo, COUNT(codigoComponente)
FROM portatiles INNER JOIN contiene
    ON contiene.codigoPortatil = portatiles.codigo
GROUP BY modelo;


-- 4. Procedimiento: MostrarMasCarosQue(codPortatil). De cada uno, mostrará el nombre y la diferencia de precio.

CREATE OR REPLACE PROCEDURE MostrarMasCarosQue (v_codigo_portatil IN NUMBER)
AS
    v_precio NUMBER;
BEGIN
    SELECT precio
    INTO v_precio
    FROM portatiles
    WHERE codigo = v_codigo_portatil;
    
    FOR portatil IN (SELECT * FROM portatiles WHERE precio > v_precio) LOOP 
        dbms_output.put_line(portatil.modelo|| ' ' || (portatil.precio - v_precio));
    END LOOP;
END MostrarMasCarosQue;

-- Prueba

BEGIN
    MostrarMasCarosQue(2);
END;


-- 4. Función: PrecioMedioMasCarosQue(codPortatil), sin usar AVG.


CREATE OR REPLACE FUNCTION PrecioMedioMasCarosQue (v_codigo_portatil IN NUMBER)
RETURN NUMBER
AS
    v_precio portatiles.precio % TYPE;
    v_cantidad NUMBER := 0;
    v_total portatiles.precio % TYPE := 0;
BEGIN
    SELECT precio
    INTO v_precio
    FROM portatiles
    WHERE codigo = v_codigo_portatil;
    
    FOR portatil IN (SELECT * FROM portatiles WHERE precio > v_precio) LOOP 
        v_cantidad := v_cantidad + 1;
    v_total := v_total + portatil.precio;
    END LOOP;
    
    IF v_cantidad > 0 THEN
        RETURN v_total / v_cantidad;
    ELSE
        RETURN -1;
    END IF;
    
END PrecioMedioMasCarosQue;

-- Prueba

BEGIN
    dbms_output.put_line(PrecioMedioMasCarosQue(2));
END;

SELECT PrecioMedioMasCarosQue(2) FROM dual;


-- 5. Anotar los cambios de precios

CREATE TABLE cambiosPrecios (
    codigo NUMBER(6),
    fecha DATE,
    precioIni NUMBER(7,2),
    precioFin NUMBER(7,2),
    CONSTRAINT pk_cambios PRIMARY KEY (codigo, fecha)
);

CREATE OR REPLACE TRIGGER cambioEnPrecio
AFTER UPDATE
ON portatiles
FOR EACH ROW
BEGIN
    INSERT INTO cambiosPrecios VALUES (:new.codigo,
        SYSDATE, :old.precio, :new.precio);
END;

-- Prueba:

UPDATE portatiles SET precio = 898 WHERE codigo = 3;

SELECT * FROM cambiosPrecios;
