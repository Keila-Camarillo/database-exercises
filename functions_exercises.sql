USE employees;
SHOW tables;
-- Write a query to to find all employees whose last name starts and ends with 'E'. 
-- Use concat() to combine their first and last name together as a single column named full_name.
SELECT CONCAT(first_name, " ", last_name) as full_name
FROM employees
WHERE last_name LIKE 'e%e'
;

-- Convert the names produced in your last query to all uppercase
SELECT UPPER(CONCAT(first_name, " ", last_name)) as full_name
FROM employees
WHERE last_name LIKE 'e%e'
;

-- Use a function to determine how many results were returned from your previous query.
SELECT COUNT(*)
FROM employees
WHERE last_name LIKE 'e%e'
;

SELECT * FROM employees;
-- Find all employees hired in the 90s and born on Christmas. 
-- Use datediff() function to find how many days they have been working at the company
SELECT 
	*
    , DATEDIFF(CURDATE(), hire_date) as days_at_company
FROM employees
WHERE hire_date LIKE '199%'
	AND birth_date LIKE '%12-25';
    
-- USING timestampdiff because why not
SELECT 
	first_name
    , last_name
    , hire_date
	, CURDATE() as cur_date
    , TIMESTAMPDIFF(day, hire_date, CURDATE()) as days_at_company
FROM employees
WHERE hire_date LIKE '199%'
	AND birth_date LIKE '%12-25';

-- different hire format and current date format
SELECT 
	first_name
    , last_name
    , DATE_FORMAT(hire_date, '%D %M %Y')
	, DATE_FORMAT(CURDATE(), '%D %M %Y'), TIMESTAMPDIFF(day, hire_date, CURDATE()) as days_at_company
FROM employees
WHERE hire_date LIKE '%199%'
	AND birth_date LIKE '%12-25';
    
SELECT * FROM salaries;

SELECT MIN(salary) as lowest_salary, MAX(salary) as highest_salary
FROM salaries;

SELECT MIN(salary) as lowest_salary, MAX(salary) as highest_salary
FROM salaries 
WHERE to_date > NOW()
;

-- A username should be all lowercase, and consist of the first character of the employees first name
-- the first 4 characters of the employees last name, an underscore, 
-- the month the employee was born, and the last two digits of the year that they were born.

SELECT 
	LOWER(CONCAT(LEFT(first_name, 1), LEFT(last_name, 4), DATE_FORMAT(`birth_date`, '_%m%y'))) as username
	, first_name
	, last_name
	, birth_date
FROM employees;