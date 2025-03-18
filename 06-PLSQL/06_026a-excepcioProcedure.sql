-- Crea una funció anomenada "QuantitatCiutats", que reba un codi de país i 
-- retorne el text "No té ciutats", "Té una ciutat" o "Té més d'una ciutat", 
-- segons corresponga. Has d'emprar excepcions.

-- Aproximació: procediment "MostrarQuantitatCiutats"

-- Previ: Consulta 

SELECT * FROM ciutats
WHERE codiPais = 'CN';

-- Procediment

CREATE PROCEDURE MostrarQuantitatCiutats( v_codiPais IN VARCHAR2 )
AS
    v_nom ciutats.nom % TYPE; 
BEGIN 
    SELECT nom
    INTO v_nom
    FROM ciutats
    WHERE codiPais = v_codiPais;
    
    dbms_output.put_line('Té una ciutat'); 

EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
        dbms_output.put_line('No té ciutats'); 
    WHEN TOO_MANY_ROWS THEN 
        dbms_output.put_line('Té més d''una ciutat'); 
    WHEN OTHERS THEN 
        dbms_output.put_line('!!!???'); 
END MostrarQuantitatCiutats; 

-- Prova

BEGIN
    dbms_output.put_line('China');
    MostrarQuantitatCiutats('CN');
    
    dbms_output.put_line('España');
    MostrarQuantitatCiutats('ES');
END;
