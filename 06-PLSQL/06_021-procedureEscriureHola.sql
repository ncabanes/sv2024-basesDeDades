-- Crea un procediment "EscriureHola", que escriga "Hola" diverses vegades en 
-- l'eixida de la base de dades, que escriga hola diverses vegades, cada una en 
-- una línia diferente, tants com s'indiquen en un paràmetre numèric (d'entrada).

CREATE OR REPLACE PROCEDURE EscriureHola(numero IN NUMBER) IS
BEGIN
    FOR i IN 1..numero LOOP
        DBMS_OUTPUT.PUT_LINE('Hola');
    END LOOP;
END EscriureHola;

--LLAMADA A LA FUNCION
EXECUTE ESCRIUREHOLA(5);

-- BLOQUE ANÓNIMO
DECLARE
    quantitat NUMBER;
BEGIN
    quantitat := 7;
    ESCRIUREHOLA(quantitat);
END;
