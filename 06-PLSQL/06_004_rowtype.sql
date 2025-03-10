-- Fes un fragment de codi que obtinga el nom i la població de la ciutat menys 
-- poblada de la nostra base de dades, emprant %ROWTYPE.

DECLARE
    ciutatMinima ciutats % ROWTYPE;

BEGIN
    SELECT * 
    INTO ciutatMinima
    FROM ciutats
    ORDER BY poblacio
    FETCH NEXT 1 ROWS ONLY;
    
    dbms_output.put_line(
        ciutatMinima.nom || ' : ' ||
        ciutatMinima.poblacio
    );
END;
