show databases;
use albums_db;
select database();
show tables;

use employees;
select database();
show tables;
show create table employees;
/*
employees	CREATE TABLE `employees` (
  `emp_no` int NOT NULL,
  `birth_date` date NOT NULL,
  `first_name` varchar(14) NOT NULL,
  `last_name` varchar(16) NOT NULL,
  `gender` enum('M','F') NOT NULL,
  `hire_date` date NOT NULL,
  PRIMARY KEY (`emp_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1
*/
show create table departments;

/*
Which table(s) do you think contain a numeric type column? salaries, dept_emp, dept_manager, titles
Which table(s) do you think contain a string type column? titles, departments, dept_emp, and dept_manager
Which table(s) do you think contain a date type column? dept_emp, dept_manager, salaries, titles
What is the relationship between the employees and the departments tables? They're joined through the emp_no and dept_no on table dept_emp
*/

show create table dept_manager;