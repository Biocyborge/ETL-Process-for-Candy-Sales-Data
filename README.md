# ETL Process for Candy Sales Data

This project demonstrates the **Extract-Transform-Load (ETL)** process using SQL, specifically applied to candy sales data. The goal is to simulate a real-world data pipeline where we extract raw sales data, transform it into insightful features, and load it into a structured database for analysis.

The customer 
## Project Overview
The project is divided into three main stages:

1. **Extract with partial Transform**: 
   - We begin by extracting raw candy sales data from external sources (CSV file). This data includes various transactional information such as dates, product types, quantities, and prices.
   - Partial transformations were done due to the dependencies of fields such as creating new variables
   - The extracted data is loaded into a SQL-based relational database. The data is organized into structured tables with proper names and dependencies, such as:
     - `business_unit` the table that describes the business purpose of a product.
     - `orders_bu` this is the raw sales data from 2017-2019.
     - `product_bu` table that links .
     - `prod_order_bu` serves as a bridge table for `product_bu` and order `order_bu` when 'ORYear' and 'Prod_BU_Year' are the same.
     - 'product_desc_bu' serves as a bridge table for `business_unit` and `product_bu` when 'BU_Name' is the same.
     - While extracting the data from the CSV, table calcaluations are preformed on specific variables
2. **Transform**: 
   - Once the data is extracted, the transformation stage cleans and processes the raw data. Key transformations include but no limited to:
     - Adding primary and foreign key constraints
     - calculated PPU, order total, order discount
     - ordered results by the the year
3. **Load**:
    - Once the proper transformations were made to the tables and the respective fields, a view was creeated including:
      - BUDesignation
      - BUName
      - Product
      - Year
      - AVG PPU
      - AVG sum of ther  order
      - AVG order total
    - For ease of querying the results were ordered by:
      - BUDesignation
      - BUName
      - Product
      - Year
       
  


## Key Features
- SQL-based implementation using **Joins**, **CTEs**, **Subqueries**, and **Window Functions**.
- Creation of normalized tables with **referential integrity** (primary and foreign keys).
- Data aggregation and transformation using SQL functions.
- Sample data for candy sales, including date-based, regional, and product-based insights.

## Technologies Used
- SQL (MS SQL Server)
- ETL process design and optimization
- Data modeling (Star Schema, Snowflake Schema)

## How to Use
1. Clone the repository.
2. Set up your preferred SQL environment (PostgreSQL, MySQL, etc.).
3. Run the SQL scripts to create the necessary tables and load the data.
4. Use the provided queries to explore the data and gain insights into candy sales trends.
