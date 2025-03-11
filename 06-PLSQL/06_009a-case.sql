-- A partir de les dades de la taula de ciutats, crea un script que diga "No 
-- tenim cap país que continga la paraula Unido","Tenim un país amb la paraula 
-- Unido", "Tenim dos països amb la paraula Unido" o "Tenim més de 2 països amb 
-- la paraula Unido", segons corresponga, emprant CASE.

DECLARE
    quantitat NUMBER(4);
BEGIN
    SELECT COUNT(*)
    INTO quantitat
    FROM paises
    WHERE LOWER(nombre) LIKE '%unido%';

    CASE quantitat
        WHEN 0 THEN
            DBMS_OUTPUT.PUT_LINE('Ningú país');
        WHEN 1 THEN
            DBMS_OUTPUT.PUT_LINE('Un país');
        WHEN 2 THEN
            DBMS_OUTPUT.PUT_LINE('Dos països');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Més de dos països');
    END CASE;
END;
