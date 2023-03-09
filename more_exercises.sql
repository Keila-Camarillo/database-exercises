SHOW databases;
USE sakila;
SHOW tables; 

-- 1. SELECT statements
-- Select all columns from the actor table.
SELECT *
FROM actor;

-- Select only the last_name column from the actor table.
SELECT last_name
FROM actor;

-- Select only the film_id, title, and release_year columns from the film table.
SELECT film_id, title, release_year
FROM film;

-- 2. DISTINCT operator
-- Select all distinct (different) last names from the actor table.
SELECT DISTINCT last_name
FROM actor;

-- Select all distinct (different) postal codes from the address table.
SELECT * 
FROM address;

SELECT DISTINCT postal_code
FROM address;

-- Select all distinct (different) ratings from the film table.
SELECT * 
FROM film;

SELECT DISTINCT rating
FROM film;

-- 3. WHERE clause
-- Select the title, description, rating, movie length columns from the films table that last 3 hours or longer.
SELECT *
FROM film;

SELECT title, description, rating, length
FROM film
WHERE length > 180;

-- Select the payment id, amount, and payment date columns from the payments table for payments made on or after 05/27/2005.
SELECT *
FROM payment;

SELECT payment_id, amount, payment_date
FROM payment
WHERE payment_date >= "2005-05-27";

-- Select the primary key, amount, and payment date columns from the payment table for payments made on 05/27/2005.payment_id == primary key
SHOW CREATE table payment;
SELECT payment_id, amount, payment_date
FROM payment
WHERE payment_date >= "2005-05-27";

-- Select all columns from the customer table for rows that have a last names beginning with S and a first names ending with N.
SELECT * 
FROM customer
WHERE last_name LIKE "s%" AND
first_name LIKE "%n";

-- Select all columns from the customer table for rows where the customer is inactive or has a last name beginning with "M".
SELECT * 
FROM customer;

SELECT * 
FROM customer
WHERE active = "0"
OR last_name LIKE "m%";

-- Select all columns from the category table for rows where the primary key is greater than 4 and the name field begins with either C, S or T.
SELECT *
FROM category;

SELECT *
FROM category
WHERE category_id > 4
AND name LIKE "c%"
OR name LIKE "s%"
OR name LIKE "t%";

-- Select all columns minus the password column from the staff table for rows that contain a password.
SELECT *
FROM staff;
-- Select all columns minus the password column from the staff table for rows that do not contain a password.
