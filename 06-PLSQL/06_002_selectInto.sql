-- Basant-te en el primer exemple, fes un fragment de codi que obtinga la 
-- població mitjana de les ciutats de la nostra base de dades, la guarde 
-- en una variable "poblacioMitjana" i després la mostre en la finestra 
-- d'eixida.

DECLARE
    poblacioMitjana NUMBER(13,3);

BEGIN
    SELECT AVG(poblacio) 
    INTO poblacioMitjana
    FROM ciutats;
    
    dbms_output.put_line('Mitjana: ' || poblacioMitjana);
END;
