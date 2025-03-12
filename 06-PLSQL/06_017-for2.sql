-- Crea un bucle FOR que mostre els números del 10 al 1, 
-- descomptant d'1 en 1.

BEGIN   
    FOR i IN REVERSE 1..10 LOOP
        dbms_output.put_line(i);
    END LOOP;
END;
