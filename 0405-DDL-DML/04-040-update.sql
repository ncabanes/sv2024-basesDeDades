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
INSERT INTO country VALUES ('ZWE','Zimbabwe','Africa','Eastern Africa',390757.00,1980,11669000,37.8,5951.00,8670.00,'Zimbabwe','Republic','Robert G. Mugabe',4068,'ZW');

-- Afegim Sant Vicent i ho modifiquem

INSERT INTO city VALUES (4080,'Sant Vicent del Raspeig','ESP','Alicante',58000);

SELECT * 
FROM city
WHERE Name = 'Sant Vicent del Raspeig';

UPDATE city
SET Population = Population + 10000
WHERE Name = 'Sant Vicent del Raspeig';

--Repetim consulta per a comprovar que s'ha sumat la població

SELECT * 
FROM city
WHERE Name = 'Sant Vicent del Raspeig';
