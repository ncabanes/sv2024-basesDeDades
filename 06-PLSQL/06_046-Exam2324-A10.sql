-- 10.- Crea un procediment "MostrarImpagamentsMes", que, a partir d'un 
-- número de mes i un número d'any, mostre primer el nom del mes 
-- (utilitzant CASE en el seu format detallat), i després els rebuts 
-- impagats d'eixe mes i eixe any (nom de veí, concepte i import, ordenat 
-- per nom de veí). Prova-ho amb EXECUTE.

CREATE OR REPLACE PROCEDURE MostrarImpagamentsMes (
    v_mes IN NUMBER, 
    v_any IN NUMBER)
AS
    CURSOR impagats IS
        SELECT nom, concepte, import
        FROM veins INNER JOIN rebuts
        ON codi = codiVei
        WHERE dataPagament IS NULL
        AND numMes = v_mes
        AND numAny = v_any
        ORDER BY nom;
BEGIN
    CASE v_mes
        WHEN 1 THEN dbms_output.put_line('Gener');
        WHEN 2 THEN dbms_output.put_line('Febrer');
        WHEN 3 THEN dbms_output.put_line('Març');
        WHEN 4 THEN dbms_output.put_line('Abril');
        WHEN 5 THEN dbms_output.put_line('Maig');
        WHEN 6 THEN dbms_output.put_line('Juny');
        WHEN 7 THEN dbms_output.put_line('Juliol');
        WHEN 8 THEN dbms_output.put_line('Agost');
        WHEN 9 THEN dbms_output.put_line('Setembre');
        WHEN 10 THEN dbms_output.put_line('Octubre');
        WHEN 11 THEN dbms_output.put_line('Novembre');
        WHEN 12 THEN dbms_output.put_line('Desembre');
    END CASE;
    
    FOR r IN impagats LOOP
        dbms_output.put_line(r.nom || ', ' ||
            r.concepte || ': ' || r.import);
    END LOOP;
END;


EXECUTE MostrarImpagamentsMes(5,2025);
