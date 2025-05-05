-- Tabla de canciones (una única tabla, con artista y album)

create table canciones(
    id number(5),
    titulo varchar2(100),
    artista varchar2(100),
    album varchar2(100),
    fechaPublic date,
    duracionSeg number(6),
    constraint pk_canciones primary key (id)
);

-- Datos de ejemplo

insert into canciones values(1, 'cancion1', 'artista1', 'album1', 
    TO_DATE('2000,1,20', 'yyyy,mm,dd'), 190);
insert into canciones values(2, 'cancion2', 'artista2', 'album1', 
    TO_DATE('2001,3,2', 'yyyy,mm,dd'), 195);
insert into canciones values(3, 'cancion3', 'artista3', 'album2', 
    TO_DATE('2004,6,1', 'yyyy,mm,dd'), 252);
insert into canciones values(4, 'cancion4', 'artista4', 'album3', 
    TO_DATE('2003,9,15', 'yyyy,mm,dd'), 181);
insert into canciones values(5, 'cancion5', 'artista5', 'album3', 
    TO_DATE('2000,3,22', 'yyyy,mm,dd'), 216);

insert into canciones (id, titulo, artista, album, fechapublic, duracionseg) 
values (11, 'cancion 1', 'artista urbano 1', 'album 1', to_date('01/07/2024', 'dd/mm/yyyy'), 210);

insert into canciones (id, titulo, artista, album, fechapublic, duracionseg) 
values (12, 'cancion 2', 'artista urbano 2', 'album 2', to_date('03/07/2024', 'dd/mm/yyyy'), 180);

insert into canciones (id, titulo, artista, album, fechapublic, duracionseg) 
values (13, 'cancion 3', 'artista urbano 1', 'album 1', to_date('01/07/2024', 'dd/mm/yyyy'), 200);

insert into canciones (id, titulo, artista, album, fechapublic, duracionseg) 
values (14, 'cancion 1', 'artista urbano 3', 'album 3', to_date('01/07/2024', 'dd/mm/yyyy'), 220);

insert into canciones (id, titulo, artista, album, fechapublic, duracionseg) 
values (15, 'cancion 2', 'artista urbano 3', 'album 3', to_date('01/07/2024', 'dd/mm/yyyy'), 190);

INSERT INTO canciones VALUES (21,'Otra cancion 1', 'artista1', 'Grupo1', to_date('10-25-2003', 'mm-dd-yyyy'), 200);
INSERT INTO canciones VALUES (22,'Otra cancion 2', 'artista1', 'Grupo2', to_date('10-25-2003', 'mm-dd-yyyy'), 201);
INSERT INTO canciones VALUES (23,'Otra cancion 3', 'artista3', 'Grupo3', to_date('10-25-2003', 'mm-dd-yyyy'), 202);
INSERT INTO canciones VALUES (24,'Otra cancion 4', 'artista3', 'Grupo4', to_date('10-25-2003', 'mm-dd-yyyy'), 203);
INSERT INTO canciones VALUES (25,'Otra cancion 5', 'artista1', 'Grupo5', to_date('10-25-2003', 'mm-dd-yyyy'), 204);


-- Comprobación mínima:

SELECT COUNT(*) FROM canciones;


-- Consulta 1: Nombre de cada artista y cantidad de canciones suyas,
-- ordenado del artista del que más canciones tenemos al que menos.

SELECT artista, COUNT(*) AS cantidad
FROM canciones
GROUP BY artista
ORDER BY cantidad DESC;


-- Consulta 2: Artista, título y duración para las canciones
-- que duran más que la media.

SELECT artista, titulo, duracionSeg
FROM canciones
WHERE duracionSeg > 
(
    SELECT AVG(duracionSeg) FROM canciones
);


-- 3: Crea una función que convierta un número como "216" a una
-- cadena de texto como "03:36".

CREATE OR REPLACE FUNCTION horaBonita(
    segundosTotales IN NUMBER
)
RETURN VARCHAR
AS
    minutos canciones.duracionSeg%TYPE;
    segundos canciones.duracionSeg%TYPE;   
    respuesta VARCHAR2(6)  := '';
    
BEGIN
    minutos := TRUNC( segundosTotales / 60 );
    segundos := TRUNC( segundosTotales MOD 60 );
    
    IF minutos < 10 THEN
        respuesta := respuesta || '0';
    END IF;
    respuesta := respuesta || TO_CHAR(minutos);
    
    respuesta := respuesta || ':';

    IF segundos < 10 THEN
        respuesta := respuesta || '0';
    END IF;
    respuesta := respuesta || TO_CHAR(segundos);

    RETURN respuesta;
END horaBonita;

BEGIN
    dbms_output.put_line( horaBonita(216) );
END;


-- Consulta 4: Artista, título y duración para las canciones
-- que duran más que la media, usando esa función que has creado.

SELECT artista, titulo, horaBonita(duracionSeg)
FROM canciones
WHERE duracionSeg > 
(
    SELECT AVG(duracionSeg) FROM canciones
);


-- Consulta 5: Artista y cantidad de canciones, para los artistas
-- que tienen más canciones que la media.

-- 5.1. Artistas y cantidad de canciones

SELECT artista, COUNT(*) AS cantidad
FROM canciones
GROUP BY artista
ORDER BY cantidad DESC;

-- 5.2. Media de cantidad de canciones

SELECT AVG(cantidad) FROM
(
    SELECT artista, COUNT(*) AS cantidad
    FROM canciones
    GROUP BY artista
    ORDER BY cantidad DESC
);


-- 5.3. Artistas por encima de la media de cantidad de canciones

SELECT artista, COUNT(*) AS cantidad
FROM canciones
GROUP BY artista
HAVING cantidad > 
(
    SELECT AVG(cantidad) FROM
    (
        SELECT artista, COUNT(*) AS cantidad
        FROM canciones
        GROUP BY artista
        ORDER BY cantidad DESC
    )
);
