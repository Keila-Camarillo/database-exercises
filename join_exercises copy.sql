USE join_example_db;
SHOW tables;
SELECT * FROM users;

SELECT * FROM roles;

-- Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.
SELECT * FROM users JOIN roles ON users.role_id = roles.id;

SELECT *
FROM users AS u
RIGHT JOIN roles AS r
	ON u.role_id = r.id;
SELECT *
FROM users AS u
LEFT JOIN roles AS r
	ON u.role_id = r.id;
    
-- Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. 
-- Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.
SELECT r.name, COUNT(*)
FROM users AS u
JOIN roles AS r
	ON r.id = u.role_id
GROUP BY r.name;



SELECT roles.name as role_name,
COUNT(users.name) as num_of_emp
FROM users
RIGHT JOIN roles on users.role_id = roles.id
GROUP BY role_name;

-- Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.
USE employees;
SHOW tables;
SELECT * FROM departments;
SELECT * FROM dept_manager;
SELECT * FROM employees;

SELECT d.dept_name, CONCAT(e.first_name, ' ', e.last_name)
FROM departments AS d
JOIN dept_manager AS dm
	ON dm.dept_no = d.dept_no
JOIN employees AS e
	ON e.emp_no = dm.emp_no
WHERE dm.to_date = '9999-01-01'
GROUP BY d.dept_name, dm.emp_no
ORDER BY d.dept_name;


SELECT d.dept_name
	, CONCAT(e.first_name, ' ', e.last_name)
FROM employees AS e
JOIN dept_manager AS dm USING(emp_no) 
JOIN departments AS d USING(dept_no)
WHERE dm.to_date > CURDATE()
ORDER BY d.dept_name;


-- Find the name of all departments currently managed by women.
SELECT * FROM departments;
SELECT * FROM dept_manager;
SELECT * FROM employees;
SELECT * FROM titles;

SELECT d.dept_name, CONCAT(e.first_name, ' ', e.last_name)
FROM departments AS d
JOIN dept_manager AS dm
	ON dm.dept_no = d.dept_no
JOIN employees AS e
	ON e.emp_no = dm.emp_no
WHERE dm.to_date = '9999-01-01' AND e.gender = 'F'
GROUP BY d.dept_name, dm.emp_no
ORDER BY d.dept_name;

SELECT d.dept_name
	, CONCAT(e.first_name, ' ', e.last_name)
FROM employees AS e
JOIN dept_manager AS dm USING(emp_no) 
JOIN departments AS d USING(dept_no)
WHERE dm.to_date > CURDATE() AND e.gender = 'F'
ORDER BY d.dept_name;

-- Find the current titles of employees currently working in the Customer Service department.
SELECT * FROM departments;
SELECT * FROM dept_emp WHERE dept_no = 'd009';
SELECT * FROM employees;
SELECT * FROM titles;

SELECT t.title, COUNT(*)
FROM titles AS t
JOIN dept_emp AS de
	ON t.emp_no = de.emp_no
WHERE de.dept_no = 'd009' AND (t.to_date = '9999-01-01')
GROUP BY title
ORDER BY title;

SELECT *
	, COUNT(de.emp_no) as count
FROM dept_emp AS de
JOIN titles AS t USING(emp_no)
JOIN departments AS d USING(dept_no)
WHERE t.to_date > curdate() 
	AND de.to_date > curdate()
    AND d.dept_name = 'Customer Service'
GROUP BY title;




-- Find the current salary of all current managers.
SHOW tables;
SELECT * FROM dept_manager;  
SELECT * FROM salaries;
SELECT * FROM employees;
SELECT * FROM departments;


SELECT d.dept_name, CONCAT(e.first_name, ' ', e.last_name) AS first_last_name, s.salary
FROM departments AS d
JOIN dept_manager AS dm
	ON dm.dept_no = d.dept_no
JOIN employees AS e
	ON e.emp_no = dm.emp_no
JOIN salaries AS s
	ON e.emp_no = s.emp_no
WHERE dm.to_date = '9999-01-01' AND s.to_date = "9999-01-01"
ORDER BY dept_name;


SELECT  d.dept_name
	, CONCAT(e.first_name, ' ', e.last_name) AS current_manager
    , s.salary 
FROM employees AS e
JOIN salaries AS s USING(emp_no) 
JOIN dept_manager AS dm USING(emp_no)
JOIN departments as d using(dept_no)
WHERE s.to_date > curdate() 
	AND dm.to_date > curdate()
ORDER BY d.dept_name;

-- Find the number of current employees in each department
SHOW tables;
SELECT * FROM dept_emp;  
SELECT * FROM employees;
SELECT * FROM departments;


SELECT d.dept_no, d.dept_name, COUNT(*) 
FROM dept_emp AS de
JOIN employees AS e
	ON e.emp_no = de.emp_no
JOIN departments AS d
	ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01' 
GROUP BY d.dept_name
ORDER BY d.dept_no;


SELECT 
	d.dept_no,
    d.dept_name,
    count(de.emp_no) as num_employees
