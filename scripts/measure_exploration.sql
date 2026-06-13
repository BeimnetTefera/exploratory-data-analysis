-- FIND THE TOTAL SALES
SELECT 
	FORMAT(SUM(sales_amount), 'c') AS TotalSales
FROM [dbo].[fact_sales]

-- TOTAL NUMBER OF ITEMS ARE SOLD
SELECT 
	SUM(quantity) AS TotalItemsSold
FROM [dbo].[fact_sales]

-- AVERAGE SELLING PRICE
SELECT 
	AVG(price) AS AverageSellingPrice
FROM [dbo].[fact_sales]

-- TOTAL NUMBER OF ORDERS
SELECT 
	COUNT(order_number) AS TotalOrders
FROM [dbo].[fact_sales]

-- TOTAL NUMBER OF CUSTOMERS
SELECT 
	COUNT(DISTINCT customer_key) AS TotalCustomers
FROM [dbo].[dim_customers]

-- TOTAL NUMBER OF PRODUCTS
SELECT 
	COUNT(product_key) AS TotalProducts
FROM [dbo].[dim_products]

-- TOTAL NUMBER OF CUSTOMERS WHO HAVE PLACED AN ORDER 
SELECT 
	COUNT(DISTINCT customer_key) TotalCustomerPlacedOrder
FROM [dbo].[fact_sales]


--------------------------------------------------------------------
---- GENERAL REPORT OF THAT SHOW THE KEY METRICS OF THE BUSINESS----
--------------------------------------------------------------------

SELECT 
	'TotalSales' AS MeasureName,
	SUM(sales_amount) AS MeasureValue
FROM [dbo].[fact_sales]
UNION
SELECT 
	'TotalItemsSold',
	SUM(quantity)
FROM [dbo].[fact_sales]
UNION
SELECT 
	'AverageSellingPrice',
	AVG(price) 
FROM [dbo].[fact_sales]
UNION
SELECT 
	'TotalOrders',
	COUNT(order_number)
FROM [dbo].[fact_sales]
UNION
SELECT
	'UniqueOrders',
	COUNT(DISTINCT order_number)
FROM [dbo].[fact_sales]
UNION
SELECT 
	'TotalProducts',
	COUNT(product_key)
FROM [dbo].[dim_products]
UNION
SELECT 
	'TotalCustomers',
	COUNT(customer_key)
FROM [dbo].[dim_customers]
UNION
SELECT 
	'TotalCustomerPlacedOrder',
	COUNT(DISTINCT customer_key) 
FROM [dbo].[fact_sales]
