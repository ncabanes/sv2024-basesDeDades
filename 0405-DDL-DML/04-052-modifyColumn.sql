-- Amplia la grandària del nom valencià de 30 a 40 lletres

-- Oracle

ALTER TABLE ciutats2 MODIFY (nomValencia VARCHAR2(40));

-- SQLite: no permet MODIFY

-- Comprovació

SELECT * FROM ciutats2;
