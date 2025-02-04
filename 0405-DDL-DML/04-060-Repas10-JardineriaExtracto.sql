-- Extracto (retocado) de:
-- https://gist.githubusercontent.com/josejuansanchez/c408725e848afd64dd9a20ab37fba8c9/raw/94f317604fda43e5dc7b5e859be82307c62c4488/jardineria.sql

CREATE TABLE oficina (
  codigo_oficina VARCHAR(10) NOT NULL,
  ciudad VARCHAR(30) NOT NULL,
  pais VARCHAR(20) NOT NULL,
  valoracion NUMERIC(3,1),
  PRIMARY KEY (codigo_oficina)
);

CREATE TABLE empleado (
  codigo_empleado NUMERIC(6) NOT NULL,
  nombre VARCHAR(30) NOT NULL,
  apellido1 VARCHAR(30) NOT NULL,
  codigo_oficina VARCHAR(10) NOT NULL,
  codigo_jefe NUMERIC(6) DEFAULT NULL,
  puesto VARCHAR(20) DEFAULT NULL,
  PRIMARY KEY (codigo_empleado),
  FOREIGN KEY (codigo_oficina) REFERENCES oficina (codigo_oficina),
  FOREIGN KEY (codigo_jefe) REFERENCES empleado (codigo_empleado)
);

-- Datos
INSERT INTO oficina VALUES ('BCN-ES','Barcelona','España', 7.4);
INSERT INTO oficina VALUES ('BOS-USA','Boston','EEUU', 7.7);
INSERT INTO oficina VALUES ('LON-UK','Londres','Inglaterra', 8.2);
INSERT INTO oficina VALUES ('MAD-ES','Madrid','España', 9.8);
INSERT INTO oficina VALUES ('PAR-FR','Paris','Francia', 6.4);
INSERT INTO oficina VALUES ('SFC-USA','San Francisco','EEUU', 8.9);
INSERT INTO oficina VALUES ('SYD-AU','Sydney','Australia', 8.7);
INSERT INTO oficina VALUES ('TAL-ES','Talavera de la Reina','España', 8.4);
INSERT INTO oficina VALUES ('TOK-JP','Tokyo','Japón', 7.7);

INSERT INTO empleado VALUES (1,'Marcos','Magaña','TAL-ES',NULL,'Director Gen.');
INSERT INTO empleado VALUES (2,'Ruben','López','TAL-ES',1,'Subdirector Mark.');
INSERT INTO empleado VALUES (3,'Alberto','Soria','TAL-ES',2,'Subdirector Ven.');
INSERT INTO empleado VALUES (4,'Maria','Solís','TAL-ES',2,'Secretaria');
INSERT INTO empleado VALUES (5,'Felipe','Rosas','TAL-ES',3,'Representante');
INSERT INTO empleado VALUES (6,'Juan Carlos','Martínez','TAL-ES',3,'Representante');
INSERT INTO empleado VALUES (7,'Carlos','Soria','MAD-ES',3,'Director');
INSERT INTO empleado VALUES (8,'Mariano','López','MAD-ES',7,'Representante');
INSERT INTO empleado VALUES (9,'Lucio','Campoamor','MAD-ES',7,'Representante');
INSERT INTO empleado VALUES (10,'Hilario','Rodriguez','MAD-ES',7,'Representante');
INSERT INTO empleado VALUES (11,'Emmanuel','Magaña','BCN-ES',3,'Director');
INSERT INTO empleado VALUES (12,'José Manuel','Martinez','BCN-ES',11,'Representante');
INSERT INTO empleado VALUES (13,'David','Palma','BCN-ES',11,'Representante');
INSERT INTO empleado VALUES (14,'Oscar','Palma','BCN-ES',11,'Representante');
INSERT INTO empleado VALUES (15,'Francois','Fignon','PAR-FR',3,'Director');
INSERT INTO empleado VALUES (16,'Lionel','Narvaez','PAR-FR',15,'Representante');
INSERT INTO empleado VALUES (17,'Laurent','Serra','PAR-FR',15,'Representante');
INSERT INTO empleado VALUES (18,'Michael','Sydney','SFC-USA',3,'Director');
INSERT INTO empleado VALUES (19,'Walter Santiago','Castillo','SFC-USA',18,'Representante');
INSERT INTO empleado VALUES (20,'Hilary','Washington','BOS-USA',3,'Director');
INSERT INTO empleado VALUES (21,'Marcus','Paxton','BOS-USA',20,'Representante');
