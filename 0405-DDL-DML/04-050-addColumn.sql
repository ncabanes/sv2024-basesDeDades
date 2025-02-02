-- Afig un camp "nomValencia" (màxim de 30 lletres) a la taula "ciutats2".

-- Oracle

ALTER TABLE ciutats2 ADD (nomValencia VARCHAR2(30));

-- SQLite

ALTER TABLE ciutats2 ADD COLUMN nomValencia VARCHAR2(30);
ALTER TABLE ciutats2 ADD nomValencia VARCHAR2(30);

-- Comprovació

SELECT * FROM ciutats2;
