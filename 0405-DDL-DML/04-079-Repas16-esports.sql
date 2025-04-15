-- Dadas estas tablas y estos datos de ejemplo:

CREATE TABLE tipos_deportes (
    codigo VARCHAR(5) PRIMARY KEY,
    nombre VARCHAR(40)
);

CREATE TABLE deportes (
    codigo VARCHAR(5) PRIMARY KEY,
    nombre VARCHAR(40),
    codigo_tipo VARCHAR(5)
);

CREATE TABLE deportistas (
    codigo VARCHAR(8) PRIMARY KEY,
    nombre VARCHAR(60),
    edad NUMERIC(3),
    codigo_deporte VARCHAR(5)
);


INSERT INTO tipos_deportes VALUES ('IND', 'Individual');
INSERT INTO tipos_deportes VALUES ('EQP', 'Equipo');
INSERT INTO tipos_deportes VALUES ('OUT', 'Outdoor');
INSERT INTO tipos_deportes VALUES ('NDO', 'Indoor');

INSERT INTO deportes VALUES ('FB', 'Fútbol', 'EQP');
INSERT INTO deportes VALUES ('BA', 'Baloncesto', 'EQP');
INSERT INTO deportes VALUES ('TE', 'Tenis', 'IND');
INSERT INTO deportes VALUES ('NA', 'Natación', 'NDO');
INSERT INTO deportes VALUES ('AT', 'Atletismo', 'OUT');
INSERT INTO deportes VALUES ('VO', 'Voleibol', 'EQP');
INSERT INTO deportes VALUES ('LA', 'Lacrosse', 'NDO');

INSERT INTO deportistas VALUES ('CR7', 'Cristiano Ronaldo', 40, 'FB');
INSERT INTO deportistas VALUES ('MJ23', 'Michael Jordan', 62, 'BA');
INSERT INTO deportistas VALUES ('LJ', 'LeBron James', 40, 'BA');
INSERT INTO deportistas VALUES ('RF', 'Roger Federer', 43, 'TE');
INSERT INTO deportistas VALUES ('MH', 'Martina Hingis', 44, 'TE');
INSERT INTO deportistas VALUES ('PN', 'Michael Phelps', 39, 'NA');
INSERT INTO deportistas VALUES ('UB', 'Usain Bolt', 38, 'AT');

-- Crea la siguientes consultas en SQL:

-- 1.- Muestra el nombre de todos los deportistas, junto con el nombre 
-- del deporte que practica cada uno de ellos y con el nombre del tipo de 
-- deporte. Usa los alias "persona", "deporte" y "tipo" para los campos 
-- resultantes, y los alias "d", "dp" y "td" para las tablas deportistas, 
-- deportes, tipos_deportes.

    SELECT d.nombre AS persona, dp.nombre AS deporte, 
        td.nombre AS tipo
    FROM deportistas d
    JOIN deportes dp ON d.codigo_deporte = dp.codigo
    JOIN tipos_deportes td ON dp.codigo_tipo = td.codigo;


-- 2. Muestra el nombre de los deportes que son de tipo "Equipo" o de 
-- tipo "Indoor", de 2 formas distintas. Puedes usar los códigos de los 
-- tipos de deporte, en vez de su nombre.

    -- Forma 1, OR
    SELECT nombre
    FROM deportes
    WHERE codigo_tipo = 'EQP' OR codigo_tipo = 'NDO';

    -- Forma 2, IN
    SELECT nombre
    FROM deportes
    WHERE codigo_tipo IN ('EQP', 'NDO');


-- 3. Muestra el nombre de los deportistas que no practican deportes de 
-- tipo "Equipo", ordenado alfabéticamente.

    SELECT d.nombre
    FROM deportistas d
    JOIN deportes dp ON d.codigo_deporte = dp.codigo
    JOIN tipos_deportes td ON dp.codigo_tipo = td.codigo
    WHERE td.nombre <> 'Equipo'
    ORDER BY d.nombre;


-- 4. Muestra el nombre y tipo de los deportes que no tienen 
-- deportistas asignados (usando IN o NOT IN).

    SELECT dp.nombre, td.nombre AS tipo
    FROM deportes dp
    JOIN tipos_deportes td ON dp.codigo_tipo = td.codigo
    WHERE dp.codigo NOT IN (SELECT codigo_deporte FROM deportistas);


