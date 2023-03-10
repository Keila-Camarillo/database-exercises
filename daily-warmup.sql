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
-- 
