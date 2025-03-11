-- A partir de les dades de la taula de ciutats, crea un script que guarde 
-- en una variable la quantitat de ciutats que tenim del país el codi del 
-- qual és "US". Finalment, mostra el missatge "Tenim ciutats dels Estats 
-- Units" o bé "No tenim ciutats dels Estats Units", segons corresponga.

DECLARE
    quantitat NUMBER(4);
BEGIN
    
    SELECT COUNT(*)
    INTO quantitat
    FROM ciutats
    WHERE codiPais='US';
    
    IF quantitat > 0 THEN
        dbms_output.put_line('Tenim ciutats dels Estats Units');
    ELSE
        dbms_output.put_line('No tenim ciutats dels Estats Units');
    END IF;
END;
    
