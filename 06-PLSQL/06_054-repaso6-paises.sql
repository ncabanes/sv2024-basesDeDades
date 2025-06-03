-- Repaso 6 (opcional)

-- Vamos a partir de la base de datos de ciudades del mundo, que ya 
-- tienes compartida al final de los temas 3 y 4, y un fragmento de 
-- cuyo contenido (que puedes utilizar para pruebas como alternativa 
-- más breve) es el siguiente:

CREATE TABLE city (
  ID NUMBER(5),
  Name VARCHAR2(35) NOT NULL,
  CountryCode VARCHAR2(3),
  District VARCHAR2(20),
  Population NUMBER(12),
  PRIMARY KEY (ID),
  CONSTRAINT city_ibfk_1 FOREIGN KEY (CountryCode) REFERENCES country (Code)
);

INSERT INTO city VALUES (1,'Kabul','AFG','Kabol',1780000);
INSERT INTO city VALUES (2,'Qandahar','AFG','Qandahar',237500);
INSERT INTO city VALUES (3,'Herat','AFG','Herat',186800);
INSERT INTO city VALUES (4,'Mazar-e-Sharif','AFG','Balkh',127800);
INSERT INTO city VALUES (5,'Amsterdam','NLD','Noord-Holland',731200);
INSERT INTO city VALUES (6,'Rotterdam','NLD','Zuid-Holland',593321);
INSERT INTO city VALUES (7,'Haag','NLD','Zuid-Holland',440900);
INSERT INTO city VALUES (8,'Utrecht','NLD','Utrecht',234323);
INSERT INTO city VALUES (9,'Eindhoven','NLD','Noord-Brabant',201843);
INSERT INTO city VALUES (10,'Tilburg','NLD','Noord-Brabant',193238);
INSERT INTO city VALUES (12,'Breda','NLD','Noord-Brabant',160398);
INSERT INTO city VALUES (13,'Apeldoorn','NLD','Gelderland',153491);
INSERT INTO city VALUES (14,'Nijmegen','NLD','Gelderland',152463);
INSERT INTO city VALUES (15,'Enschede','NLD','Overijssel',149544);
INSERT INTO city VALUES (16,'Haarlem','NLD','Noord-Holland',148772);
INSERT INTO city VALUES (18,'Arnhem','NLD','Gelderland',138020);
INSERT INTO city VALUES (19,'Zaanstad','NLD','Noord-Holland',135621);
INSERT INTO city VALUES (20,'´s-Hertogenbosch','NLD','Noord-Brabant',129170);
INSERT INTO city VALUES (21,'Amersfoort','NLD','Utrecht',126270);
INSERT INTO city VALUES (22,'Maastricht','NLD','Limburg',122087);
INSERT INTO city VALUES (23,'Dordrecht','NLD','Zuid-Holland',119811);
INSERT INTO city VALUES (24,'Leiden','NLD','Zuid-Holland',117196);
INSERT INTO city VALUES (25,'Haarlemmermeer','NLD','Noord-Holland',110722);
INSERT INTO city VALUES (26,'Zoetermeer','NLD','Zuid-Holland',110214);
INSERT INTO city VALUES (29,'Ede','NLD','Gelderland',101574);
INSERT INTO city VALUES (30,'Delft','NLD','Zuid-Holland',95268);
INSERT INTO city VALUES (194,'La Paz','BOL','La Paz',758141);
INSERT INTO city VALUES (195,'El Alto','BOL','La Paz',534466);
INSERT INTO city VALUES (196,'Cochabamba','BOL','Cochabamba',482800);
INSERT INTO city VALUES (197,'Oruro','BOL','Oruro',223553);

-- 1. Crea un procedimiento "MostrarCiudadesDePais(codPais)" que, a partir de un código de país como "BOL", muestre el nombre de cada una de sus ciudades, ordenadas alfabéticamente, junto a la población de esa ciudad. Debes emplear un cursor WHILE. Si no encuentra ninguna ciudad, deberá escribir "No se han encontrado ciudades". Pruébalo con un bloque anónimo.


-- 2. Crea un procedimiento "MostrarCiudadesDeRegion(nomRegion)" que, a partir de un nombre de región, como "La Paz", muestre el nombre de cada una de sus ciudades, ordenadas alfabéticamente, junto a la población de esa ciudad. Debes emplear un cursor LOOP. Según la cantidad de ciudades encontradas, deberás escribir también a continuación el mensaje: "Ninguna ciudad encontrada", "Una ciudad encontrada" o "Varias ciudades encontradas", empleando una orden CASE. Pruébalo con EXECUTE.


-- 3. Crea una función "PoblacionCiudadesDePais(codPais)" que, a partir de un código de país como "BOL", devuelva la suma de las poblaciones de las ciudades que nos constan de ese país. Debes emplear un cursor que recorrerás con un bucle FOR, y probar la función con un bloque anónimo.


-- 4. Crea una función "PoblacionCiudadesDeRegion(nomRegion)" que, a partir de un nombre de región, como "La Paz", devuelva la suma de las poblaciones de las ciudades que nos constan de ese país. Debes emplear un bucle FOR sin declarar un cursor de forma explícita, y probar la función con un SELECT.


-- 5. Crea un trigger "ValidarPoblacion", que no permita ciudades con población negativa. Si se intenta añadir una ciudad con población negativa, guardará esa población multiplicada por -1.
