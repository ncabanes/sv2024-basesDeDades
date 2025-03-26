-- 4.- Crea un procediment "MostrarImpagaments", que, a partir del nom 
-- d'un veí que se li passarà com a paràmetre (i que potser no està amb 
-- les majúscules correctes), mostre la llista de tots els seus rebuts 
-- impagats (mes, any, concepte, import), ordenats per any i mes. També 
-- haurà de mostrar l'import total dels impagaments, en la línia 
-- posterior. Usa un bucle WHILE. Si el veí no existeix, mostrarà "Veí 
-- inexistent". No ha d'utilitzar control d'excepcions. Prova-ho des d'un 
-- bloc anònim.

-- Prova prévia

SELECT numMes, numAny, concepte, import
FROM rebuts INNER JOIN veins
ON codiVei = veins.codi
WHERE dataPagament IS NULL
AND veins.nom = 'Alberto Alvarez';

-- Procediment

CREATE OR REPLACE PROCEDURE MostrarImpagaments (v_nomVei veins.nom%TYPE)
AS
    CURSOR c IS
        SELECT numMes, numAny, concepte, import
            FROM rebuts INNER JOIN veins
            ON codiVei = veins.codi
            WHERE dataPagament IS NULL
            AND veins.nom = v_nomVei;

    v_quantitatVeins NUMBER;
    
    v_mes rebuts.numMes%TYPE;
    v_any rebuts.numAny%TYPE;
    v_concepte rebuts.concepte%TYPE;
    v_import rebuts.import%TYPE;
    
    v_total rebuts.import%TYPE := 0;

BEGIN

    -- Sense excepcions: fem servir un comptador
    SELECT COUNT(*) 
    INTO v_quantitatVeins
    FROM veins
    WHERE nom = v_nomVei;
    
    IF v_quantitatVeins = 0 THEN
        dbms_output.put_line('Veí inexistent');
    ELSE
        OPEN c;
        FETCH c INTO v_mes, v_any, v_concepte, v_import;
        WHILE c % FOUND LOOP
            dbms_output.put_line(v_mes || '/' || v_any || ': ' 
                || v_concepte || ' ' || v_import);
            v_total := v_total + v_import;
            FETCH c INTO v_mes, v_any, v_concepte, v_import;
        END LOOP;
        CLOSE c;
        dbms_output.put_line('Total: ' || v_total);
    END IF;
END;

--Prova

BEGIN
    MostrarImpagaments('Alberto Alvarez');
END;
