-- 20.Obtingues la quantitat de ciutats (sense duplicats) que tenim, el codi de 
-- país dels quals és "CN". Mostra eixa quantitat en números romans (de l'1 al 5, 
-- o amb el text "Més de 5", si és el cas), emprant CASE.

DECLARE 
    quantitat NUMBER(5);
    resposta VARCHAR(40);
BEGIN
    SELECT COUNT(DISTINCT(nom))
    INTO quantitat
    FROM ciutats
    WHERE codiPais = 'CN';
    
    -- Versió 1: CASE convencional

    CASE quantitat
        WHEN 1 THEN dbms_output.put_line('I');
        WHEN 2 THEN dbms_output.put_line('II');
        WHEN 3 THEN dbms_output.put_line('III');
        WHEN 4 THEN dbms_output.put_line('IV');
        WHEN 5 THEN dbms_output.put_line('V');
        ELSE dbms_output.put_line('Més de 5');
    END CASE;    

    -- Versió 2: CASE en format d¡expressió

    resposta := CASE quantitat
       WHEN 1 THEN 'I'
       WHEN 2 THEN 'II'
       WHEN 3 THEN 'III'
       WHEN 4 THEN 'IV'
       WHEN 5 THEN 'V'
       ELSE 'Més de 5'
    END;    

    dbms_output.put_line(resposta);
END;


