-- 7.- Crea un procediment "MostrarRebuts", que reba com a paràmetres un 
-- codi de veí inicial (per exemple, el 2) i un codi de veí final (per 
-- exemple, el 4) i que, per a tots els veïns els codis dels quals estan 
-- entre aqueixos dos (inclusivament), mostre els seus rebuts: nom del 
-- veí, concepte i import, juntament amb el text "Pagat" o "No pagat", 
-- segons corresponga, ordenats per any i mes.

-- Procedure

CREATE OR REPLACE PROCEDURE MostrarRebuts (v_codiVei1 IN veins.codi%TYPE, 
    v_codiVei2 IN veins.codi%TYPE)
AS
BEGIN
    FOR v_vei IN v_codiVei1..v_codiVei2 LOOP
        FOR v_rebut IN (SELECT nom, concepte, import, dataPagament
            FROM rebuts INNER JOIN veins
            ON codiVei = veins.codi
            WHERE veins.codi = v_vei) LOOP
            
            IF v_rebut.dataPagament IS NULL THEN
                dbms_output.put_line(v_rebut.nom || ' ' 
                    || v_rebut.concepte || ' ' 
                    || v_rebut.import || ' No pagat');
            ELSE
                dbms_output.put_line(v_rebut.nom || ' ' 
                    || v_rebut.concepte || ' ' 
                    || v_rebut.import || ' Pagat');
            END IF;
            
        END LOOP;
    END LOOP;
END;

-- Prova

EXECUTE MostrarRebuts(2, 4);
