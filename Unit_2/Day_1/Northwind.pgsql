SELECT * FROM orders LIMIT 10;

/* TASK 1 - Write a query that returns a product name and its quantity/unit. */

SELECT productname, quantityperunit FROM Products LIMIT 1;

/* TASK 2 - Write a query to select all product names and their category ID */

SELECT productname, categoryid FROM Products;

/* TASK 3 - Write a query to get the firstname, lastname and hiredate for employees who have been working at their company for more than 5 years */

SELECT firstname, lastname, hiredate 
FROM employees
WHERE hiredate < NOW() - '5 years' :: interval;

