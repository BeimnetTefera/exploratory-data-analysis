- Calculate Total Sales per Month and Running Total Sales Overtime
WITH monthly_sales AS (
    SELECT 
        DATETRUNC(MONTH, order_date) AS OrderedMonth,
        SUM(sales_amount) AS TotalSales,
        YEAR(order_date) AS OrderYear
    FROM [dbo].[fact_sales]
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(MONTH, order_date),  YEAR(order_date)
)
SELECT 
    OrderedMonth,
    TotalSales,
    SUM(TotalSales) OVER (PARTITION BY OrderYear ORDER BY OrderedMonth)
FROM monthly_sales
----------------------------------------------------------------------------------
-- Another Way - 2nd Alterantive
SELECT 
    MONTH(order_date) AS OrderMonth,
    SUM(sales_amount) AS TotalSales,
    SUM(SUM(sales_amount)) OVER (ORDER BY MONTH(order_date)) AS RunningTotalSales
FROM [dbo].[fact_sales]
WHERE order_date IS NOT NULL
GROUP BY MONTH(order_date);
-----------------------------------------------------------------------------------

-- Find the Moving Average of Sales over the time
WITH monthly_sale AS (
    SELECT 
        DATETRUNC(MONTH, order_date) AS OrderDate,
        YEAR(order_date) AS OrderYear,
        SUM(sales_amount) AS TotalSales
    FROM [dbo].[fact_sales]
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(MONTH, order_date), YEAR(order_date)
)
SELECT 
    OrderDate,
    TotalSales,
    AVG(TotalSales) OVER (PARTITION BY OrderYear ORDER BY OrderDate) AS MovingAverage
FROM monthly_sale
