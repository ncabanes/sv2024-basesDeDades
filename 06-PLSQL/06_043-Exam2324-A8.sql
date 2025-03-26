-- 8.- Ens han demanat un "trigger" que els permeta introduir informació 
-- de manera més ràpida: si el concepte és "d" i l'import és nul, es 
-- guardarà "Derrama" com a concepte i 100 com a import.

CREATE OR REPLACE TRIGGER tRebutRapid
BEFORE INSERT ON rebuts
FOR EACH ROW
BEGIN
    IF :NEW.concepte = 'd' AND  :NEW.import IS NULL THEN
        :NEW.concepte := 'Derrama';
        :NEW.import := 100;
    END IF;
END;

INSERT INTO rebuts VALUES (6, 2024, 1, 1, 'd', NULL, NULL);

SELECT * FROM rebuts WHERE numMes = 6;

