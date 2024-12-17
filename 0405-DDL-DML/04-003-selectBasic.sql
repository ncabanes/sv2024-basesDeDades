-- Has de mostrar:
-- Nom i cognoms dels estudiants que el seu NIA siga el 34.
-- Nom i cognoms dels estudiants cognomenats "Johnson".
-- Nom i cognoms dels estudiants que el seu NIA no siga el 21.

SELECT nom, cognoms FROM estudiants WHERE nia = 34;
SELECT nom, cognoms FROM estudiants WHERE cognoms = 'Johnson';
SELECT nom, cognoms FROM estudiants WHERE nia <> 21;
