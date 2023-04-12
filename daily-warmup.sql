-- using the chipotle database,
-- find how many times someone ordered a chicken or veggie bowl
-- with a quantity greater than 1
SHOW databases;
USE chipotle;
SHOW tables;

SELECT * 
FROM orders
WHERE item_name IN ('chicken bowl', 'veggie bowl')
	AND quantity > 1;


--  03/15/2023
-- Using the customer table from sakila database, 584 active 15 inactive
-- find the number of active and inactive users
USE sakila;
SHOW tables;
SELECT * FROM customer;

SELECT DISTINCT active, COUNT(*)
FROM customer
GROUP BY active;

-- 03/20/2023
-- In the sakila database,
-- use the actor, film_actor, and film table
-- find all movies that 'Zero Cage' has been in
-- and make a new column that says if the movie
-- is rate R or not
use sakila;
show tables;
select * from actor;
select * from film_actor;
select * from film ;

select a.first_name, a.last_name, a.actor_id, fa.film_id, f.title, if(f.rating in ('R'), 'Yes', 'No') as rated_r
from actor as a
join film_actor as fa 
on fa.actor_id = a.actor_id
join film as f 
on f.film_id = fa.film_id
where a.first_name IN  ('Zero') and a.last_name IN ('cage');
-- 
select 
	concat(first_name, ' ', last_name) as full_name,
    title,
    if(rating = 'R', 'yes', 'no') as is_rated_r
from actor 
	join film_actor
		using (actor_id)
	join film 
		using (film_id)
where  first_name = 'Zero'
	and last_name = 'Cage'
;
-- 03/27/2023
-- Find all employees who are current managers and make more than one standard deviation over the companies salary average.
use employees;
show tables;


select e.first_name, e.last_name, s.salary
from employees as e
join salaries s using(emp_no)
where e.emp_no IN (select emp_no from dept_manager where to_date > curdate())
	and s.to_date > curdate()
    and s.salary > (select avg(salary) + std(salary) from salaries);

select * 
from dept_manager;

select avg(salary) + std(salary)
from salaries;

-- 03/28/2023
-- Using the telco_churn DB, give me all the customers who pay over the company monthly average
use telco_churn;
show tables;
select * from contract_types;
select * from customer_churn;
select * from customer_details;
select * from customer_payments;
select * from customer_signups;
select * from customer_subscriptions;
select * from customers;
select * from internet_service_types;
select * from payment_types;

select count(round(avg(monthly_charges), 2))
from customers; -- 64.76

select count(customer_id) 
from customers
where monthly_charges > (select avg(monthly_charges) from customers);


-- 04/11/2023
-- Using the customer, address, city, and country table in the sakila db
-- find all customers that live in Poland.
-- Output two columns titled: full_name, email

use sakila;
show tables;
select * from customer;
select * from address;
select * from country;

select concat(c.first_name ," " , c.last_name) , c.email
from customer as c
join address  
using (address_id)
join city
using (city_id)
join country
using (country_id)
where country = "Poland";
select * from salar;
