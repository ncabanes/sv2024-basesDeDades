-- Fes un fragment de codi que obtinga la menor població de les ciutats 
-- de la nostra base de dades, la guarde en una variable "poblacioMinima" 
-- i després la mostre en la finestra d'eixida, emprant %TYPE

DECLARE
    poblacioMinima ciutats.poblacio%TYPE;

BEGIN
    SELECT MIN(poblacio) 
    INTO poblacioMinima
    FROM ciutats;
    
    dbms_output.put_line('Mínima: ' || poblacioMinima);
END;
