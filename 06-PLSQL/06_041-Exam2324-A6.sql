-- 6.- Crea una funció "QuantitatDeRebuts2", que reba com a paràmetre el 
-- codi d'un veí, el número d'un mes i l'any, i retorne el text "Un 
-- rebut", "Cap rebut" o "Més d'un rebut", segons corresponga a partir de 
-- la quantitat de rebuts que aqueix veí té en aqueix mes i aqueix any. 
-- Esta versió ha d'usar CASE en format d'expressió. Prova-la amb una 
-- sentència SELECT.

CREATE OR REPLACE FUNCTION QuantitatDeRebuts2 (v_codiVei IN veins.codi%TYPE, 
    v_mes IN rebuts.numMes%TYPE, v_any IN rebuts.numAny%TYPE)
RETURN VARCHAR2
AS
    v_quantitat NUMBER(4);
    v_resposta VARCHAR2(100);

BEGIN
    SELECT COUNT(*) INTO v_quantitat FROM rebuts r
    WHERE r.codiVei = v_codiVei
    AND r.numMes = v_mes
    AND r.numAny = v_any;
    
    v_resposta := CASE v_quantitat
        WHEN 0 THEN 'Cap rebut'
        WHEN 1 THEN 'Un rebut'
        ELSE 'Més d''un rebut'
    END;
    
    RETURN v_resposta;
END QuantitatDeRebuts2;

--Prova

SELECT QuantitatDeRebuts2(1, 5, 2023) FROM dual;
