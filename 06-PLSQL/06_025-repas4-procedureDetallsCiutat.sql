-- Crea un procediment "MostrarDetallsCiutat", que reba com a
-- paràmetre el nom d'una ciutat (potser amb majúscules diferents)
-- i mostre el seu codi, la seua població i el nom del seu país, en 
-- línies diferents.


-- Previ: Consulta

SELECT ciutats.codi, ciutats.poblacio, paisos.nom
FROM ciutats JOIN paisos ON ciutats.codiPais = paisos.codi
WHERE UPPER(ciutats.nom) = 'TOKIO';

-- Procediment

CREATE OR REPLACE PROCEDURE MostrarDetallsCiutat(v_nom IN VARCHAR2)
IS 
    v_codi ciutats.codi % TYPE;
    v_poblacio ciutats.poblacio % TYPE;
    v_pais paisos.nom % TYPE;
BEGIN
    SELECT ciutats.codi, ciutats.poblacio, paisos.nom
    INTO v_codi, v_poblacio, v_pais
    FROM ciutats JOIN paisos 
        ON ciutats.codiPais = paisos.codi
    WHERE UPPER(ciutats.nom) = UPPER(v_nom);
    
    dbms_output.put_line('Codi: ' || v_codi);
    dbms_output.put_line('Població: ' || v_poblacio);
    dbms_output.put_line('País: ' || v_pais);
END MostrarDetallsCiutat;

-- --------

BEGIN
    MostrarDetallsCiutat('Tokio');
END;
