-- Crea una funció anomenada "SumaDePoblacionsDePais", que retorne la suma de 
-- les poblacions de les ciutats que pertanyen al país el nom del qual 
-- s'indique com a paràmetre, o -1 si eixe país no existix.

-- Versió amb error: EXCEPTION, NO DATA FOUND

-- Provar

SELECT codi
FROM paisos
WHERE nom = 'China';

SELECT SUM(poblacio)
FROM ciutats
WHERE codiPais = 'CN';

-- Funció

CREATE OR REPLACE FUNCTION SumaDePoblacionsDePais (nomPais IN VARCHAR2)
RETURN NUMBER AS
    cpais VARCHAR2(100);
    suma NUMBER;
BEGIN 
    SELECT codi
    INTO cpais
    FROM paisos
    WHERE nom = nomPais;

    IF cpais IS NULL THEN
        RETURN -1;
    END IF;

    SELECT SUM(poblacio)
    INTO suma
    FROM ciutats
    WHERE codiPais = cpais;

    RETURN suma;
END SumaDePoblacionsDePais;

--

BEGIN
    dbms_output.put_line('China: ' || SumaDePoblacionsDePais('China'));
    dbms_output.put_line('España: ' || SumaDePoblacionsDePais('España'));
    dbms_output.put_line('Espana: ' || SumaDePoblacionsDePais('Espana'));
END;



