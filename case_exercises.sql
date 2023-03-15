/*1. Write a query that returns all employees, their department number, their start date, their end date, and a new column 'is_current_employee' 
that is a 1 if the employee is still with the company and 0 if not.*/
USE employees;
SELECT * FROM employees;
SELECT * FROM dept_emp;

SELECT e.first_name, e.last_name, de.dept_no, de.from_date, de.to_date, 
	CASE
		WHEN to_date > CURDATE() THEN TRUE
        ELSE FALSE
	END AS its_current_employee
FROM employees AS e
JOIN dept_emp AS de USING(emp_no) 
;
-- 
SELECT emp_no, hire_date, to_date, if(to_date > now(), 1, 0) AS is_current_employee
FROM employees
JOIN dept_emp USING (emp_no);

SELECT *, if(max_date > now(), TRUE, FALSE) AS is_current_employee
FROM employees
JOIN 
	(
    SELECT emp_no, MAX(to_date) AS max_date
	FROM dept_emp
	GROUP BY emp_no
	) AS current_hire_date
USING(emp_no);

SELECT * FROM dept_emp limit 11;

SELECT emp_no, MAX(to_date)
FROM dept_emp
GROUP BY emp_no;

/*2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.*/
SELECT first_name, last_name,
	CASE
		WHEN LEFT(last_name, 1) REGEXP '^[A-H]' THEN 'A-H'
        WHEN LEFT(last_name, 1) REGEXP '^[I-Q]' THEN 'I-Q'
        WHEN LEFT(last_name, 1) REGEXP '^[R-Z]' THEN 'R-Z'
	END AS alpha_group
FROM employees
;

-- 
SELECT last_name,
	case
		WHEN left(last_name,1) <= 'H' then 'A-H'
        WHEN left(last_name,1) <= 'Q' then 'I-Q'
        ELSE 'R-Z'
	END as alpha_group
FROM employees
;
/*3. How many employees (current or previous) were born in each decade?*/
SELECT * FROM employees;
SELECT 
	COUNT(CASE WHEN date_format(birth_date, '%y') BETWEEN 50 AND 59 THEN 1 END ) AS '50s',
    COUNT(CASE WHEN date_format(birth_date, '%y') BETWEEN 60 AND 69 THEN 1 END ) AS '60s'
    
FROM employees
;

-- 
SELECT MIN(birth_date), MAX(birth_date)
FROM employees; 
SELECT 
	CASE 
		WHEN birth_date LIKE '195%' THEN '50s'
		ELSE '60s'
	END AS birth_decade, count(*)
FROM employees
GROUP BY birth_decade;

/*4. What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?*/
SELECT * FROM salaries; 
SELECT * FROM dept_emp;

SELECT  ROUND(AVG(s.salary), 2) AS salary_avg, 
	CASE 
		WHEN dept_name IN ('Sales', 'Marketing') THEN 'Sales & Marketing'
        WHEN dept_name IN ('Research', 'Development') THEN 'R&D'
        WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
        WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
        WHEN dept_name IN ('Customer Service') THEN 'Customer Service'
	END as dept_groups
FROM salaries AS s
JOIN dept_emp AS de USING(emp_no)
JOIN departments AS d ON d.dept_no = de.dept_no
WHERE s.to_date > CURDATE() AND de.to_date > CURDATE()
GROUP BY dept_groups
;

-- 
SELECT 
	CASE
		WHEN dept_name IN ('research', 'development') THEN 'R&D'
        WHEN dept_name IN ('Sales', 'Marketing') THEN 'Sales & Marketing'
		WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
        WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
        WHEN dept_name IN ('Customer Service') THEN 'Customer Service'
	END AS dept_group, AVG(salary)
FROM departments
JOIN dept_emp AS de USING(dept_no)
JOIN salaries AS s USING(emp_no)
WHERE s.to_date > CURDATE() AND de.to_date > CURDATE()
GROUP BY dept_group;