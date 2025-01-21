-- 1. Nom de les ciutats que continguen la seqüència de lletres "san", potser 
-- amb majúscules distintes (per exemple "Santa Fe"), ordenades.

SELECT name FROM city WHERE LOWER(name) LIKE '%san%' ORDER BY name;


-- 2. Nom de les ciutats que continguen una "i" després d'una "e", i 
-- esta després d'una "a" (per exemple, "Berazategui").

SELECT name FROM city WHERE name LIKE '%a%e%i%' ORDER BY name;


-- 3. Nom de la ciutat i nom del país, per a les ciutats que tinguen 
-- entre 900.000 habitants i un milió d'habitants (de 2 formes distintes).

SELECT city.name AS CityName, country.name AS CountryName 
FROM city JOIN country ON city.CountryCode = country.Code 
WHERE city.Population BETWEEN 900000 AND 1000000;

SELECT city.name AS CityName, country.name AS CountryName 
FROM city JOIN country ON city.CountryCode = country.Code 
WHERE city.Population >= 900000 AND city.Population <= 1000000;


-- 4. Nom de cada ciutat i nom del país al qual pertany, ordenat per ciutat i, 
-- en cas que dos ciutats s'anomenen igual, per nom del país.

SELECT city.name AS CityName, country.name AS CountryName 
FROM city JOIN country ON city.CountryCode = country.Code 
ORDER BY CityName, CountryName;


-- 5. Nom dels països dels quals no tenim cap ciutat, 
-- ordenats per població de manera descendent.

SELECT country.name 
FROM country LEFT JOIN city 
    ON country.Code = city.CountryCode 
WHERE city.ID IS NULL 
ORDER BY country.Population DESC;

SELECT name 
FROM country
WHERE country.Code NOT IN
(
    SELECT CountryCode 
    FROM city
);

SELECT name 
FROM country
WHERE country.Code <> ALL
(
    SELECT CountryCode 
    FROM city
);


-- 6. Països el nom dels quals coincidix amb el d'una ciutat 
-- (repte: seràs capaç d'aconseguir-ho d'almenys quatre formes distintes?).

-- Forma 1: Enllaçant amb JOIN

SELECT country.name 
FROM country JOIN city ON country.name = city.name; 

-- Forma 2: Enllaçant amb WHERE

SELECT country.name 
FROM country, city 
WHERE country.name = city.name; 

-- Forma 3: IN 

SELECT name 
FROM country 
WHERE name IN (SELECT name FROM city); 

-- Forma 4: ANY (No en SQLite)

SELECT name 
FROM country 
WHERE name = ANY (SELECT name FROM city); 

-- Forma 5: EXISTS
 
SELECT name FROM country WHERE EXISTS 
(
    SELECT 'Hola' FROM city WHERE city.name = country.name
);


-- 7. Nom de cada país al costat del nom de la seua capital 
-- (el codi apareix en el camp "Capital"), si la capital 
-- apareix en la nostra base de dades, ordenat per país.

SELECT country.name AS CountryName, city.name AS CapitalName 
FROM country JOIN city ON country.Capital = city.ID 
ORDER BY CountryName;


-- 8. País, capital i governant, per als països el governant 
-- dels quals sapiem, ordenat per país.

SELECT country.name AS CountryName, city.name AS CapitalName, country.HeadOfState 
FROM country JOIN city ON country.Capital = city.ID 
WHERE country.HeadOfState IS NOT NULL 
ORDER BY CountryName;


-- 9. Capitals i noms de països, el producte interior brut (GNP) 
-- dels quals siga superior a la mitjana dels d'Europa.

SELECT country.name AS CountryName, city.name AS CapitalName 
FROM country JOIN city ON country.capital = city.ID 
WHERE country.GNP > 
(
    SELECT AVG(GNP) 
    FROM country 
    WHERE continent = 'Europe'
);


-- 10. Per a cada país: nom, població i suma de les poblacions 
-- de les ciutats que coneixem d'eixe país.

SELECT country.name AS CountryName, 
    country.Population AS CountryPopulation, 
    SUM(city.Population) AS TotalCityPopulation 
FROM country LEFT JOIN city ON country.code = city.countryCode 
GROUP BY country.Name;


-- 11. Països, la població dels quals és menys de la mitat de la ciutat més poblada de tota la base de dades.

SELECT name 
FROM country 
WHERE population < (SELECT MAX(population) / 2 FROM city);


-- 12. Capitals que tinguen la mitat (o més) de la població del seu país.

SELECT city.name AS CapitalName 
FROM city JOIN country 
ON city.id = country.capital 
WHERE city.population >= country.population / 2;


-- 13. Ciutats el nom de les quals està repetit.

SELECT name FROM city GROUP BY name HAVING COUNT(*) > 1;


-- 14. Nom dels països que tenen ciutats el nom de les quals està repetit.

SELECT DISTINCT country.name 
FROM country JOIN city 
    ON country.Code = city.CountryCode 
WHERE city.name IN 
( 
    SELECT name FROM city GROUP BY name HAVING COUNT(*) > 1
);



-- ---------------------------------





-- 1. Nombre de las ciudades que contengan la secuencia de letras "san", quizá con mayúsculas distintas (por ejemplo "Santa Fe"), ordenadas.



-- 2. Nombre de las ciudades que contengan una "i" después de una "e", y ésta después de una "a" (por ejemplo, "Berazategui").



-- 3. Nombre de la ciudad y nombre del país, para las ciudades que tengan entre 900.000 habitantes y un millón de habitantes (de formas distintas).



-- 4. Nombre de cada ciudad y nombre del país al que pertenece, ordenado por ciudad y , en caso de que dos ciudades se llamen igual, por nombre del país.



-- 5. Nombre de los países de los que no tenemos ninguna ciudad, ordenados por población de forma descendente.



-- 6. Países cuyo nombre coincide con el de una ciudad (reto: ¿serás capaz de conseguirlo de no menos de cuatro formas distintas?).



-- 7. Nombre de cada país junto al nombre de su capital (el código aparece en el campo "Capital"), si la capital aparece en nuestra base de datos, ordenado por país.



-- 8. País, capital y gobernante, para los países cuyo gobernante sepamos, ordenado por país.



-- 9. Capitales y nombres de países cuyo producto interior bruto sea superior a la media de los de Europa.



-- 10. Para cada país: nombre, población y suma de las poblaciones de las ciudades que conocemos de ese país.



-- 11. Países cuya población es menos de la mitad de la ciudad más poblada de toda la base de datos.



-- 12. Capitales que tengan la mitad (o más) de la población de su país.



-- 13. Ciudades cuyo nombre está repetido.



-- 14. Nombre de los países que tienen ciudades cuyo nombre está repetido.

