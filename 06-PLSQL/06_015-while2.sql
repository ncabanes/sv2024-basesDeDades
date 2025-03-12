-- Crea un bucle WHILE que mostre els números del 10 al 1, descomptant 
-- d'1 en 1.

DECLARE
    i NUMBER;
BEGIN   
    i := 10;
    WHILE i > 0 LOOP
        dbms_output.put_line(i);
        i := i - 1;
    END LOOP;
END;
