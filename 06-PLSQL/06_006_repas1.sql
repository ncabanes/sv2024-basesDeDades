-- Repaso básico de PL/SQL: obtén el nombre del autor
-- cuyo código es LC y muéstralo

CREATE TABLE autores (
    codigo VARCHAR(8) PRIMARY KEY,
    nombre VARCHAR(60),
    anyoNacimiento NUMERIC(4),
    codigoPais VARCHAR(5)
);

INSERT INTO autores VALUES
('HG', 'Hermanos Grimm', 1785, 'DE'),
('HCA', 'Hans Christian Andersen', 1805, 'DK'),
('CP', 'Charles Perrault', 1628, 'FR'),
('JJ', 'Joseph Jacobs', 1854, 'GB'),
('OW', 'Oscar Wilde', 1854, 'IE'),
('RK', 'Rudyard Kipling', 1865, 'GB'),
('LC', 'Lewis Carroll', 1832, 'GB'),
('HHM', 'Héctor Hugh Munro', NULL, NULL),
('EAP', 'Edgar Allan Poe', 1809, 'US');

DECLARE
    v_nombre autores.nombre %TYPE;
BEGIN
    SELECT nombre
    INTO v_nombre
    FROM autores
    WHERE codigo = 'LC';
    
    dbms_output.put_line(v_nombre);
END;
