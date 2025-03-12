-- Crea un bucle FOR que mostre els números del 20 al 200, 
-- augmentant de 10 en 10.

-- Variant 1: Multiplicació

BEGIN
    FOR I IN 2..20 LOOP
        dbms_output.put_line(i*10);
    END LOOP;
END;
