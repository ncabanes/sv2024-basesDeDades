-- Prova la nova consulta que demana tota la informació d'empleats i 
-- departaments, emprant WHERE per a enllaçar totes dues taules.

SELECT * 
FROM empleats, departaments 
WHERE empleats.codiDepartament = departaments.codi;
