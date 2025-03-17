-- Crea un procediment "EscriureGuions", millorat, que escriga diversos guions 
-- en l'eixida de la base de dades, tants com s'indiquen en un paràmetre 
-- numèric (d'entrada). Si s'indica un número superior a 100, només escriurà 
-- 100.

CREATE OR REPLACE PROCEDURE EscriureGuions(numero IN NUMBER)
IS 
    cadena VARCHAR2(100) := '';
    numerin NUMBER := numero;
BEGIN
    IF numerin > 100 THEN
        numerin := 100;
    END IF;

    FOR i IN 1..numerin LOOP
        cadena := cadena || '-';
    END LOOP;
    dbms_output.put_line(cadena);
END EscriureGuions;

-- --------

DECLARE
    numero NUMBER;
BEGIN
    numero := 500;
    EscriureGuions(numero);
END;
