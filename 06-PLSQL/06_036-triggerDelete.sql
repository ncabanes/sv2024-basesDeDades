-- 6.36. Crea una taula de còpia de seguretat per a les ciutats, a la 
-- qual s'enviaran les ciutats que s'esborren. Comprova que es comporta 
-- correctament.

CREATE TABLE ciutatsEsborrades (
    codi NUMBER(5),
    nom VARCHAR2(30),
    poblacio NUMBER(10),
    codiPais CHAR(2)
);

CREATE OR REPLACE TRIGGER triggerCiutatEsborrada 
AFTER DELETE ON ciutats
FOR EACH ROW
BEGIN
    INSERT INTO ciutatsEsborrades 
    VALUES(:OLD.codi, :OLD.nom, 
        :OLD.poblacio, :OLD.codiPais);
END;

DELETE FROM ciutats WHERE codi = 100;

SELECT * FROM ciutatsEsborrades;
