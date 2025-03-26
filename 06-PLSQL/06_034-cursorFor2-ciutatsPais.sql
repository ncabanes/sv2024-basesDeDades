-- 6.34

-- Crea una funció anomenada "CiutatsPais", que retorne una cadena de text 
-- formada els noms de les ciutats que pertanyen al país el nom del qual 
-- s'indique com a paràmetre, ordenades alfabèticament i separades per 
-- comes, o "(No trobat)"si eixe país no existix. En esta versió has 
-- d'emprar FOR.

CREATE OR REPLACE FUNCTION CiutatsPais(nomPais IN VARCHAR2)
RETURN VARCHAR2 AS
    paisCiutats VARCHAR2(1000) := '';
    ciutat ciutats.nom%TYPE;
    CURSOR CursorCiutatsPais IS
        SELECT ci.nom AS nomCiutat
        FROM ciutats ci 
        LEFT JOIN paisos p ON codiPais = p.codi
        WHERE p.nom = nomPais
        ORDER BY ci.nom;

BEGIN 

    FOR i IN CursorCiutatsPais LOOP
        paisCiutats := paisCiutats || i.nomCiutat || ',';
    END LOOP;
    
    paisCiutats := RTRIM(paisCiutats, ',');

    IF paisCiutats IS NULL THEN 
        paisCiutats := 'No trobat';
    END IF;
    RETURN paisCiutats;

END CiutatsPais;

DECLARE
    pais paisos.nom%TYPE;
BEGIN 
    pais := 'China';
    dbms_output.put_line(pais||': '||CiutatsPais(pais));
END;
