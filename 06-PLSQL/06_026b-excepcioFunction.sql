-- Crea una funció anomenada "QuantitatCiutats", que reba un codi de país i 
-- retorne el text "No té ciutats", "Té una ciutat" o "Té més d'una ciutat", 
-- segons corresponga. Has d'emprar excepcions.

CREATE FUNCTION QuantitatCiutats( v_codiPais IN VARCHAR2 )
RETURN VARCHAR2
AS
    v_nom ciutats.nom % TYPE; 
BEGIN 
    SELECT nom
    INTO v_nom
    FROM ciutats
    WHERE codiPais = v_codiPais;
    
    RETURN 'Té una ciutat'; 

EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
        RETURN 'No té ciutats'; 
    WHEN TOO_MANY_ROWS THEN 
        RETURN 'Té més d''una ciutat'; 
    WHEN OTHERS THEN 
        RETURN '!!!???'; 
END QuantitatCiutats; 

-- Prova

BEGIN
    dbms_output.put_line('China: ' || QuantitatCiutats('CN'));    
    dbms_output.put_line('España: ' || QuantitatCiutats('ES'));
END;
