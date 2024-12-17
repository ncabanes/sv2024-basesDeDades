-- Cognoms dels estudiants amb NIA entre 23 i 33, 
-- tots dos inclosos (de 2 maneres diferents)

SELECT cognoms FROM estudiants WHERE nia >= 23 AND nia <= 33;
SELECT cognoms FROM estudiants WHERE nia BETWEEN 23 AND 33;
