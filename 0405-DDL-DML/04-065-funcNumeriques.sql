-- Exercici 4.65: Valors numèrics

--  A partir de les dades de països, has de mostrar:

--  Posició de la primera A dins del nom (name)

SELECT name, INSTR(UPPER(name), 'A') FROM country;

--  Longitud (quantitat de lletres) del nom

SELECT name, LENGTH(name) FROM country;

--  Primera paraula del nom, suposant que tots els noms tingueren 2 o més paraules

SELECT name, SUBSTR(name, 1, INSTR(name, ' ')-1) FROM country;
