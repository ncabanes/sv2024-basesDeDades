-- Crea una funció anomenada "SumaDePoblacionsDePais", que retorne la suma de 
-- les poblacions de les ciutats que pertanyen al país el nom del qual 
-- s'indique com a paràmetre, o -1 si eixe país no existix.

-- Prova

SELECT COUNT(*) 
FROM paisos
WHERE nom = 'Espana';

SELECT SUM(poblacio)
FROM ciutats JOIN paisos
    ON ciutats.codiPais = paisos.Codi
WHERE paisos.nom = 'Espana';

-- Funció

CREATE OR REPLACE FUNCTION SumaDePoblacionsDePais (nomPais IN VARCHAR2)
RETURN NUMBER AS
    quantitat VARCHAR2(100);
    suma NUMBER;
BEGIN 
    SELECT COUNT(*) 
    INTO quantitat
    FROM paisos
    WHERE nom = nomPais;

    IF quantitat = 0 THEN
        RETURN -1;
    END IF;

    SELECT SUM(ciutats.poblacio)
    INTO suma
    FROM ciutats JOIN paisos
        ON ciutats.codiPais = paisos.Codi
    WHERE paisos.nom = nomPais;
    
    IF suma IS NULL THEN
        RETURN -1;
    ELSE
        RETURN suma;
    END IF;
END SumaDePoblacionsDePais;

--

BEGIN
    dbms_output.put_line('China: ' || SumaDePoblacionsDePais('China'));
    dbms_output.put_line('España: ' || SumaDePoblacionsDePais('España'));
    dbms_output.put_line('Espana: ' || SumaDePoblacionsDePais('Espana'));
END;



