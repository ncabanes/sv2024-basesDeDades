-- A partir de los datos de facturas y clientes:

-- 1. Crea una función que devuelva el importe total de una factura.

CREATE OR REPLACE FUNCTION ImporteFactura (
	v_num_factura IN NUMBER
)
RETURN NUMBER
AS
	v_total NUMBER := 0;
BEGIN
	FOR v_linea IN (
		SELECT * FROM lineasFacturas
		WHERE numeroFactura = v_num_factura
	)
	LOOP
		v_total := v_total + 
			v_linea.unidades * v_linea.precioUnitario;
	END LOOP;
	
	RETURN v_total;
END ImporteFactura;

--

EXECUTE dbms_output.put_line( ImporteFactura(1) );

--

BEGIN
	dbms_output.put_line( ImporteFactura(1) );
END;

--

SELECT ImporteFactura(1) FROM dual;




-- 2. Crea una orden SQL que calcule el importe medio de las facturas 
-- (añade datos al menos de una segunda factura).


INSERT INTO facturas VALUES(2, 
    TO_DATE('2025-05-19', 'yyyy-mm-dd'), 1);

INSERT INTO lineasFacturas VALUES (2, 1, 'Pipas', 10, 0.50);
INSERT INTO lineasFacturas VALUES (2, 2, 'Cacahuetes', 25, 1.25);


-- select avg(unidades) from lineasFacturas;

SELECT AVG(ImporteFactura(numero)) FROM facturas;


-- 3. Muestra el número y el importe de las facturas que están por encima de la media.

-- La idea de lo que NO funciona:

-- select numeroFactura, numeroLinea 
-- from lineasFacturas 
-- where unidades > avg(unidades);

-- La idea de lo que SÍ funciona:

-- select numeroFactura, numeroLinea 
-- from lineasFacturas 
-- where unidades > 
-- (
-- 	SELECT avg(unidades) FROM lineasFacturas
-- );

SELECT numero, ImporteFactura(numero) 
FROM facturas 
WHERE ImporteFactura(numero) > 
(
	SELECT avg(ImporteFactura(numero)) FROM facturas
);


-- 4. Crea un trigger, que convierta en positivas las cantidades negativas 
-- que se indiquen en una línea de factura.

CREATE OR REPLACE TRIGGER unidadesNegativas
BEFORE INSERT ON lineasFacturas
FOR EACH ROW
BEGIN
	IF :new.unidades < 0 THEN
		:new.unidades := :new.unidades * (-1);
	END IF;
END;

INSERT INTO lineasFacturas VALUES (2, 3, 'Almendras', -50, 2.80);

SELECT * FROM lineasFacturas
WHERE numeroFactura = 2;


-- 5. Crea un procedimiento InsertarFactura(codCliente, concepto, precio unit.), 
-- que cree una nueva factura con el siguiente número que corresponda, con la 
-- fecha actual y con una única línea que contenga una unidad del artículo cuyo 
-- concepto se ha indicado.

CREATE OR REPLACE PROCEDURE InsertarFactura(
    v_codCliente IN clientes.codigo % TYPE,
    v_concepto IN lineasFacturas.concepto % TYPE,
    v_precio IN lineasFacturas.precioUnitario % TYPE,
)
AS
	v_numFactura NUMBER;
	v_fecha DATE;
BEGIN
	-- Obtenemos número de factura y fecha
	SELECT MAX(numero) + 1, SYSDATE
	INTO v_numFactura, v_fecha
	FROM factura;
	
    -- Creamos cabecera de factura
	INSERT INTO facturas VALUES (v_numFactura, v_fecha, v_codCliente);
	
	-- Creamos la única línea (primera), con cantidad 1
	INSERT INTO lineasFacturas VALUES (
		v_numFactura, 1, v_concepto, 1, v_precio);
END InsertarFactura;

-- Prueba

BEGIN
	InsertarFactura(1, 'Mosquiteras', 35);
    ImprimirFactura(3);
END;
