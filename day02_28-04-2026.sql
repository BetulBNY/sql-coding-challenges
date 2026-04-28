-- HACKERRANK QUERIES

--=========================== AGGREGATION ===========================
-- QUESTION 1: Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than . Round your answer to 4 decimal places.
SELECT 
ROUND(LONG_W,4)
FROM STATION
WHERE LAT_N = (
    SELECT
        MAX(LAT_N)
    FROM STATION
    WHERE LAT_N < 137.2345 
);

-- CTE VERSION:
WITH max_lat AS (
    SELECT MAX(LAT_N) AS max_lat_n
    FROM STATION
    WHERE LAT_N < 137.2345
)
SELECT ROUND(LONG_W, 4)
FROM STATION
WHERE LAT_N = (SELECT max_lat_n FROM max_lat);
-------------------------------------------------------------------------------------
-- QUESTION 2: Query the Western Longitude (LONG_W)where the smallest Northern Latitude (LAT_N) in STATION is greater 38.7780. Round your answer to 4 decimal places.
WITH tble AS(
    SELECT MIN(LAT_N) as MIN_LATN
    FROM STATION 
    WHERE LAT_N > 38.7780 
)
SELECT 
ROUND(LONG_W,4)
FROM STATION 
WHERE LAT_N = (SELECT MIN_LATN FROM tble);
-------------------------------------------------------------------------------------
-- Medium Level
-- QUESTION 3: 
/*
Consider P1(a,b) and P2(c,d) to be two points on a 2D plane.
 happens to equal the minimum value in Northern Latitude (LAT_N in STATION).
 happens to equal the minimum value in Western Longitude (LONG_W in STATION).
 happens to equal the maximum value in Northern Latitude (LAT_N in STATION).
 happens to equal the maximum value in Western Longitude (LONG_W in STATION).
Query the Manhattan Distance between points P1 and P2 and round it to a scale of  decimal places.
*/

WITH distances AS(
SELECT 
    MIN(LAT_N) AS a,
    MIN(LONG_W) AS b,    
    MAX(LAT_N) AS c,
    MAX(LONG_W) AS d
FROM STATION)
SELECT 
    ROUND(ABS(a-c) + ABS(b-d),4)
    FROM distances;
	
-- Expected Output
-- 259.6859
-------------------------------------------------------------------------------------
-- Medium Level
-- QUESTION 4:
/*
Consider P1(a,c)  and P2(b,d)  to be two points on a 2D plane where (a,b) are the respective minimum and maximum values of 
Northern Latitude (LAT_N) and (c,d)  are the respective minimum and maximum values 
of Western Longitude (LONG_W) in STATION.
Query the Euclidean Distance between points P1 and P2 and format your answer to display 4 decimal digits.
*/
WITH euc AS (
SELECT
    MIN(LAT_N) AS a,
    MAX(LAT_N) AS b,
    MIN(LONG_W) AS c,
    MAX(LONG_W) AS d
FROM STATION )
SELECT
    ROUND(SQRT(POWER(b-a, 2) + POWER(d-c, 2)),4)
    FROM euc;

--=========================== JOIN ===========================
-- QUESTION 5: Given the CITY and COUNTRY tables, query the sum of the populations of all cities where the CONTINENT is 'Asia'.
-- Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
SELECT 
    SUM(c.POPULATION)
    FROM CITY AS c
    INNER JOIN COUNTRY AS co
        ON c.COUNTRYCODE = co.CODE
    WHERE co.CONTINENT = 'Asia';
-------------------------------------------------------------------------------------
-- QUESTION 6: Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) 
-- and their respective average city populations (CITY.Population) rounded down to the nearest integer.
-- Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
SELECT
    co.CONTINENT,
    FLOOR(AVG(c.POPULATION))
FROM COUNTRY AS co
INNER JOIN CITY AS c
    ON c.COUNTRYCODE = co.CODE
GROUP BY co.CONTINENT;	
