-- DIRECTOR(dni, nom)
-- C.P.: dni
-- 
-- PROJECTE(codi, denominació, dniDirector)
-- C.P.: codi
-- C.Alt.: dniDirector
-- C.Ext.: dniDirector -> DIRECTOR

-- Izan y Nicolás

CREATE TABLE director(dni VARCHAR(9) PRIMARY KEY, nom VARCHAR(30));

INSERT INTO director VALUES('bg','Bill Gates');
INSERT INTO director VALUES('jb','Jeff Bezos');
INSERT INTO director VALUES('pa','Paul Allen');

CREATE TABLE projecte(
    codi VARCHAR(5) PRIMARY KEY, 
    denominacio VARCHAR(30), 
    dni_director VARCHAR(9) UNIQUE NOT NULL);

INSERT INTO projecte VALUES('ms','Microsoft', 'bg');
INSERT INTO projecte VALUES('amz','Amazon', 'jb');

SELECT denominacio, nom 
FROM projecte, director
WHERE projecte.dni_director = director.dni;

-- Tot el següent hauria de fallar:

INSERT INTO projecte VALUES('oai','OpenAI', NULL);
INSERT INTO projecte VALUES('oai','OpenAI', 'jb');
INSERT INTO projecte VALUES('ms','Microsoft', 'pa');
