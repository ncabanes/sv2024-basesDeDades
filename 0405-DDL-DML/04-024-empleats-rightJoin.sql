-- Mostra la informació dels empleats, juntament amb tots els departaments 
-- (fins i tot si en algun departament no hi ha empleats)

SELECT * 
FROM empleats RIGHT OUTER JOIN departaments 
ON empleats.codiDepartament = departaments.codi;

SELECT * 
FROM departaments LEFT OUTER JOIN empleats
ON empleats.codiDepartament = departaments.codi;

