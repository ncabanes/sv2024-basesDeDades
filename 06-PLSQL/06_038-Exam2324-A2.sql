-- 2.- Crea una nova versió del teu bloc anònim, que no use un CURSOR sinó 
-- un FOR amb una sentència SELECT incrustada.

BEGIN
    FOR i in (SELECT codi, nom, numMes, import
            FROM veins INNER JOIN rebuts
            ON codi = codiVei
            WHERE dataPagament IS NULL) 
        LOOP
        dbms_output.put_line(i.codi  || '  ' || i.nom  || '  '
            || i.numMes  || '  ' || i.import);
    END LOOP;
END;
