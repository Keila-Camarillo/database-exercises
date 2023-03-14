-- Find all the current employees with the same hire date as employee 101010 using a subquery.
USE employees;
SELECT * FROM dept_emp;

SELECT hire_date
FROM employees
WHERE emp_no = 101010;

SELECT *
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no 
WHERE hire_date IN (SELECT hire_date FROM employees WHERE emp_no = 101010)
    AND de.to_date > CURDATE()
;

-- Find all the titles ever held by all current employees with the first name Aamod.
SELECT * FROM titles;
SELECT * FROM employees;
SELECT * FROM dept_emp;

SELECT t.title, e.first_name, e.last_name
FROM titles as t
JOIN employees as e ON t.emp_no = e.emp_no 
JOIN dept_emp as dm ON dm.emp_no = e.emp_no
WHERE t.emp_no IN (SELECT emp_no FROM employees WHERE first_name = 'Aamod') AND (dm.to_date > CURDATE())
ORDER BY t.title;

-- How many people in the employees table are no longer working for the company? Give the answer in a comment in your code. 85108
SELECT * FROM employees;
SELECT * FROM dept_emp;

SELECT COUNT(emp_no)
FROM employees
WHERE emp_no IN (SELECT emp_no FROM dept_emp WHERE to_date < CURDATE())
;

SELECT emp_no FROM dept_emp WHERE to_date < CURDATE();
-- Find all the current department managers that are female. List their names in a comment in your code.Isamu Legleitner, Karsten Sigstam, Leon DasSarma, Hilary Kambil
SELECT * FROM dept_manager;
SELECT * FROM employees;

SELECT *
FROM employees as e
JOIN dept_manager as dm ON e.emp_no = dm.emp_no
WHERE e.emp_no IN (SELECT emp_no FROM employees WHERE gender = 'F')
	AND (dm.to_date > CURDATE())
;

-- Find all the employees who currently have a higher salary than the companies overall, historical average salary.
SELECT * FROM salaries;
SELECT * FROM employees;
SELECT * FROM dept_emp;

SELECT e.first_name
	, e.last_name
    , s.salary
    , (SELECT ROUND(AVG(salary), 2) FROM salaries) AS avg_salary
FROM salaries AS s
JOIN employees AS e ON e.emp_no = s.emp_no
JOIN dept_emp AS de ON e.emp_no = de.emp_no
WHERE de.to_date > CURDATE() AND (s.to_date > CURDATE()) 
HAVING s.salary > avg_salary;


SELECT AVG(salary) FROM salaries;

-- How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) 78, 240124
-- What percentage of all salaries is this?
-- Hint You will likely use multiple subqueries in a variety of ways
-- Hint It's a good practice to write out all of the small queries that you can. Add a comment above the query showing the number of rows returned. 
-- You will use this number (or the query that produced it) in other, larger queries.
SELECT STDDEV(std_max_salary), (SELECT s.salary FROM salaries AS s JOIN employees AS e ON e.emp_no = s.emp_no JOIN dept_emp AS de ON e.emp_no = de.emp_no WHERE de.to_date > CURDATE() AND (s.to_date > CURDATE())
) AS std_max_salary 
FROM salaries;


SELECT MAX(salary) FROM salaries WHERE to_date > CURDATE();

-- MAX salary of currrent employees
SELECT MAX(salary)
FROM salaries
WHERE to_date > CURDATE();

-- std for all salaries
SELECT ROUND(STDDEV(salary), 0)
FROM salaries
WHERE to_date > CURDATE();

SELECT 
	COUNT(salary) / (SELECT COUNT(salary)FROM salaries WHERE to_date > CURDATE()) * 100 AS percent_of_salary_within_one_std
FROM salaries
WHERE salary > (
    (SELECT MAX(salary) FROM salaries) - (SELECT ROUND(STDDEV(salary), 0) FROM salaries))
    AND (to_date > CURDATE());
    

-- total salaries for current employees
SELECT COUNT(salary)
FROM salaries 
WHERE to_date > CURDATE();

SELECT salary
FROM salaries;
-- current salaries for employees 
SELECT STD((SELECT s.salary FROM salaries AS s JOIN employees AS e ON e.emp_no = s.emp_no JOIN dept_emp AS de ON e.emp_no = de.emp_no WHERE de.to_date > CURDATE() AND (s.to_date > CURDATE())))
;



-- Find all the department names that currently have female managers.
SELECT * FROM employees;
SELECT * FROM dept_manager;
SELECT * FROM departments;

SELECT *
FROM employees AS e
JOIN dept_manager AS dm ON dm.emp_no = e.emp_no
JOIN department AS d ON dm.dept_no = d.dept_no;   

SELECT d.dept_name, e.first_name, e.last_name
FROM employees AS e
JOIN dept_manager AS dm ON dm.emp_no = e.emp_no
JOIN departments AS d ON d.dept_no = dm.dept_no
WHERE e.emp_no IN (
	SELECT emp_no
	FROM dept_manager
	WHERE gender = 'F') 
    AND (dm.to_date > CURDATE())
;
-- JOIN department AS d ON dm.dept_no = d.dept_no;   
    
SELECT emp_no
FROM employees
WHERE gender = 'F' ;



-- Find the first and last name of the employee with the highest salary.
SELECT * FROM employees;
SELECT MAX(salary) FROM salaries WHERE to_date > CURDATE();

SELECT * 
FROM employees AS e
JOIN salaries AS s ON s.emp_no = e.emp_no
WHERE s.to_date > CURDATE()
ORDER BY s.salary DESC
LIMIT 1;

SELECT emp_no
FROM salaries
WHERE salary IN ((SELECT MAX(salary)
FROM salaries
WHERE to_date > CURDATE()));

-- Find the department name that the employee with the highest salary works in.
SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM employees;

SELECT d.dept_name, e.first_name, e.last_name 
FROM employees AS e
JOIN dept_emp AS de ON de.emp_no = e.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
WHERE e.emp_no IN ((
	SELECT emp_no
	FROM salaries
	WHERE salary IN ((SELECT MAX(salary)
	FROM salaries
	WHERE to_date > CURDATE()))
));


-- Who is the highest paid employee within each department.
SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM salaries;

-- highest paid employees
SELECT emp_no
FROM departments AS d
JOIN dept_emp AS de ON de.dept_no = d.dept_no
JOIN salaries as s ON s.emp_no = de.emp_no;






SELECT DISTINCT d.dept_name
FROM employees AS e
JOIN dept_emp AS de ON de.emp_no = e.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
WHERE e.emp_no IN ((
	SELECT emp_no
	FROM salaries
	WHERE salary IN ((SELECT salary
	FROM salaries
	WHERE to_date > CURDATE() ORDER BY salary DESC))
))
;

