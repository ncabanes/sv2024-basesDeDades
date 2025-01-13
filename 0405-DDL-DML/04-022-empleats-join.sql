-- Prova la nova consulta que demana tota la informació d'empleats i 
-- departaments, emprant INNER JOIN per a enllaçar totes dues taules.

SELECT * 
FROM empleats INNER JOIN departaments 
ON empleats.codiDepartament = departaments.codi;
