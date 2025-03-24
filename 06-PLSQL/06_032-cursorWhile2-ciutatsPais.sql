-- 6.32
-- 
-- Crea una funció anomenada "CiutatsPais", que retorne una cadena de text formada 
-- els noms de les ciutats que pertanyen al país el nom del qual s'indique com a 
-- paràmetre, ordenades alfabèticament i separades per comes, o "(No trobat)"si 
-- eixe país no existix. En esta versió has d'emprar WHILE.

-- Aproximació 1: consulta

SELECT DISTINCT p.nom AS pais, c.nom AS ciutat
FROM paisos p
LEFT JOIN ciutats c ON codiPais = p.codi
WHERE p.nom = 'China';

-- Aproximació 2: cursor en bloc anónim

DECLARE
    v_ciutat ciutats.nom % TYPE;
    v_resposta VARCHAR2(1000) := '';
    CURSOR cursorCiutats IS
        SELECT DISTINCT c.nom AS ciutat
        FROM paisos p
        LEFT JOIN ciutats c ON codiPais = p.codi
        WHERE p.nom = 'China';

BEGIN 
    OPEN cursorCiutats;
    FETCH cursorCiutats INTO v_ciutat;
    WHILE cursorCiutats%FOUND LOOP 
        v_resposta := v_resposta || v_ciutat || ',';
        FETCH cursorCiutats INTO v_ciutat;
    END LOOP;
    CLOSE cursorCiutats;
    
    v_resposta := RTRIM(v_resposta, ',');
    IF v_resposta  IS NULL THEN
        v_resposta := '(No trobat)';
    END IF;

    DBMS_OUTPUT.PUT_LINE(v_resposta);
END;

-- 3: Funció

CREATE OR REPLACE FUNCTION CiutatsPais (nomPais IN VARCHAR2)
RETURN VARCHAR2 AS
    v_ciutat ciutats.nom % TYPE;
    v_resposta VARCHAR2(1000) := '';
    CURSOR cursorCiutats IS
        SELECT DISTINCT c.nom AS ciutat
        FROM paisos p
        LEFT JOIN ciutats c ON codiPais = p.codi
        WHERE p.nom = nomPais;

BEGIN 
    OPEN cursorCiutats;
    FETCH cursorCiutats INTO v_ciutat;
    WHILE cursorCiutats%FOUND LOOP 
        v_resposta := v_resposta || v_ciutat || ',';
        FETCH cursorCiutats INTO v_ciutat;
    END LOOP;
    CLOSE cursorCiutats;

    v_resposta := RTRIM(v_resposta, ',');
    IF v_resposta  IS NULL THEN
        v_resposta := '(No trobat)';
    END IF;
    
    RETURN v_resposta;
END CiutatsPais;

-- Prova

BEGIN
    DBMS_OUTPUT.PUT_LINE(CiutatsPais('China'));
END;
