-- Crea un bucle FOR que mostre els números del 20 al 200, 
-- augmentant de 10 en 10.

-- Variant 2: BY (Oracle 21c i posteriors)

BEGIN
    FOR i IN 20 .. 200 BY 10 LOOP
        dbms_output.put_line(i);
    END LOOP;
END;
