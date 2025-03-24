-- 6.29
-- 
-- Crea un script PL/SQL que utilitze cursors per a obtindre la següent informació 
-- a partir de la nostra base de dades de països i ciutats: per a cada un dels 
-- països, es mostrarà el seu nom i la quantitat de ciutats seues que tenim 
-- emmagatzemades. En cas que eixa quantitat siga 0 per a algun país, no es 
-- mostrarà el número 0, sinó el text "Cap". Usa un bucle WHILE, com en l'exemple 
-- anterior. 

DECLARE
    v_nom paisos.nom % TYPE;
    v_ciutats NUMBER;
    CURSOR CursorCiutatsPais IS
        SELECT p.nom,COUNT(ci.codi)
        FROM paisos p
        LEFT JOIN ciutats ci ON codiPais = p.codi
        GROUP BY p.nom;

BEGIN 
    OPEN CursorCiutatsPais;
    FETCH CursorCiutatsPais INTO v_nom, v_ciutats;
    WHILE CursorCiutatsPais%FOUND LOOP 
        IF v_ciutats = 0 THEN
            dbms_output.put_line( v_nom || ' - Ciutats: Cap');
        ELSE
            dbms_output.put_line( v_nom ||' Ciutats:'|| v_ciutats);
        END IF;
        FETCH CursorCiutatsPais INTO v_nom, v_ciutats;
    END LOOP;
    CLOSE CursorCiutatsPais;
END;
