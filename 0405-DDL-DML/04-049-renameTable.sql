-- Crea una còpia parcial (4 camps) de la taula de ciutats, 
-- a "ciutatsCopia". Canvia-la de nom a "ciutats2".


CREATE TABLE city (
  ID NUMBER(5),
  Name VARCHAR2(35) NOT NULL,
  CountryCode VARCHAR2(3),
  District VARCHAR2(20),
  Population NUMBER(12),
  PRIMARY KEY (ID)
);

INSERT INTO city VALUES (1,'Kabul','AFG','Kabol',1780000);
INSERT INTO city VALUES (2,'Qandahar','AFG','Qandahar',237500);
-- ...

-- ---------------------

CREATE TABLE ciutatsCopia AS
    SELECT id, name, district, population
    FROM city;

ALTER TABLE ciutatsCopia RENAME TO ciutats2;

SELECT * FROM ciutats2;
