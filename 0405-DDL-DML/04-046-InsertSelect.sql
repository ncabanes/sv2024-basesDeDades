-- En la taula d'autors i llibres, bolca el nom dels autors que no tenen 
-- llibres, i com a títol escriu el text "(Sense llibres)"

INSERT INTO autorsILlibres
SELECT nom, '(Sense Llibres)'
FROM autors
WHERE codi NOT IN 
(
    SELECT codiAutor FROM escriure
);
