--11. A partir de les dades de la taula de països, crea un script que  
--emplene una variable de text amb els valors "Zero", "Un", "Dos" o 
--"Més de dos"  segons la quantitat de països que continguen la paraula 
--"Unido". Finalment, haurà de mostrar el valor d'aqueixa variable.

DECLARE 
    quantitat NUMBER(5);
    resposta VARCHAR(40);
BEGIN
    SELECT COUNT(codigo)
    INTO quantitat
    FROM ciutats
    WHERE UPPER(nombre) LIKE '%Unido%';
    
    resposta:= CASE quantitat
        WHEN 0 THEN 'Zero'
        WHEN 1 THEN 'Un'
        WHEN 2 THEN 'Dos'
        ELSE 'Més de dos'
    END;
    dbms_output.put_line(resposta);
END;
