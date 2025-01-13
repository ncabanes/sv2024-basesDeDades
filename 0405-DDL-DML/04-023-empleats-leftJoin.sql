-- Mostra la informació de tots els empleats, juntament amb els 
-- departaments que corresponguen (si n'hi ha).

SELECT * 
FROM empleats LEFT OUTER JOIN departaments 
ON empleats.codiDepartament = departaments.codi;
