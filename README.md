# Minimalist Skincare SQL Analytics Project

## Project Overview

This project is a business-focused SQL analytics case study built using PostgreSQL for a D2C skincare brand inspired by Minimalist India.  
The objective of this project is to analyze sales performance, customer behavior, product profitability, return patterns, customer segmentation, and marketing channel effectiveness using structured SQL queries.

The project simulates real-world e-commerce business analysis and demonstrates practical SQL skills used by Data Analysts.

---

# Business Problem

The brand wants to understand:

- Which products generate the highest revenue
- Which products have high return rates
- Which acquisition channels bring valuable customers
- Which customers are inactive or at risk
- Which products are most profitable
- How revenue is growing month-over-month
- Which products perform best for different skin types

This analysis helps improve:
- Marketing strategy
- Customer retention
- Product performance
- Profitability analysis
- Inventory planning
- Business decision-making

---

# Tools Used

- PostgreSQL
- pgAdmin 4
- SQL
- CSV Datasets
- GitHub

---

# Dataset Overview

The project uses multiple relational tables to simulate a real e-commerce skincare business database.

### Tables Used

| Table Name | Description |
|---|---|
| customers | Customer information and acquisition details |
| products | Product catalog and pricing details |
| orders | Order-level transaction data |
| order_items | Product-level order details |
| reviews | Product ratings and reviews |
| returns | Returned product information |

---

# Database Schema

The database follows a relational structure using primary keys and foreign keys.

### Key Relationships

- customers → orders
- orders → order_items
- products → order_items
- products → reviews
- order_items → returns

---

# SQL Concepts Used

This project demonstrates:

- Filtering & Sorting
- Aggregate Functions
- GROUP BY & HAVING
- CASE Statements
- JOINS & LEFT JOINS
- Subqueries
- Common Table Expressions (CTEs)
- Window Functions
- RANK()
- LAG()
- Running Totals
- Customer Segmentation
- RFM Analysis
- Profitability Analysis
- Revenue Contribution Analysis

---

# Business Questions Solved

## Basic Analysis
1. Retrieve all serum products.
2. Find products with stock_qty below 150.
3. List all customers from Gujarat.
4. Show all orders placed in October 2025.
5. Calculate total revenue from delivered orders.
6. Find the most expensive product by MRP.
7. Show orders where final_amount is greater than ₹1500.
8. List all product categories available.
9. Find the top 5 lowest-stock products and classify inventory status.
10. Count customers acquired from each acquisition channel.

## Intermediate Analysis
11. Calculate monthly revenue trend.
12. Find top 5 cities by delivered revenue.
13. Calculate total quantity sold by product category.
14. Find repeat customers who placed more than 2 delivered orders.
15. Calculate average order value by sales_channel.
16. Find top 10 products by revenue.
17. Calculate return rate by product category.
18. Find products with average rating above 4.2.
19. Show revenue contribution by payment method.
20. Find customer acquisition month and first order month for each customer.

## Advanced Analysis
21. Identify the top 3 revenue-generating products in each product category.
22. Analyze month-over-month revenue growth trends.
23. Segment customers into High, Medium, and Low value groups based on total spend.
24. Find customers inactive for the last 90 days from the latest order date in the dataset.
25. Calculate running total revenue by month.
26. Identify products with high return count but high sales volume.
27. Find best-selling product for each skin_type.
28. Analyze product-level gross margin and profitability.
29. Build an RFM-style customer summary: recency, frequency, monetary value.
30. Find which acquisition channel brings the highest average customer lifetime value.

---

# Key Business Insights

- Serum products dominated overall revenue performance, with Alpha Arbutin 2% Serum generating the highest revenue contribution among all products.
- Revenue trends showed major growth spikes during August 2024, October 2024, and October 2025, indicating possible festive season or promotional campaign impact.
- Month-over-month revenue analysis revealed strong volatility, with some months showing over 100% growth while others experienced sharp declines, highlighting seasonal purchasing behavior.
- Body Care and Serum categories showed the highest return rates, suggesting potential product expectation gaps or quality-related concerns.
- Lip Balm SPF 30 achieved the highest gross margin percentage (~59%), making it one of the most profitable products in the portfolio.
- Referral acquisition channel generated the highest average customer lifetime value, indicating stronger customer quality compared to other marketing channels.
- RFM analysis identified multiple “At Risk” customers with historically high monetary value, highlighting opportunities for retention and re-engagement campaigns.
- Alpha Arbutin 2% Serum and Ceramide Moisturizer showed both high sales volume and elevated return counts, requiring deeper product-performance investigation.
- Product preference analysis showed that different skin types favored different products, helping support targeted skincare recommendations and personalized marketing strategies.

---

# Project Structure

```text
Minimalist-Skincare-SQL-Analytics/
│
├── data/
│   ├── customers.csv
│   ├── products.csv
│   ├── orders.csv
│   ├── order_items.csv
│   ├── reviews.csv
│   └── returns.csv
│
├── sql/
│   ├── create_tables.sql
│   ├── import_data.sql
│   └── business_queries.sql
│
├── images/
```

---

## How to Run This Project

1. Create database in PostgreSQL
2. Run table creation scripts
3. Import CSV datasets
4. Execute business queries

---

# Project Snapshots

## Database Schema
<img src="https://github.com/Chanchadiyakaushal201/minimalist-skincare-sql-analytics/blob/25b819052e87d14b3f01e4cea9142dbf65c99883/Images/Database_Schema.png" alt="Image Description" width="600">

## Top Revenue-Generating Products
<img src="https://github.com/Chanchadiyakaushal201/minimalist-skincare-sql-analytics/blob/32ee3a77b5cd41d0b273c37751072b59db293231/Images/top_revenue_products.png" alt="Image Description" width="600">

## High Sales + High Return Products
<img src="https://github.com/Chanchadiyakaushal201/minimalist-skincare-sql-analytics/blob/32ee3a77b5cd41d0b273c37751072b59db293231/Images/high_sales_high_returns.png" alt="Image Description" width="600">

## Month-over-Month Revenue Growth
<img src="https://github.com/Chanchadiyakaushal201/minimalist-skincare-sql-analytics/blob/32ee3a77b5cd41d0b273c37751072b59db293231/Images/mom_revenue_growth.png" alt="Image Description" width="600">

## Gross Margin Analysis
<img src="https://github.com/Chanchadiyakaushal201/minimalist-skincare-sql-analytics/blob/32ee3a77b5cd41d0b273c37751072b59db293231/Images/gross_margin_analysis.png" alt="Image Description" width="600">

## RFM Customer Segmentation
<img src="https://github.com/Chanchadiyakaushal201/minimalist-skincare-sql-analytics/blob/32ee3a77b5cd41d0b273c37751072b59db293231/Images/rfm_customer_segmentation.png" alt="Image Description" width="600">

## Acquisition Channel CLV
<img src="https://github.com/Chanchadiyakaushal201/minimalist-skincare-sql-analytics/blob/32ee3a77b5cd41d0b273c37751072b59db293231/Images/channel_clv_analysis.png" alt="Image Description" width="600">

---

# Dataset

The synthetic D2C skincare analytics dataset used in this project is available on Kaggle.

🔗 Kaggle Dataset:

https://www.kaggle.com/datasets/your-link

---

# Disclaimer

This dataset is synthetic and created for SQL portfolio. It is inspired by a D2C skincare e-commerce business model and is not official Minimalist company data.

---

# Author

**Kaushal**

---

# 🔗 Connect with Me

Linkedin :

https://www.linkedin.com/in/kaushal-chanchadiya-57199b2a8/

---