FROM dept_emp AS de 
JOIN departments AS d using(dept_no)
WHERE de.to_date > curdate()
GROUP BY dept_no, dept_name;


-- Which department has the highest average salary? Hint: Use current not historic information.
SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM salaries;

SELECT d.dept_name, ROUND(AVG(s.salary), 2) AS avg_salary
FROM departments AS d
JOIN dept_emp AS de
	ON d.dept_no = de.dept_no
JOIN salaries AS s
	ON s.emp_no = de.emp_no
WHERE de.to_date =  '9999-01-01' AND (s.to_date  = '9999-01-01') 
GROUP BY d.dept_name
ORDER BY avg_salary DESC;
-- 
SELECT d.dept_name
	, ROUND(AVG(s.salary), 2) AS avg_salary
FROM dept_emp AS de
JOIN salaries AS s on de.emp_no = s.emp_no
	AND de.to_date > curdate()
    AND s.to_date > curdate()
JOIN departments as d using(dept_no)
GROUP BY d.dept_name
ORDER BY avg_salary DESC;


-- Who is the highest paid employee in the Marketing department?
SELECT * FROM departments; -- d001 marketing
SELECT * FROM dept_emp;
SELECT * FROM salaries;

SELECT e.first_name, e.last_name
FROM dept_emp AS de
JOIN salaries AS s
	ON s.emp_no = de.emp_no
JOIN employees AS e
	ON e.emp_no = de.emp_no
WHERE de.to_date =  '9999-01-01' AND (s.to_date  = '9999-01-01') AND (de.dept_no = 'd001') 
ORDER BY s.salary DESC
limit 1;
-- 

SELECT e.first_name
	,e.last_name
FROM employees as e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
	AND de.to_date > curdate()
JOIN salaries as s on e.emp_no = s.emp_no
	AND s.to_date > curdate()
JOIN departments as d on de.dept_no = d.dept_no
	and d.dept_name = 'Marketing'
ORDER BY s.salary DESC
limit 1;

-- Which current department manager has the highest salary?
SHOW tables;
SELECT * FROM departments; 
SELECT * FROM dept_manager;
SELECT * FROM salaries;


SELECT e.first_name, e.last_name, d.dept_name, MAX(s.salary) AS max_salary
FROM departments AS d
JOIN dept_manager AS dm
	ON d.dept_no = dm.dept_no
JOIN salaries AS s
	ON s.emp_no = dm.emp_no
JOIN employees AS e
	ON e.emp_no = s.emp_no
WHERE dm.to_date =  '9999-01-01' 
GROUP BY d.dept_name, e.first_name, e.last_name
ORDER BY max_salary DESC;
--
SELECT e.first_name
	, e.last_name
    , s.salary
    , d.dept_name
FROM employees AS e
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
	AND dm.to_date > curdate()
JOIN salaries AS s ON e.emp_no = s.emp_no
	AND s.to_date > curdate()
JOIN departments as d USING(dept_no)
ORDER BY s.salary DESC
LIMIT 1;

-- Determine the average salary for each department. Use all salary information and round your results.
USE employees;
SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM salaries;

SELECT d.dept_name, ROUND(AVG(s.salary), 0) AS avg_salary
FROM departments AS d
JOIN dept_emp AS de
	ON de.dept_no = d.dept_no
JOIN salaries AS s
	ON de.emp_no = s.emp_no
GROUP BY d.dept_name
ORDER BY avg_salary DESC;
-- 
SELECT d.dept_name
	, ROUND(AVG(s.salary), 2) as avg_dept_salary
FROM departments as d 
JOIN dept_emp as de using(dept_no)
JOIN salaries as s using(emp_no)
GROUP BY d.dept_name;
-- Bonus Find the names of all current employees, their department name, and their current manager's name.
SHOW tables;
SELECT * FROM departments;
SeleCT * FROM dept_emp;
SELECT * FROM employees;
SELECT * FROM dept_manager;



SELECT *
FROM departments AS d
JOIN dept_emp AS de
	ON d.dept_no = de.dept_no
JOIN employees AS e
	ON de.emp_no = e.emp_no
JOIN dept_manager AS dm
	ON d.dept_no = dm.dept_no
join employees as em
	ON dm.emp_no = em.emp_no
;




SELECT CONCAT(e.first_name, ' ', e.last_name) AS employee, d.dept_name , CONCAT(em.first_name, ' ', em.last_name) AS manager
FROM departments AS d
JOIN dept_emp AS de
	ON d.dept_no = de.dept_no
JOIN employees AS e
	ON de.emp_no = e.emp_no
JOIN dept_manager AS dm
	ON de.dept_no = dm.dept_no
join employees as em
	ON dm.emp_no = em.emp_no
;


SELECT d.dept_name, CONCAT(e.first_name, ' ', e.last_name) AS manager_name
FROM departments AS d
JOIN dept_manager AS dm
	ON dm.dept_no = d.dept_no
JOIN employees AS e
	ON e.emp_no = dm.emp_no
WHERE dm.to_date = '9999-01-01'
GROUP BY d.dept_name, dm.emp_no
ORDER BY d.dept_name;