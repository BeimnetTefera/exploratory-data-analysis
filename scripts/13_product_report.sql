/*
===============================================================================
Product Report
===============================================================================
Purpose:
    - This report consolidates key product metrics and behaviors.

Highlights:
    1. Gathers essential fields such as product name, category, subcategory, and cost.
    2. Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers.
    3. Aggregates product-level metrics:
       - total orders
       - total sales
       - total quantity sold
       - total customers (unique)
       - lifespan (in months)
    4. Calculates valuable KPIs:
       - recency (months since last sale)
       - average order revenue (AOR)
       - average monthly revenue
===============================================================================
*/
WITH MainTable AS (
    SELECT 
        sls.product_key AS ProductKey,
        prd.product_name AS ProductName,
        sls.order_date AS OrderDate,
        sls.order_number AS OrderNumber,
        prd.product_number AS ProductNumber,
        prd.cost AS Cost,
        prd.category AS Category,
        prd.subcategory AS Subcategory,
        sls.customer_key AS CustomerKey,
        sls.quantity AS Quantity,
        sls.sales_amount AS SalesAmount
    FROM [dbo].[fact_sales] AS sls 
    LEFT JOIN [dbo].[dim_products] AS prd
        ON sls.product_key = prd.product_key
),
AggredatedProductInfo AS (
    SELECT 
        ProductKey,
        ProductName,
        ProductNumber,
        Cost,
        Category,
        Subcategory,
        COUNT(DISTINCT CustomerKey) AS TotalCustomer,
        COUNT(DISTINCT OrderNumber) AS TotalOrder,
        SUM(Quantity) AS TotalQuantity,
        SUM(SalesAmount) AS TotalSales,
        DATEDIFF(MONTH, MIN(OrderDate), MAX(OrderDate))  AS LifeSpan,
        DATEDIFF(MONTH, MAX(OrderDate), GETDATE()) AS RecencyInMonth
    FROM MainTable
    GROUP BY 
        ProductKey,
        ProductName,
        ProductNumber,
        Cost,
        Category,
        Subcategory
),
ProductSegmentation AS (
    SELECT 
        ProductKey,

        CASE NTILE(3) OVER(ORDER BY TotalSales DESC)
            WHEN  1 THEN 'High Performer'
            WHEN  2 THEN 'Mid Performer'
            ELSE 'Low Performer'
        END AS ProductSegment

    FROM AggredatedProductInfo
)
SELECT 
    ap.cost,
    ap.ProductName,
    ap.ProductKey,
    ap.Category,
    ap.Subcategory,
    ap.LifeSpan,
    ap.RecencyInMonth,
    ap.TotalCustomer,
    ap.TotalOrder,
    ap.TotalQuantity,
    ap.TotalSales,
    ps.ProductSegment,
    ROUND(CAST(TotalSales AS FLOAT) / NULLIF(TotalOrder,0), 2) AS AvgOrderRevenue,
    ROUND(CAST(TotalSales AS FLOAT) / NULLIF(LifeSpan,0), 2) AS AvgMonthlyRevenue
FROM AggredatedProductInfo AS ap 
INNER JOIN ProductSegmentation AS ps 
    ON ps.ProductKey = ap.ProductKey
