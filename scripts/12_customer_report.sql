/*
===============================================================================
Customer Report
===============================================================================
Purpose:
    - This report consolidates key customer metrics and behaviors

Highlights:
    1. Gathers essential fields such as names, ages, and transaction details.
	  2. Segments customers into categories (VIP, Regular, New) and age groups.
    3. Aggregates customer-level metrics:
	   - total orders
	   - total sales
	   - total quantity purchased
	   - total products
	   - lifespan (in months)
    4. Calculates valuable KPIs:
	    - recency (months since last order)
		  - average order value
		  - average monthly spend
===============================================================================
*/
WITH MainTable AS (
/*---------------------------------------------------------------------------
1) Base Query: Retrieves core columns from tables
---------------------------------------------------------------------------*/
    SELECT 
        cust.customer_key AS CustomerKey,
        CONCAT (cust.first_name, ' ', cust.last_name) AS FullName,
        DATEDIFF(YEAR, cust.birthdate, GETDATE()) AS Age,
        sls.sales_amount AS SalesAmount,
        sls.order_date AS OrderDate,
        sls.quantity AS Quantity,
        sls.product_key AS ProductKey,
        sls.order_number AS OrderNumber
    FROM [dbo].[fact_sales] AS sls 
    LEFT JOIN [dbo].[dim_customers]  AS cust 
        ON sls.customer_key = cust.customer_key
),
/*---------------------------------------------------------------------------
2) Customer Aggregations: Summarizes key metrics at the customer level
---------------------------------------------------------------------------*/
CustomerInfo AS (
    SELECT 
        CustomerKey,
        FullName,
        Age,
        SUM(SalesAmount) AS TotalSpend,
        MIN(OrderDate) AS FirstOrder,
        MAX(OrderDate) AS LastOrder,
        DATEDIFF(MONTH, MIN(OrderDate), MAX(OrderDate)) AS OrderSpan,
        SUM(Quantity) AS TotalQuantity,
        COUNT(DISTINCT ProductKey) AS TotalProduct,
        COUNT(DISTINCT OrderNumber) as TotalOrder,
        DATEDIFF(MONTH, MAX(OrderDate), GETDATE()) AS LastOrderSpan
    FROM MainTable
    GROUP BY CustomerKey, FullName, Age
),
/*---------------------------------------------------------------------------
3) Customer Segmentation: Segment Customer in to different levels
---------------------------------------------------------------------------*/
CustomerSegmentation AS (
    SELECT 
        CustomerKey,
        -- Compute Age Group
        CASE 
            WHEN age < 20 THEN 'Under 20'
            WHEN age between 20 and 29 THEN '20-29'
            WHEN age between 30 and 39 THEN '30-39'
            WHEN age between 40 and 49 THEN '40-49'
            ELSE '50 and above'
        END AS AgeGroup,
        -- Compute Customer Segmentation
        CASE 
            WHEN OrderSpan >= 12 AND TotalSpend > 5000 THEN 'VIP'
            WHEN OrderSpan >= 12 AND TotalSpend <= 5000 THEN 'Regular'
            ELSE 'New'
        END AS CustomerSegment,
        -- Average Order Value
        CASE 
            WHEN TotalOrder = 0 THEN 0
            ELSE TotalSpend / TotalOrder
        END AS AvgOrderValue,
        -- Compute Average Monthly Order
        CASE 
            WHEN OrderSpan = 0 THEN TotalSpend
            ELSE TotalSpend / OrderSpan
        END AS AvgSpendPerMonthLifetime
    FROM CustomerInfo
)
SELECT 
    FullName,
    Age,
    AgeGroup,
    TotalSpend,
    TotalQuantity,
    TotalProduct,
    TotalOrder,
    AvgOrderValue,
    AvgSpendPerMonthLifetime,
    OrderSpan,
    LastOrderSpan,
    CustomerSegment
FROM CustomerInfo AS ci
INNER JOIN CustomerSegmentation AS cs
    ON ci.CustomerKey = cs.CustomerKey
ORDER BY 
    TotalSpend DESC
