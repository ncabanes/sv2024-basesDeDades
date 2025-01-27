CREATE TABLE city (
  ID NUMBER(5),
  Name VARCHAR2(35) NOT NULL,
  CountryCode VARCHAR2(3),
  District VARCHAR2(20),
  Population NUMBER(12),
  PRIMARY KEY (ID)
);

INSERT INTO city VALUES (1,'Kabul','AFG','Kabol',1780000);
-- ...

-- Afegim Sant Vicent i ho esborrem

INSERT INTO city VALUES (4080,'Sant Vicent del Raspeig','ESP','Alicante',58000);

SELECT * 
FROM city
WHERE Name = 'Sant Vicent del Raspeig';

DELETE FROM city
WHERE Name = 'Sant Vicent del Raspeig';

-- Repetim consulta per a comprovar que ja no existix

SELECT * 
FROM city
WHERE Name = 'Sant Vicent del Raspeig';
