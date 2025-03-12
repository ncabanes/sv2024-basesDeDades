-- Crea un bucle LOOP que mostre els números del 10 al 1, Disminuint 1. 
-- Has d'emprar la sintaxi EXIT WHEN.

DECLARE 
    i NUMBER;
BEGIN 
    i := 10;
    LOOP
        dbms_output.put_line(i);
        EXIT WHEN i <= 1;
        i := i - 1;
    END LOOP;
END;
