-- 06.31
-- 
-- Crea un script PL/SQL similar a l'anterior (nom de cada país i quantitat de 
-- ciutats o, si és zero, la paraula "Cap"), però en aquesta ocasió hauràs 
-- d'utilitzar un bucle FOR. 

DECLARE
    CURSOR cursor_pais IS
        SELECT p.nom, COUNT(c.codi) as quantitatCiutats
        FROM paisos p LEFT JOIN ciutats c
        ON c.codiPais = p.codi
        GROUP BY p.nom;
BEGIN
    FOR registre IN cursor_pais LOOP
        IF registre.quantitatCiutats = 0 THEN
            DBMS_OUTPUT.PUT_LINE(registre.nom || ': Cap');
        ELSE
            DBMS_OUTPUT.PUT_LINE(registre.nom || ': ' || registre.quantitatCiutats);
        END IF;
    END LOOP;
END;
