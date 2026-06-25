# Sales Data Exploratory Analysis Using SQL

## Project Overview

This project focuses on performing Exploratory Data Analysis (EDA) on a retail sales dataset using SQL. The goal was to explore the database structure, understand customer and product behavior, analyze sales performance, and generate actionable business insights.

The analysis was conducted using SQL scripts organized into multiple exploration phases, allowing a systematic investigation of the dataset from different perspectives.

---

## Dataset Overview

The dataset consists of three tables following a star-schema-like structure:

### Dimension Tables

#### Customer

Contains customer-related information.

| Metric        | Value  |
| ------------- | ------ |
| Total Records | 18,484 |

#### Product

Contains product-related information.

| Metric        | Value |
| ------------- | ----- |
| Total Records | 295   |

### Fact Table

#### Sales

Stores transactional sales data and links customers with products.

| Metric        | Value  |
| ------------- | ------ |
| Total Records | 60,398 |

---

## Data Model

The project uses a simple dimensional model:

* **FactSales** → Stores sales transactions
* **DimCustomer** → Stores customer information
* **DimProduct** → Stores product information

Relationships:

* FactSales → CustomerKey → DimCustomer
* FactSales → ProductKey → DimProduct

---

## Analysis Phases

The exploratory analysis was divided into 12 phases:

### 1. Database Exploration
### 2. Dimension Exploration
### 3. Date Exploration
### 4. Measure Exploration
### 5. Magnitude Analysis
### 6. Ranking Analysis
### 7. Change Overtime
### 8. Cummulative Analysis
### 9. Performance Analysis
### 10. Part to Whole Analysis
### 11. Data Segmentation
---

## Key Business Insights

### Revenue Performance

* The business generated a total revenue of **$29.3 million** from **60,423 items sold**.
* The average selling price across all products was **$486**, indicating a relatively high-value product portfolio.

### Customer Activity

* All registered customers placed at least one order.

### Product Category Performance

* Bikes generated the majority of company revenue, contributing approximately **$28.3 million**.
* The average selling price of bikes was **$949**.
* Clothing and Accessories generated a combined revenue of approximately **$1 million**, making them the lowest-performing product categories.

### Customer Distribution

* The United States accounted for **40.4%** of all customers.
* Australia ranked second with **19.4%**.
* The United Kingdom ranked third with **10%**.

### Sales Distribution

* The United States accounted for **33.9%** of total items sold.
* Australia ranked second with **22%**.
* Canada ranked third with **12.6%**.

### Top Customers

The top three customers based on sales performance were:

1. Nichole Nara
2. Kaitlyn Henderson
3. Margaret He

---

## Technologies Used

* SQL
* Microsoft SQL Server Managment Studio (SSMS)
* GitHub

---

## Project Structure

```text
├── scripts
│   ├── 01_database_exploration.sql
│   ├── 02_dimension_exploration.sql
│   ├── 03_date_exploration.sql
│   ├── 04_measure_exploration.sql
│   ├── 05_magnitude_exploration.sql
│   └── 06_ranking_exploration.sql
│   ├── 07_change_ocertime_analysis.sql
│   ├── 08_cummulative_analysis.sql
│   ├── 09_performance_analysis.sql
│   ├── 10_part_to_whole_analysis.sql
│   ├── 11_data_segmentation.sql
│   └── 12_customer_report.sql
│   └── 13_product_report.sql
|
│
├── README.md
└── dataset
```

---

## Conclusion

This project demonstrates how SQL can be used to perform comprehensive exploratory data analysis on transactional sales data. Through structured exploration and analytical queries, valuable insights were uncovered regarding revenue generation, customer behavior, product performance, and regional sales trends.
