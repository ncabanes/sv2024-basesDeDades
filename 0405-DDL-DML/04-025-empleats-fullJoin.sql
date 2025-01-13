-- Mostra la informació de tots els empleats i tots els departaments, 
-- fins i tot si no estan relacionats els uns amb els altres.

SELECT * 
FROM departaments FULL JOIN empleats
ON empleats.codiDepartament = departaments.codi;
