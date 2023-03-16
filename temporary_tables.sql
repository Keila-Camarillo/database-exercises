show databases;
USE employees;

/*
1. Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department. 
Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.

Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns.
Update the table so that the full_name column contains the correct data.
Remove the first_name and last_name columns from the table.
What is another way you could have ended up with this same table?
*/

CREATE temporary TABLE pagel_2186.employees_with_departments AS 
SELECT first_name, last_name, dept_name
FROM employees
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no)
WHERE de.to_date > curdate();

ALTER TABLE pagel_2186.employees_with_departments ADD full_name VARCHAR(30); 
UPDATE pagel_2186.employees_with_departments SET full_name = CONCAT(first_name, ' ', last_name);
SELECT * FROM pagel_2186.employees_with_departments ;
alter table pagel_2186.employees_with_departments drop column first_name;
alter table pagel_2186.employees_with_departments drop column last_name;
-- 
CREATE temporary TABLE pagel_2186.employees_with_departments_practice AS 
	SELECT first_name, last_name, dept_name	
	FROM employees.employees
	JOIN employees.dept_emp USING(emp_no) 
	JOIN employees.departments USING(dept_no)
	WHERE to_date > curdate();
    
alter table pagel_2186.employees_with_departments_practice add full_name varchar(30); 
update pagel_2186.employees_with_departments_practice
set full_name = CONCAT(first_name, ' ', last_name); 
alter table pagel_2186.employees_with_departments_practice drop column first_name;
alter table pagel_2186.employees_with_departments_practice drop column last_name;

drop table if exists pagel_2186.employees_with_departments_practice;
CREATE temporary TABLE pagel_2186.employees_with_departments_practice AS 
	SELECT CONCAT(first_name, ' ', last_name) as full_name,  dept_name	
	FROM employees.employees
	JOIN employees.dept_emp USING(emp_no) 
	JOIN employees.departments USING(dept_no)
	WHERE to_date > curdate();

/*
2. Create a temporary table based on the payment table from the sakila database.

Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
*/
use sakila;
CREATE temporary TABLE pagel_2186.payment_from_sakila AS 
SELECT *
FROM payment
;
SHOW CREATE table payment;

update pagel_2186.payment_from_sakila SET amount = amount * 100;
alter table pagel_2186.payment_from_sakila modify amount decimal(6,0) NOT NULL;

--
select * from sakila.payment;

select amount * 100 as amount_in_pennies 
from sakila.payment;

create temporary table pagel_2186.payments_1 as
select amount * 100 as amount_in_pennies 
from sakila.payment;

;
alter table payments_1 
modify amount_in_pennies int not null;
select * 
from payments;

create temporary table payments_1  AS
select amount * 100 as amount_in_pennies 
from sakila.payment;


update payments_1
set amount = amount * 100;

alter table pagel_2186.payments
modify amount decimal(10,2);
 
alter table payments_1 
modify amounnt int not null;

/*
3. Find out how the current average pay in each department compares to the overall current pay for everyone at the company. 
For this comparison, you will calculate the z-score for each salary. In terms of salary, what is the best department right now to work for? The worst?
*/

USE employees;

SELECT * FROM salaries; 
SELECT * FROM dept_emp;

SELECT  d.dept_name, ROUND(AVG(s.salary), 2) AS salary_avg_dept
FROM salaries AS s
JOIN dept_emp AS de USING(emp_no)
JOIN departments AS d ON d.dept_no = de.dept_no
WHERE s.to_date > CURDATE() AND de.to_date > CURDATE()
GROUP by d.dept_name
;

SELECT salary, (salary -  (SELECT AVG(salary) FROM salaries where to_date > now()))
        /
        (SELECT stddev(salary) FROM salaries where to_date > now()) AS zscore
FROM salaries

WHERE salaries.to_date > CURDATE() 
;

SELECT salary, (salary -  (SELECT AVG(salary) FROM salaries where to_date > now()))
        /
        (SELECT stddev(salary) FROM salaries where to_date > now()) AS zscore
FROM salaries
JOIN dept_emp AS de USING(emp_no)
JOIN departments AS d ON d.dept_no = de.dept_no
WHERE salaries.to_date > CURDATE() 
;

-- 

-- Overall current salary stats
select avg(salary), std(salary) from employees.salaries where to_date > now();

-- 72,012 overall average salary
-- 17,310 overall standard deviation

-- Saving my values for later... that's what variables do (with a name)
-- Think about temp tables like variables
create temporary table overall_aggregates as (
    select avg(salary) as avg_salary, std(salary) as std_salary
    from employees.salaries  where to_date > now()
);

-- double check that the values look good.
select * from overall_aggregates;


-- Let's check out our current average salaries for each department
-- If you see "for each" in the English for a query to build..
-- Then, you're probably going to use a group by..
select dept_name, avg(salary) as department_current_average
from employees.salaries
join employees.dept_emp using(emp_no)
join employees.departments using(dept_no)
where employees.dept_emp.to_date > curdate()
and employees.salaries.to_date > curdate()
group by dept_name;

drop table if exists current_info;

# create the temp table using the query above
create temporary table current_info as (
    select dept_name, avg(salary) as department_current_average
    from employees.salaries
    join employees.dept_emp using(emp_no)
    join employees.departments using(dept_no)
    where employees.dept_emp.to_date > curdate()
    and employees.salaries.to_date > curdate()
    group by dept_name
);

select * from current_info;

-- add on all the columns we'll end up needing:
alter table current_info add overall_avg float(10,2);
alter table current_info add overall_std float(10,2);
alter table current_info add zscore float(10,2);

-- peek at the table again
select * from current_info;

-- set the avg and std
update current_info set overall_avg = (select avg_salary from overall_aggregates);
update current_info set overall_std = (select std_salary from overall_aggregates);



-- update the zscore column to hold the calculated zscores
update current_info 
set zscore = (department_current_average - overall_avg) / overall_std;



select * from andrew_king.current_info
order by zscore desc;


SELECT AVG(salary), STDDEV(salary)
FROM employees.salaries;

