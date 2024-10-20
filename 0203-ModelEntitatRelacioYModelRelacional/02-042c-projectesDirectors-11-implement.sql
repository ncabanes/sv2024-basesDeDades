-- DIRECTOR(dni, nom)
-- C.P.: dni
-- 
-- PROJECTE(codi, denominació)
-- C.P.: codi
-- 
-- DIRIGEIX(dniDirector, codiProjecte)
-- C.P.: dniDirector
-- C.Alt.: codiProjecte
-- C.Ext.: dniDirector -> DIRECTOR
-- C.Ext.: codiProjecte -> PROJECTE

--Dayron y Gabriel

CREATE TABLE director(
    dni VARCHAR(8) PRIMARY KEY,
    nom VARCHAR(20)
);

INSERT INTO director VALUES('bg','Bill Gates');
INSERT INTO director VALUES('jb','Jeff Bezos');
INSERT INTO director VALUES('pa','Paul Allen');

CREATE TABLE projecte(
    codi VARCHAR(5) PRIMARY KEY, 
    denominacio VARCHAR(25)
);

INSERT INTO projecte VALUES('ms','Microsoft');
INSERT INTO projecte VALUES('amz','Amazon');

CREATE TABLE dirigeix(
    dniDirector varchar(8) PRIMARY KEY,
    codiProjecte varchar(5) UNIQUE NOT NULL,
    FOREIGN KEY(codiProjecte) REFERENCES projecte(codi), 
    FOREIGN KEY(dniDirector) REFERENCES director(dni)
);

INSERT INTO dirigeix VALUES('bg','ms');
INSERT INTO dirigeix VALUES('jb','amz');
INSERT INTO dirigeix VALUES('t','Tesla');

-- Hauria de fallar si tractem d'assignar més d'un director a un projecte 
-- i viceversa

INSERT INTO dirigeix VALUES('pa','ms');
INSERT INTO dirigeix VALUES('bg','t');

-- Mostrar dades

SELECT director.nom, projecte.denominacio
FROM director, projecte, dirigeix
WHERE dirigeix.dniDirector = director.dni
    AND dirigeix.codiProjecte = projecte.codi; 
