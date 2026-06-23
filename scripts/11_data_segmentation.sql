-- Segment Products into cost range and 
-- count how many prducts fall in each segments
WITH productRange AS (
    SELECT 
        product_name,
        cost,
        CASE 
            WHEN cost < 100 THEN 'Below 100'
            WHEN cost BETWEEN 100 AND 500 THEN '100 - 500'
            WHEN cost BETWEEN 500 AND 1000 THEN '500 - 1000'
            ELSE 'Above 1000'
        END AS CostRange
    FROM [dbo].[dim_products]
)
SELECT 
    CostRange,
    COUNT(*) AS TotalProducts
FROM productRange
GROUP BY CostRange
ORDER BY TotalProducts DESC

/* 
    Group Customer into Three Segments based on their spending behaviour
        VIP - Customer with atleast 12 month history and spending morethan 5000
        Regular - Customer with atleast 12 month history and spending  5000 or less
        New - Customer with life span 12 months
    and find total number of customer in each group
*/
WITH CustomerInfo AS (
    SELECT 
        cust.customer_key AS CustomerKey,
        CONCAT(cust.first_name,' ' ,cust.last_name) AS FullName,
        SUM(sales_amount) AS TotalSpend,
        MIN(order_date) AS FirstOrder,
        MAX(order_date) AS LastOrder,
        DATEDIFF(MONTH,  MIN(order_date), MAX(order_date)) AS OrderSpan
    FROM [dbo].[dim_customers] AS cust
    INNER JOIN [dbo].[fact_sales] AS sls
        ON sls.customer_key = cust.customer_key
    GROUP BY 
        CONCAT(cust.first_name,' ' ,cust.last_name), 
        cust.customer_key
),
CustomerSegment AS (
    SELECT 
        CustomerKey,
        FullName,
        TotalSpend,
        OrderSpan,
        CASE 
            WHEN OrderSpan >= 12 AND TotalSpend > 5000 THEN 'VIP'
            WHEN OrderSpan >= 12 AND TotalSpend <= 5000 THEN 'Regular'
            ELSE 'New'
        END AS CustomerSegment
    FROM CustomerInfo
)
SELECT
    CustomerSegment,
    COUNT(*) AS TotalCustomer
FROM CustomerSegment
GROUP BY CustomerSegment
ORDER BY TotalCustomer DESC
