-- 3.- Crea una funció "ImportImpagaments" que, rebent com a paràmetre el 
-- codi d'un veí, retorne l'import total dels seus rebuts impagats (data 
-- de pagament NULL). En comptes d'emprar la funció "SUM" de SQL, hauràs 
-- de recórrer els registres amb un bucle LOOP. Prova la funció amb 
-- EXECUTE.

CREATE OR REPLACE FUNCTION ImportImpagaments (v_codiVei IN NUMBER) 
RETURN NUMBER 
IS
    CURSOR c IS
        SELECT import
        FROM rebuts
        WHERE codiVei = v_codiVei
        AND dataPagament IS NULL;
    
    v_import rebuts.import % TYPE;
    v_total rebuts.import % TYPE := 0;

BEGIN
    OPEN c;
    LOOP
        FETCH c INTO v_import;
        EXIT WHEN c % NOTFOUND;
        v_total := v_total + v_import;
    END LOOP;
    CLOSE c;
    RETURN v_total;
END ImportImpagaments;

-- -------------------


EXECUTE dbms_output.put_line(ImportImpagaments(1));

BEGIN
    dbms_output.put_line(ImportImpagaments(1));
END;

SELECT ImportImpagaments(1) FROM dual;


