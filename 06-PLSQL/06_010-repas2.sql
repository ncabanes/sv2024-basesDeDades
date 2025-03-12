-- 10.Obtingues la quantitat de ciutats (sense duplicats) que tenim, el 
-- codi de país dels quals és "CN". Mostra eixa quantitat en números 
-- romans (de l'1 al 5, o amb el text "Més de 5", si és el cas).

-- Consulta prèvia: noms de ciutats (potser amb duplicats)

SELECT nom FROM ciutats
WHERE codiPais = 'CN';

-- Consulta real

SELECT COUNT(DISTINCT(nom)) FROM ciutats
WHERE codiPais = 'CN';

-- Bloc anónim

DECLARE 
    quantitat NUMBER(5);
    resposta VARCHAR(40);
BEGIN
    SELECT COUNT(DISTINCT(nom))
    INTO quantitat
    FROM ciutats
    WHERE codiPais = 'CN';

    IF quantitat = 1 THEN resposta := 'I';
    ELSIF quantitat = 2 THEN resposta := 'II';
    ELSIF quantitat = 3 THEN resposta := 'III';
    ELSIF quantitat = 4 THEN resposta := 'IV';
    ELSIF quantitat = 5 THEN resposta := 'V';
    ELSE resposta := 'Més de 5';
    END IF;    

    dbms_output.put_line(resposta);
END;
