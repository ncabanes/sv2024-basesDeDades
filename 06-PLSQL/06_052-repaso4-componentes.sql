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


-- 1. Nombre, precio y componentes de cada portátil

SELECT p.modelo, precio, c.nombre FROM portatiles p
JOIN contiene ON p.codigo = codigoPortatil
JOIN componentes c ON codigoComponente = c.codigo
ORDER BY p.modelo, c.nombre;


-- 2.- Procedure PL/SQL que muestre nombre y precio 
-- del portátil (sólo 1 vez) y luego la lista de sus componentes.

CREATE OR REPLACE PROCEDURE componentesPortatiles(v_codigoP IN NUMBER) IS
    v_datos_portatil portatiles%rowtype;

BEGIN 
    SELECT * INTO v_datos_portatil FROM portatiles WHERE codigo =  v_codigoP;
    dbms_output.put_line(v_datos_portatil.modelo || ' ' || v_datos_portatil.precio);

    FOR componente IN (SELECT * FROM componentes JOIN contiene ON codigo = codigoComponente 
            WHERE contiene.CODIGOPORTATIL = v_codigoP) LOOP 

        dbms_output.put_line(componente.codigo || ' ' || componente.nombre || ' ' || componente.categoria);
    END LOOP;
END; 

-- Prueba 

EXECUTE componentesPortatiles(1);



-- 3.- Nombre de los portátiles para los que no hayamos indicado ningún componente 
-- de la categoría "Almacenamiento".

-- Previo 3a - Lista de códigos de componentes de "Almacenamiento"

SELECT * FROM componentes WHERE categoria = 'Almacenamiento';

-- Previo 3b - Qué códigos de portátiles (¿no?) contienen ninguno de esos códigos de componente

SELECT codigoPortatil FROM contiene JOIN componentes 
ON codigoComponente = componentes.codigo 
WHERE categoria = 'Almacenamiento'; 

-- Final 3c - Nombre de los portátiles que no lo contienen

SELECT modelo FROM portatiles WHERE portatiles.codigo NOT IN (
    SELECT codigoPortatil FROM contiene JOIN componentes 
    ON codigoComponente = componentes.codigo 
    WHERE categoria = 'Almacenamiento'
);


-- 4.- Crea una función en PL/SQL que, a partir del código de un 
-- portátil, devuelva el precio medio aproximado de sus componentes.

CREATE OR REPLACE FUNCTION PrecioMedioComponentes (v_codigo_portatil IN NUMBER)
RETURN NUMBER
AS
	v_precio NUMBER;
	v_cantidad NUMBER;
BEGIN
    SELECT precio
	INTO v_precio
	FROM portatiles
    WHERE codigo = v_codigo_portatil;
    
    SELECT COUNT(*)
	INTO v_cantidad
    FROM contiene
    WHERE codigoPortatil = v_codigo_portatil;
    
	RETURN v_precio / v_cantidad;
END PrecioMedioComponentes;

-- Prueba

BEGIN
	dbms_output.put_line(PrecioMedioComponentes(1));
END;