USE projschema;

-- Query #1
-- Create a SELECT query that uses a condition in the WHERE Clause.
SELECT * FROM customers 
WHERE Membership_MembershipType = "bronze";

-- Query #2
-- Create a SELECT query that joins any two tables through a Natural Join
SELECT Customers_CustomerID, LoanDate, DueDate 
FROM orders 
INNER JOIN customers 
	ON orders.Customers_CustomerID = customers.CustomerID;

-- Query #3
-- Create a SELECT query that joins at least four tables
SELECT 
Customers_CustomerID CustomerID, 
concat(customers.FirstName, " " , customers.lastName) as 'Customer Name',
orders.LoanDate 'Loan Date', 
orders.OrderID, 
concat(employees.FirstName , " ", employees.lastName) 'Employee Name', 
individual_items_in_collection.barcode 
FROM 
(((orders INNER JOIN customers ON orders.Customers_CustomerID = customers.CustomerID)
INNER JOIN Employees ON orders.Employees_EmployeeID = Employees.EmployeeID)
INNER JOIN individual_items_in_collection 
ON orders.Individual_Items_In_Collection_Barcode = individual_items_in_collection.barcode);

-- Query #4
-- Create a SELECT query that uses an Aggregate function
DESCRIBE customers;
SELECT * FROM customers;
SELECT city, Membership_MembershipType AS 'Membership Type' ,
 COUNT(CustomerID) AS count 
FROM Customers
GROUP BY city, Membership_MembershipType;

-- Queries #5
SELECT * FROM customers ORDER BY LastName;

-- Queries #6
SELECT Employees_EmployeeID, OrderID, DueDate, COUNT(*) AS counter 
FROM orders 
GROUP BY Employees_EmployeeID 
HAVING DueDate > '2018-04-01';

-- Queries #7
CREATE OR REPLACE VIEW view_table 
AS 
	SELECT MembershipType, CustomerID, OrderID 
	FROM orders i 
	JOIN customers c 
		ON i.Customers_CustomerID = c.CustomerID 
	JOIN membership_type m 
		ON c.Membership_MembershipType = m.MembershipType 
	WHERE m.MembershipType = 'Bronze';
  
SELECT * FROM view_table;

-- Queries #8
SELECT e.EmployeeID, OrderID 
FROM orders o 
RIGHT JOIN employees e 
	ON o.Employees_EmployeeID = e.EmployeeID;

-- Queries #9
SELECT * FROM customers 
WHERE CustomerID IN 
	(SELECT CustomerID FROM customers 
	WHERE Membership_MembershipType != 'Bronze');

-- Queries #10
SELECT DISTINCT l1.Index_Number, l1.ProductType_ProductType 
FROM librarycollection l1, librarycollection l2 
WHERE l1.Index_Number <> l2.Index_Number 
	AND l1.ProductType_ProductType = l2.ProductType_ProductType;