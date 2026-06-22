-- Analyze Sales Performance Over Time
SELECT 
    DATETRUNC(MONTH, order_date) AS OrderDate,
    SUM(sales_amount) AS TotalSales,
    AVG(sales_amount) AS AverageSales,
    COUNT(DISTINCT customer_key) AS TotalCustomers,
    SUM(quantity) AS TotalQuantity
FROM [dbo].[fact_sales]
WHERE order_date IS NOT NULL
GROUP BY  DATETRUNC("MONTH", order_date)
ORDER BY OrderDate

-- Another way - 2nd alternative
SELECT 
    FORMAT(order_date, 'yyy-MMM') AS OrderDate,
    SUM(sales_amount) AS TotalSales,
    AVG(sales_amount) AS AverageSales,
    COUNT(DISTINCT customer_key) AS TotalCustomers,
    SUM(quantity) AS TotalQuantity
FROM [dbo].[fact_sales]
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date, 'yyy-MMM')
ORDER BY OrderDate

-- Another Way - 3rd Alternative
SELECT 
    YEAR(order_date) AS OrderYear,
    MONTH(order_date) AS OrderMonth,
    SUM(sales_amount) AS TotalSales,
    AVG(sales_amount) AS AverageSales,
    COUNT(DISTINCT customer_key) AS TotalCustomers,
    SUM(quantity) AS TotalQuantity
FROM [dbo].[fact_sales]
WHERE order_date IS NOT NULL
GROUP BY  YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date), MONTH(order_date)
