SHOW databases;
USE employees;
SHOW tables;
-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. What is the employee number of the top three results? 10200, 10397, 10610
SELECT *
FROM employees;

-- 2. What was the first and last name in the first row of the results? What was the first and last name of the last person in the table? Irena Reutenauer,Vidya Simmen

SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name ASC;

-- 3. What was the first and last name in the first row of the results? What was the first and last name of the last person in the table? Irena Acton, Vidya Zwqizig
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY 
first_name ASC, 
last_name ASC;

-- 4. What was the first and last name in the first row of the results? What was the first and last name of the last person in the table? Irena Acton, Maya Zyda
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY 
last_name ASC, 
first_name ASC;

-- 5. Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name. 10021 Ramzi Erde, Tadahiro Erde
SELECT *
FROM employees
WHERE last_name LIKE 'E%'
AND last_name LIKE '%E'
ORDER BY emp_no;

-- 6. Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest employee. Sergi Erde, Teiji Eldridge 
SELECT *
FROM employees
WHERE last_name LIKE 'E%'
AND last_name LIKE '%E'
ORDER BY hire_date;

-- 7. Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest employee who was hired first. Khun Bernini, Douadi Pettis
SELECT *
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
AND birth_date LIKE '%12-25'
ORDER BY birth_date ASC,
hire_date DESC;