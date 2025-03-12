-- Crea un bucle FOR que mostre els números del 20 al 30.

BEGIN
    FOR i IN 20 .. 30 LOOP
        DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
END;
