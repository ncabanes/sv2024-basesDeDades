-- 06.30
-- 
-- Crea un script PL/SQL similar a l'anterior (nom de cada país i quantitat de 
-- ciutats o, si és zero, la paraula "Cap"), però en aquesta ocasió hauràs 
-- d'utilitzar un bucle LOOP, juntament amb la clàusula EXIT WHEN.

DECLARE
    vNom paises.nombre%TYPE;
    vQuantitat NUMBER;
    CURSOR cursor_pais IS
        SELECT p.nom,COUNT(ci.codi)
        FROM paisos p
        LEFT JOIN ciutats ci ON codiPais = p.codi
        GROUP BY p.nom;
BEGIN
    OPEN cursor_pais;
    LOOP
        FETCH cursor_pais INTO vNom, vQuantitat;
        EXIT WHEN cursor_pais%NOTFOUND;
        
        IF vQuantitat = 0 THEN
            DBMS_OUTPUT.PUT_LINE(vNom || ': Cap');
        ELSE
            DBMS_OUTPUT.PUT_LINE(vNom || ': ' || vQuantitat);
        END IF;
    END LOOP;
    CLOSE cursor_pais;
END;
