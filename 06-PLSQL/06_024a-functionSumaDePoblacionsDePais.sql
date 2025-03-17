-- Crea una funció anomenada "SumaDePoblacionsDePais", que retorne la suma de 
-- les poblacions de les ciutats que pertanyen al país el nom del qual 
-- s'indique com a paràmetre, o -1 si eixe país no existix.

-- Prova

SELECT SUM(c.poblacion)
FROM ciudades c
JOIN paises p ON c.codigoPais = p.codigo
WHERE p.nombre = 'China';

SELECT SUM(c.poblacion)
FROM ciudades c
JOIN paises p ON c.codigoPais = p.codigo
WHERE p.nombre = 'Espana';


-- Funció

CREATE OR REPLACE FUNCTION SumaDePoblacionsDePais(pais_nom VARCHAR2)
RETURN NUMBER
IS
    suma_poblacions NUMBER;
BEGIN
    SELECT SUM(c.poblacion)
    INTO suma_poblacions
    FROM ciudades c
    JOIN paises p ON c.codigoPais = p.codigo
    WHERE p.nombre = pais_nom;

    IF suma_poblacions IS NULL THEN
        RETURN -1;
    ELSE
        RETURN suma_poblacions;
    END IF;
END SumaDePoblacionsDePais;

--

BEGIN
    dbms_output.put_line('China: ' || SumaDePoblacionsDePais('China'));
    dbms_output.put_line('España: ' || SumaDePoblacionsDePais('España'));
    dbms_output.put_line('Espana: ' || SumaDePoblacionsDePais('Espana'));
END;
