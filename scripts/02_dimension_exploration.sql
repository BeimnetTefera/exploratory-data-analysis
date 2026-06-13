----------------------------------------------------
------------ DIMENCTION EXPLORATION  ---------------
----------------------------------------------------
-- HELPS US TO UNDERSTAND THE GRANULARITY OF EACH COLLUMN

	--- EXPLORE CUSTOMER TABLE ---
SELECT *
FROM [dbo].[dim_customers]

-- EXPLORE ALL COUNTRIES THE CUSTOMERS COME FROM
SELECT 
	DISTINCT country
FROM [dbo].[dim_customers]

-- EXPLORE THE GENDER OF CUSTOMERS
SELECT 
	DISTINCT gender
FROM [dbo].[dim_customers]


	--- EXPLORE PRODUCT TABLE ---
SELECT *
FROM [dbo].[dim_products]

-- EXPLORE ALL PRODUCT CATEGORY
SELECT 
	DISTINCT category
FROM [dbo].[dim_products]

-- EXPLORE ALL PRODUCT SUBCATEGORY
SELECT 
	DISTINCT subcategory
FROM [dbo].[dim_products]

-- EXPLORE ALL PRODUCT LINE
SELECT 
	DISTINCT product_line
FROM [dbo].[dim_products]

-- EXPLORE ALL PRODUCT MAINTENANCE
SELECT
	DISTINCT maintenance
FROM [dbo].[dim_products]

-- SEE THE BIG PICTURE OF PRODUCT TABLE 
SELECT 
	DISTINCT category, subcategory, product_name
FROM [dbo].[dim_products]
ORDER BY category, subcategory, product_name
