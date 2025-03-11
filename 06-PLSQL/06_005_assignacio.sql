-- Obtingues el nom de la ciutat amb codi 7. Després, guarda en una variable 
-- addicional el seu equivalent en majúscules i mostra'l en pantalla.

DECLARE
    nomCiutat ciutats.nom%TYPE;
    ciutatMajuscules ciutats.nom%TYPE;
BEGIN
    SELECT nom
    INTO nomCiutat
    FROM ciutats
    WHERE codi = 7;

    ciutatMajuscules := UPPER(ciutat7);

    dbms_output.put_line(ciutatMajuscules);
END;
