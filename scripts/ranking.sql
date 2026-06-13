-----------------------------------------------------------
-------------------- Ranking Analysis ---------------------
-----------------------------------------------------------

-- TOP 5 PRODUCTS WHICH GENERATES HIGHER TOTAL REVENUE

SELECT TOP 5
	product_name AS ProdductName,
	TotalRevenue,
	RANK() OVER (ORDER BY TotalRevenue DESC) AS [Rank]
FROM (
SELECT 
	prd.product_name,
	SUM(sls.price * sls.quantity) AS TotalRevenue
FROM [dbo].[fact_sales] AS sls
LEFT JOIN [dbo].[dim_products] AS prd
	ON sls.product_key = prd.product_key
GROUP BY prd.product_name ) t

-- 5 WOREST PERFORMING PRODUCTS IN TERMS OF SALES
SELECT TOP 5
	prd.product_name AS ProductName,
	SUM(sls.sales_amount) AS TotalSales,
	RANK() OVER (ORDER BY SUM(sls.sales_amount) ASC) AS [Rank]
FROM [dbo].[fact_sales] AS sls
LEFT JOIN [dbo].[dim_products] AS prd
	ON sls.product_key = prd.product_key
GROUP BY prd.product_name
