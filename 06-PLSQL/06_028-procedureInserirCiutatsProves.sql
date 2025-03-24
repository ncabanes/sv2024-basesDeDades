CREATE OR REPLACE PROCEDURE InserirCiutatsProves (codiInicial IN NUMBER, quantitat IN NUMBER) IS
BEGIN
    FOR i IN 0 .. quantitat - 1 LOOP
        INSERT INTO ciudades VALUES (codiInicial + i, 'Ciutat de prova ' || (codiInicial + i), NULL, NULL);
    END LOOP;
END InserirCiutatsProves;

BEGIN
    InserirCiutatsProves(100,10);
END;
