show databases;

use albums_db;
select database();
show tables;

use employees;
select database();
show tables;
show create table employees;
show create table departments;

/*
Which table(s) do you think contain a numeric type column? Salaries
Which table(s) do you think contain a string type column? titles, departments, dept_emp, and dept_manager
Which table(s) do you think contain a date type column? dept_emp, dept_manager
What is the relationship between the employees and the departments tables? They're connected through the primary key emp_no
*/

show create table dept_manager;