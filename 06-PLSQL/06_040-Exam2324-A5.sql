-- 5.- Crea una funció "QuantitatDeRebuts", que reba com a paràmetre el 
-- codi d'un veí, el número d'un mes i l'any, i retorne el text "Un 
-- rebut", "Cap rebut" o "Més d'un rebut", segons corresponga a partir de 
-- la quantitat de rebuts que aqueix veí té en aqueix mes i aqueix any. No 
-- ha d'usar IF (ni CASE) sinó control d'excepcions. Prova-la des d'un 
-- bloc anònim.

CREATE FUNCTION QuantitatDeRebuts (v_codiVei IN veins.codi%TYPE, 
    v_mes IN rebuts.numMes%TYPE, v_any IN rebuts.numAny%TYPE)
RETURN VARCHAR2
AS
    v_rebut rebuts % ROWTYPE;

BEGIN
    SELECT r.* INTO v_rebut FROM rebuts r
    WHERE r.codiVei = v_codiVei
    AND r.numMes = v_mes
    AND r.numAny = v_any;
    RETURN 'Un rebut';
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 'Cap rebut';
        WHEN TOO_MANY_ROWS THEN
            RETURN 'Més d''un rebut';
END QuantitatDeRebuts;

-- -----

--Prova

BEGIN
    dbms_output.put_line(QuantitatDeRebuts(1, 5, 2023));
END;
