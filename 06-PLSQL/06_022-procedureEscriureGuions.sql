-- Crea un procediment "EscriureGuions", que escriga diversos guions en 
-- l'eixida de la base de dades, en la mateixa línia, tants com s'indiquen en 
-- un paràmetre numèric (d'entrada).

CREATE OR REPLACE PROCEDURE EscriureGuions(numero IN NUMBER) 
IS 
    cadena VARCHAR2(100) := '';
BEGIN
    FOR i IN 1..numero LOOP
        cadena := cadena || '-';
    END LOOP;
    dbms_output.put_line(cadena);
END EscriureGuions;

-- --------

DECLARE
    numero NUMBER;
BEGIN
    numero := 5;
    EscriureGuions(numero);
END;
