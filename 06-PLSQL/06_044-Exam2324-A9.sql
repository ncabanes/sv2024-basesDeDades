--9.- Crea un procediment "IntroduirDiversosRebuts", que reba com a 
--paràmetres el codi de veí, any, import i concepte, i que inserirà dades 
--des del mes 1 fins al mes 12 d'eixe any, amb eixe import, eixe 
--concepte, amb número de rebut 1 i sense data de pagament.

CREATE OR REPLACE PROCEDURE IntroduirDiversosRebuts (
    v_codiVei IN veins.codi % TYPE, 
    v_any IN NUMBER,
    v_import IN rebuts.import % TYPE,
    v_concepte IN VARCHAR2)
AS
BEGIN
    FOR v_mes IN 1..12 LOOP
        INSERT INTO rebuts 
            (numMes, numAny, codiVei, numRebutMes, concepte, import, dataPagament)
            VALUES 
            (v_mes, v_any, v_codiVei, 1, v_concepte, v_import, NULL);
    END LOOP;
END;

-- Prova

EXECUTE IntroduirDiversosRebuts(4, 2025, 50, 'Neteja del garatge');

SELECT * FROM rebuts WHERE codiVei = 4;
