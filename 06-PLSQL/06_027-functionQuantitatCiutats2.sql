-- Crea una funció anomenada "QuantitatCiutats2", que reba un codi de país
-- i retorne el text "No té ciutats", "Té una ciutat" o "Té més d'una ciutat", 
-- segons corresponga. No has d'emprar excepcions, sinó COUNT.

CREATE OR REPLACE FUNCTION QuantitatCiutats2( v_codiPais IN VARCHAR2 )
RETURN VARCHAR2
AS
    quantitat NUMBER; 
BEGIN 
    SELECT COUNT(*)
    INTO quantitat
    FROM ciutats
    WHERE codiPais = v_codiPais;
    
    CASE quantitat
        WHEN 0 THEN
            RETURN 'No té ciutats';
        WHEN 1 THEN
            RETURN 'Té una ciutat';
        ELSE
            RETURN 'Té més d''una ciutat';
    END CASE;
END QuantitatCiutats2; 

-- Prova

BEGIN
    dbms_output.put_line('China: ' || QuantitatCiutats2('CN'));    
    dbms_output.put_line('España: ' || QuantitatCiutats2('ES'));
END;
