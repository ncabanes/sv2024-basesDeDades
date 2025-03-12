-- Crea un bucle WHILE que mostre els números del 10 al 100, augmentant 
-- de 10 en 10.

DECLARE
    i NUMBER;
BEGIN   
    i :=10;
    WHILE i <= 100 LOOP
        dbms_output.put_line(i);
        i := i +10;
    END LOOP;
END;
