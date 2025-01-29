-- Canvia de nom el camp "name" en "ciutats2" perquè 
-- passe a dir-se "nomAngles".

ALTER TABLE ciutats2 RENAME COLUMN name TO nomAngles;

SELECT * FROM ciutats2;
