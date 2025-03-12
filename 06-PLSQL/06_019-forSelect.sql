-- Emprant un bucle FOR, mostra els codis i noms 
-- de les ciutats amb codis 1, 3, 5, ...

DECLARE
    maxim NUMBER;
    registre ciutats%ROWTYPE;
BEGIN
    SELECT MAX(codi)
    INTO maxim
    FROM ciutats;

    FOR i IN 1..maxim BY 2 LOOP
        SELECT *
        INTO registre
        FROM ciutats
        WHERE codi = i;
        
        dbms_output.put_line(registre.codi ||' '|| registre.nom);
    END LOOP;
END;
