-- HACKERRANK QUERIES

--=========================== SELECT ===========================
-- QUESTION 1 (Weather Observation Station 3):
-- Query a list of CITY names from STATION for cities that have an even ID number. 
-- Print the results in any order, but exclude duplicates from the answer.
-- '%' not supported in DB2

SELECT DISTINCT CITY
FROM STATION
WHERE ID % 2 = 0;

--TRUE SOLUTION:
SELECT DISTINCT
CITY
FROM STATION
WHERE MOD(ID, 2) = 0;
/*
Expected Output
Aguanga 
Alba 
Albany 
Amo 
Andersonville 
Archie 
...

9m
*/
-------------------------------------------------------------------------------------
-- QUESTION 2 (Weather Observation Station 4):
-- Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.
-- For example, if there are three records in the table with CITY values 'New York', 'New York', 'Bengalaru', there are 2 different city names: 'New York' and 'Bengalaru'. 
-- The query returns 1, because : TOTAL NUMBER OF RECORDS - NUMBER OF UNIQUE CITY NAMES = 3 - 2 = 1

SELECT  
COUNT(*) - COUNT(DISTINCT CITY)
FROM STATION;
/*
Your Output (stdout)
13

2m
*/
-------------------------------------------------------------------------------------
-- QUESTION 3 (Weather Observation Station 5):
-- Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). 
-- If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.
-- CTE is not supported
-- Note: You can write two separate queries to get the desired output. It need not be a single query.

SELECT 
CITY,
LENGTH(CITY)
FROM STATION
ORDER BY LENGTH(CITY) DESC, CITY
LIMIT 1;

SELECT 
CITY,
LENGTH(CITY)
FROM STATION
ORDER BY LENGTH(CITY) ASC, CITY
LIMIT 1;
/*
Your Output (stdout)
Marine On Saint Croix 21 

24m
*/
-------------------------------------------------------------------------------------
-- QUESTION 4  (Weather Observation Station 6):
-- Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
SELECT DISTINCT CITY
FROM STATION
WHERE UPPER(CITY) LIKE 'A%'
   OR UPPER(CITY) LIKE 'E%'
   OR UPPER(CITY) LIKE 'I%'
   OR UPPER(CITY) LIKE 'O%'
   OR UPPER(CITY) LIKE 'U%';

-- UPPER USAGE IS IMPORTANT!
/*
Your Output (stdout)
Acme 
Addison 
Agency 
Aguanga 
Alanson 
...

5m
*/
-------------------------------------------------------------------------------------
-- QUESTION 5  (Weather Observation Station 7):
-- Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.
SELECT DISTINCT CITY
FROM STATION
WHERE UPPER(SUBSTR(CITY, 1, 1)) IN ('A','E','I','O','U')
  AND UPPER(SUBSTR(CITY, LENGTH(CITY), 1)) IN ('A','E','I','O','U');

/*
Your Output (stdout)
Acme 
Aguanga 
Alba 
Aliso Viejo 
Alpine 
Amazonia 
Amo 
Andersonville 
...

10m
*/
-- SUBSTRING USAGE
-------------------------------------------------------------------------------------


--=========================== AGGREGATION ===========================
-- QUESTION 1  (Average Population):
-- Query the average population for all cities in CITY, rounded down to the nearest integer.
SELECT
INTEGER(AVG(POPULATION))
FROM CITY;

/*
454250

2m
*/
-------------------------------------------------------------------------------------
-- QUESTION 2  (Population Density Difference):
-- Query the difference between the maximum and minimum populations in CITY.

SELECT
MAX(POPULATION) - MIN(POPULATION)
FROM CITY;

/*
Your Output (stdout)
4695354 

2m
*/
-------------------------------------------------------------------------------------
-- QUESTION 3  (The Blunder):
-- Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table,
-- but did not realize her keyboard's 0 key was broken until after completing the calculation. 
-- She wants your help finding the difference between her miscalculation (using salaries with any zeros removed), and the actual average salary.
-- Write a query calculating the amount of error (i.e.: actual - miscalculated average monthly salaries), and round it up to the next integer.

SELECT
CEIL(
AVG(Salary) - AVG(CAST(REPLACE(Salary, '0', '') AS SIGNED)))
FROM EMPLOYEES;
/*
Your Output (stdout)
2253

18m
*/
-- REPLACE USAGE
-------------------------------------------------------------------------------------
-- QUESTION 4  (Top Earners):
-- We define an employee's total earnings to be their monthly  worked, and the maximum total earnings to be the maximum total earnings for any employee in the Employee table. 
-- Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings. Then print these values as 2 space-separated integers.
SELECT 
	months * salary AS earnings,
	COUNT(*)
FROM Employee
GROUP BY months * salary
ORDER BY months * salary DESC
LIMIT 1;

/*
Your Output (stdout)
108064 7

5m
*/
-------------------------------------------------------------------------------------