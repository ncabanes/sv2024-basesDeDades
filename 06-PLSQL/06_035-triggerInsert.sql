-- 6.35. Crea un trigger que anote "Sense revisar" en el nom d'un país,
-- en el cas que no s'haja indicat aquest nom 

CREATE OR REPLACE TRIGGER nomNoNul
BEFORE INSERT ON paisos
FOR EACH ROW
BEGIN
    IF :NEW.nom IS NULL
    THEN
        :NEW.nom := 'Sense revisar';
    END IF;
END;

INSERT INTO paisos(codi,nom) VALUES ('MV',NULL);
INSERT INTO paisos(codi) VALUES ('NM');

SELECT * FROM paisos;
