-- Amplia la grandària del nom valencià de 30 a 40 lletres

ALTER TABLE ciutats2 MODIFY (nomValencia VARCHAR2(40));

SELECT * FROM ciutats2;
