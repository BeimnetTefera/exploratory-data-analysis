WITH YearlyProduct AS (
    SELECT 
        prd.product_name AS ProductName,
        SUM(sls.sales_amount) AS CurrentSales,
        YEAR(order_date) AS OrderYear
    FROM [dbo].[fact_sales] AS sls
    LEFT JOIN [dbo].[dim_products] AS prd
        ON sls.product_key = prd.product_key
    WHERE order_date IS NOT NULL
    GROUP BY 
        prd.product_name,
        YEAR(order_date)
)
SELECT 
    ProductName,
    OrderYear,
    CurrentSales,
    
    AVG(CurrentSales) OVER (PARTITION BY ProductName) AS AverageSales,
    CurrentSales - AVG(CurrentSales) OVER (PARTITION BY ProductName) AS SalesDiff,

    CASE 
        WHEN CurrentSales - AVG(CurrentSales) OVER (PARTITION BY ProductName) > 0 THEN 'Above Avg'
        WHEN CurrentSales - AVG(CurrentSales) OVER (PARTITION BY ProductName) < 0 THEN 'Below Avg'
        ELSE 'Average'
    END AS SalesChange,

    LAG(CurrentSales) OVER (PARTITION BY ProductName ORDER BY OrderYear) AS PrevSales,
    CurrentSales - LAG(CurrentSales) OVER (PARTITION BY ProductName ORDER BY OrderYear) AS DiffSalesWithPrev,

    CASE 
        WHEN CurrentSales - LAG(CurrentSales) OVER (PARTITION BY ProductName ORDER BY OrderYear)  > 0 THEN 'Increase'
        WHEN CurrentSales - LAG(CurrentSales) OVER (PARTITION BY ProductName ORDER BY OrderYear)  < 0 THEN 'Decrease'
        ELSE 'No Change'
    END AS CurPrevSalesChnage

FROM YearlyProduct
ORDER BY 
        ProductName ASC,
        OrderYear ASC
