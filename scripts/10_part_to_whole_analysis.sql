-- Which Category contribute the most to overall sales
WITH CategorySales AS (
    SELECT 
        prd.category,
        SUM(sales_amount) AS SalesByProducts
    FROM [dbo].[fact_sales] AS sls
    LEFT JOIN [dbo].[dim_products] AS prd 
        ON sls.product_key = prd.product_key
    GROUP BY prd.category
)
SELECT 
    category,
    ROUND(
        (
            CAST(SalesByProducts AS FLOAT) 
            / SUM (SalesByProducts) OVER ()
        ) * 100
        , 2) AS SalesPercentage
FROM CategorySales
ORDER BY SalesPercentage DESC

-- Another Way 
-- BRUTEFORCE APPROACH
WITH ProductSales AS (
    SELECT DISTINCT
        prd.category,
        SUM(sls.sales_amount) OVER (PARTITION BY prd.category) AS SalesByProduct,
        SUM(sls.sales_amount) OVER () AS TotalSales
    FROM [dbo].[fact_sales] AS sls
    LEFT JOIN [dbo].[dim_products] AS prd 
        ON sls.product_key = prd.product_key
)
SELECT 
    category,
    ROUND (
    (CAST(SalesByProduct AS float) / TotalSales) * 100 , 2 )
    AS SalesPercentage
FROM ProductSales
ORDER BY SalesPercentage DESC
