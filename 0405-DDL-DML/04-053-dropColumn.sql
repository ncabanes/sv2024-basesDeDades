-- En la taula ciutats2, elimina el camp del nom en anglés.

-- Oracle

ALTER TABLE ciutats2 DROP (nomAngles);

-- SQLite

ALTER TABLE ciutats2 DROP COLUMN nomAngles;
ALTER TABLE ciutats2 DROP nomAngles;

-- Comprovació

SELECT * FROM ciutats2;
