-- A partir de les dades de la taula de ciutats, crea un script que 
-- guarde en una variable la quantitat de ciutats que tenim del país el 
-- codi del qual és "IN". En una altra variable, guarda la quantitat de 
-- ciutats que tenim del país el codi del qual és "US". Finalment, mostra 
-- el missatge "Tenim més ciutats de l'Índia que dels Estats Units" o bé 
-- "No tenim més ciutats de l'Índia que dels Estats Units", segons 
-- corresponga.

-- Variant 1: ELSE IF

DECLARE
    quantitatUsa NUMBER(4);
    quantitatIndia NUMBER(4);
BEGIN
    
    SELECT COUNT(*)
    INTO quantitatUsa
    FROM ciutats
    WHERE codiPais='US';
    
    SELECT COUNT(*)
    INTO quantitatIndia
    FROM ciutats
    WHERE codiPais='IN';
    
    IF quantitatUsa > quantitatIndia THEN
        dbms_output.put_line('Tenim mes en Usa');
    ELSE
        IF quantitatIndia > quantitatUsa then
            dbms_output.put_line('Tenim mes en India');
        ELSE
            dbms_output.put_line('Empat');
        END IF;
    END IF;
END;
    
