SHOW databases;
USE employees;
SHOW tables;
SELECT * 
FROM employees;

-- MySQL provides a way to return only unique results from our queries with the keyword DISTINCT. For example, to find all the unique titles within the company, we could run the following query:
SELECT DISTINCT last_name
FROM employees
ORDER BY last_name DESC
LIMIT 10;

-- Find all previous or current employees hired in the 90s and born on Christmas. Find the first 5 employees hired in the 90's by sorting by hire date and limiting your results to the first 5 records. Write a comment in your code that lists the five names of the employees returned.
SELECT *
FROM employees
WHERE hire_date LIKE '199%'
	AND birth_date LIKE '%12-25'
ORDER BY hire_date
LIMIT 5; 

SELECT *
FROM employees
WHERE hire_date LIKE '199%'
	AND birth_date LIKE '%12-25'
ORDER BY hire_date
LIMIT 5 OFFSET 45;