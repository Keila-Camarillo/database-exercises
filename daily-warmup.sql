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


--  03/15/2022
-- Using the customer table from sakila database, 584 active 15 inactive
-- find the number of active and inactive users
USE sakila;
SHOW tables;
SELECT * FROM customer;

SELECT DISTINCT active, COUNT(*)
FROM customer
GROUP BY active;



