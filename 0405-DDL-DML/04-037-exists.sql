-- Mostra els països per als quals no existisca cap ciutat.

SELECT name FROM country
WHERE NOT EXISTS
(
	SELECT 'Nacho quiero sacar un 10' FROM city
	WHERE country.code = city.countryCode
);