-- 5. Modifica el tipo de deporte llamado "Lacrosse", para que pase a ser 
-- un deporte de "Equipo".

    -- Forma "con trampa"
    UPDATE deportes
    SET codigo_tipo = 'EQP'
    WHERE nombre = 'Lacrosse';
    
    -- Forma "buena"
    UPDATE deportes
    SET codigo_tipo = 
    (
        SELECT codigo 
        FROM tipos_deportes
        WHERE nombre = 'Equipo'
    )
    WHERE nombre = 'Lacrosse';


-- 6. Elimina el deporte con código "HK" de la base de datos, si existe.

    DELETE FROM deportes
    WHERE codigo = 'HK';


-- 7. Muestra el nombre de los deportistas cuyo nombre contiene "Bolt", 
-- de dos formas distintas: primero usando comodines y luego usando 
-- posición de subcadenas.

    -- Usando comodines
    SELECT nombre
    FROM deportistas
    WHERE nombre LIKE '%Bolt%';

    -- Usando posición de subcadenas
    SELECT nombre
    FROM deportistas
    WHERE INSTR(nombre,'Bolt') > 0;


-- 8. Muestra el nombre de cada tipo de deporte junto con la cantidad 
-- de deportes (quizás ninguno) que pertenecen a ese tipo.

    SELECT td.nombre, COUNT(dp.codigo) AS cantidad_deportes
    FROM tipos_deportes td
    LEFT JOIN deportes dp ON td.codigo = dp.codigo_tipo
    GROUP BY td.nombre;


-- 9. Muestra el nombre de los deportes que tienen más de dos 
-- deportistas asignados.

    SELECT dp.nombre, COUNT(d.codigo)
    FROM deportes dp
    JOIN deportistas d ON dp.codigo = d.codigo_deporte
    GROUP BY dp.nombre
    HAVING COUNT(d.codigo) > 2;


-- 10. Muestra el nombre del deporte (o deportes) más practicados por 
-- los deportistas de nuestra base de datos, usando FETCH.

    SELECT dp.nombre
    FROM deportes dp
    JOIN deportistas d ON dp.codigo = d.codigo_deporte
    GROUP BY dp.nombre
    ORDER BY COUNT(d.codigo) DESC
    FETCH FIRST 1 ROWS WITH TIES;


-- 11. Muestra el nombre del deporte (o deportes) más practicados por 
-- los deportistas de nuestra base de datos, usando una subconsulta 
-- y MAX.

    SELECT dp.nombre
    FROM deportes dp
    JOIN deportistas d ON dp.codigo = d.codigo_deporte
    GROUP BY dp.nombre
    HAVING COUNT(d.codigo) = (
        SELECT MAX(cantidad)
        FROM (
            SELECT COUNT(d.codigo) AS cantidad
            FROM deportes dp
            JOIN deportistas d ON dp.codigo = d.codigo_deporte
            GROUP BY dp.nombre
        ) AS subconsulta
    );


-- 12. Muestra el nombre del deportista (o deportistas) más mayor de la 
-- base de datos, usando una subconsulta y ALL o ANY.

    SELECT nombre
    FROM deportistas
    WHERE edad >= ALL (
        SELECT edad
        FROM deportistas
    );


-- 13. Muestra el nombre del deportista (o deportistas) más mayor de la 
-- base de datos, usando una subconsulta y EXISTS o NOT EXISTS.

    SELECT d.nombre
    FROM deportistas d
    WHERE NOT EXISTS (
        SELECT 1
        FROM deportistas d2
        WHERE d2.edad > d.edad
    );


-- 14. Modifica la tabla tipos_deportes para añadir una restricción que 
-- exija que el nombre tenga entre 3 y 40 caracteres.

    ALTER TABLE tipos_deportes
    ADD CONSTRAINT chk_nombre_length 
        CHECK (LENGTH(nombre) BETWEEN 3 AND 40);


-- 15. Añade un nuevo deporte con código "TK", nombre "Taekwondo" y 
-- cuyo tipo no conocemos (sin usar NULL).

    INSERT INTO deportes (codigo, nombre)
    VALUES ('TK', 'Taekwondo');


-- 16. Muestra las cinco primeras letras de los nombres de los deportes 
-- de los que no conocemos ningún deportista, usando IN o NOT IN.

    SELECT SUBSTR(dp.nombre, 1, 5)
    FROM deportes dp
    WHERE dp.codigo NOT IN 
    (
        SELECT codigo_deporte FROM deportistas
    );


