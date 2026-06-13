----------------------------------------------------
-------------- DATE EXPLORATION  -------------------
----------------------------------------------------

-- FIND THE DATE OF FIRST ORDER AND LAST ORDER
SELECT 
	MIN(order_date) AS FirsOrder,
	MAX(order_date) AS LastOrder,
	DATEDIFF(YEAR, MIN(order_date), MAX(order_date) ) AS YearlyOrderSpan
FROM [dbo].[fact_sales]

-- FIND THE YOUNGEST AND OLDEST CUSTOMER
SELECT 
	MIN(birthdate) AS OldestBirthdate,
	DATEDIFF(YEAR, MIN(birthdate), GETDATE()) AS OldestAge,
	MAX(birthdate) AS YoungestBirthdate,
	DATEDIFF(YEAR, MAX(birthdate), GETDATE()) AS YoungestAge
FROM[dbo].[dim_customers]