-- 17. Muestra los nombres de los deportes de los que no conocemos ningún 
-- deportista, usando EXISTS o NOT EXISTS. Los nombres deben aparecer 
-- alineados a la derecha, con una anchura de 12 caracteres.

    SELECT LPAD(dp.nombre, 12)
    FROM deportes dp
    WHERE NOT EXISTS (
        SELECT 1
        FROM deportistas d
        WHERE d.codigo_deporte = dp.codigo
    );


-- 18. Crea una vista v_deportes_practicados que muestre el nombre de 
-- cada deporte, el nombre de cada deportista que lo practica (si existe 
-- alguien) y la edad de ese deportista (ídem).

    CREATE VIEW v_deportes_practicados AS
    SELECT dp.nombre AS deporte, d.nombre AS deportista, d.edad
    FROM deportes dp
    LEFT JOIN deportistas d ON dp.codigo = d.codigo_deporte;


-- 19. Usando esa vista, muestra el nombre de cada deporte, en 
-- mayúsculas, la cantidad de deportistas que lo practican (quizá nadie) 
-- y la edad media de sus deportistas, redondeada a dos cifras decimales.

    SELECT UPPER(deporte) AS deporte, 
        COUNT(deportista) AS cantidad_deportistas, 
        ROUND(AVG(edad), 2) AS edad_media
    FROM v_deportes_practicados
    GROUP BY deporte;


-- 20. Crea una tabla "partido_tenis", con atributos codigo_jugador1, 
-- codigo_jugador2, fecha. La clave estará formada por los dos primeros 
-- campos, que además actuarán como clave ajena a la tabla "deportistas". 
-- Usa sintaxis de Oracle.

    CREATE TABLE partido_tenis (
        codigo_jugador1 VARCHAR2(8),
        codigo_jugador2 VARCHAR2(8),
        fecha DATE,
        CONSTRAINT ptenis_pk PRIMARY KEY (codigo_jugador1, codigo_jugador2),
        CONSTRAINT fk_ptenis_jug1 FOREIGN KEY (codigo_jugador1) REFERENCES deportistas(codigo),
        CONSTRAINT fk_ptenis_jug2 FOREIGN KEY (codigo_jugador2) REFERENCES deportistas(codigo)
    );


-- 21. Añade un partido de tenis entre Roger Federer y Martina Hingis, 
-- con fecha 14 de abril de 2025. Usa sintaxis de Oracle.

    -- Forma "tramposa", con los códigos
    INSERT INTO partido_tenis (codigo_jugador1, codigo_jugador2, fecha)
    VALUES ('RF', 'MH', TO_DATE('2025-04-14', 'YYYY-MM-DD'));
    
    -- Forma correcta:
    INSERT INTO partido_tenis (codigo_jugador1, codigo_jugador2, fecha)
    VALUES (
        (SELECT codigo FROM deportistas WHERE nombre = 'Roger Federer'),
        (SELECT codigo FROM deportistas WHERE nombre = 'Martina Hingis'),
        TO_DATE('2025-04-14', 'YYYY-MM-DD')
    );



-- 22. Vacía el contenido de la tabla deportistas, conservando su 
-- estructura. No debes usar DELETE.

    TRUNCATE TABLE deportistas;


-- 23. Muestra el nombre de los deportistas cuyo código tenga 2 letras, 
-- de 2 formas distintas: usando comodines y usando la función que 
-- devuelve la longitud de una cadena.

    -- Usando comodines
    SELECT nombre
    FROM deportistas
    WHERE codigo LIKE '__';

    -- Usando la función de longitud
    SELECT nombre
    FROM deportistas
    WHERE LENGTH(codigo) = 2;


-- 24. Crea un índice para el nombre de los deportistas.

    CREATE INDEX idx_nombre_deportistas ON deportistas(nombre);


-- 25. Muestra el nombre de todos los deportes y el nombre de todos los 
-- deportistas, relacionándolos cuando corresponda. Si algún deporte no 
-- tiene jugadores, deberá aparecer "[Sin jugadores]". Si algún deportista 
-- no está asociado a ningún deporte, aparecerá "[Sin deporte]".


    SELECT NVL(dp.nombre, '[Sin deporte]') AS deporte, 
        NVL(d.nombre, '[Sin jugadores]') AS deportista
    FROM deportes dp
    FULL JOIN deportistas d ON dp.codigo = d.codigo_deporte;

