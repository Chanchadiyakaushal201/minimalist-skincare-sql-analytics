---

SELECT * FROM customers;

SELECT * FROM products;

SELECT * FROM orders;

SELECT * FROM order_items;

SELECT * FROM returns;

SELECT * FROM reviews;

---

-- (1) Retrieve all serum products.

-- SQL Concepts Used : SELECT, WHERE, Filtering

SELECT * 
FROM products
WHERE category = 'Serum';

-- (2) Find products with stock_qty below 150.

-- SQL Concepts Used : SELECT specific columns, WHERE, Comparison operator

SELECT product_id, 
	   product_name, 
	   category, 
	   stock_qty
FROM products
WHERE stock_qty < 150;

-- (3) List all customers from Gujarat.

-- SQL Concepts Used : SELECT, WHERE, Text filtering

SELECT *
FROM customers
WHERE state = 'Gujarat';

-- (4) Show all orders placed in October 2025.

-- SQL Concepts Used : WHERE, BETWEEN, ORDER BY, Date filtering

SELECT *
FROM orders
WHERE order_date BETWEEN '2025-10-01' AND '2025-10-31'
ORDER BY order_date;

-- (5) Calculate total revenue from delivered orders.

-- SQL Concepts Used : SUM(), WHERE, Aggregate function

SELECT sum(final_amount) AS total_revenue
FROM orders
WHERE order_status = 'Delivered';

-- (6) Find the most expensive product by MRP.

-- SQL Concepts Used : Subquery, MAX(), WHERE

SELECT product_id, 
	   product_name, 
	   category, mrp
FROM products
WHERE mrp = (SELECT MAX(mrp) FROM products);

-- (7) Show orders where final_amount is greater than ₹1500.

-- SQL Concepts Used : WHERE, Comparison operator

SELECT *
FROM orders
WHERE final_amount > 1500;

-- (8) List all product categories available.

-- SQL Concepts Used : DISTINCT

SELECT DISTINCT category
FROM products;

-- (9) Find the top 5 lowest-stock products and classify inventory status.

-- SQL Concepts Used : CASE, ORDER BY, LIMIT

SELECT product_id, 
	   product_name, 
	   category, 
	   stock_qty,
	   CASE
	   		WHEN stock_qty = 0 THEN 'Out of Stock'
			WHEN stock_qty <= 50 THEN 'Critical'
			WHEN stock_qty <= 110 THEN 'Low Stock'
			ELSE 'Healthy'
	   END AS inventory_status
FROM products
ORDER BY stock_qty
LIMIT 5;

-- (10) Count customers acquired from each acquisition channel.

-- SQL Concepts Used : COUNT(), GROUP BY, ORDER BY

SELECT acquisition_channel, 
	   COUNT(customer_id) AS total_customers
FROM customers
GROUP BY acquisition_channel
ORDER BY total_customers DESC;

-- (11) Calculate monthly revenue trend.

-- SQL Concepts Used : DATE_TRUNC(), TO_CHAR(), SUM(), GROUP BY, ORDER BY

SELECT TO_CHAR(DATE_TRUNC('month', order_date), 'FMMonth YYYY') AS month,
	   SUM(final_amount) AS total_revenue
FROM orders
WHERE order_status = 'Delivered'
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY DATE_TRUNC('month', order_date);
 
-- (12) Find top 5 cities by delivered revenue.

-- SQL Concepts Used : JOIN, SUM(), GROUP BY, ORDER BY, LIMIT

SELECT c.city, 
	   SUM(o.final_amount) AS revenue
FROM customers AS c
JOIN orders AS o
ON c.customer_id = o.customer_id
WHERE order_status = 'Delivered'
GROUP BY c.city
ORDER BY revenue DESC
LIMIT 5;

-- (13) Calculate total quantity sold by product category.

-- SQL Concepts Used : Multi-table JOIN, SUM(), GROUP BY

SELECT p.category, 
	   SUM(oi.quantity) AS total_quantity
FROM products AS p
JOIN order_items AS oi
ON p.product_id = oi.product_id
JOIN orders AS o
ON oi.order_id = o.order_id
WHERE order_status = 'Delivered'
GROUP BY 1
ORDER BY total_quantity DESC;

-- (14) Find repeat customers who placed more than 2 delivered orders.

-- SQL Concepts Used : JOIN, COUNT(), GROUP BY, HAVING, ORDER BY

SELECT c.customer_id, 
	   c.customer_name, 
	   COUNT(o.order_id) AS total_orders
FROM customers AS c
JOIN orders AS o
ON c.customer_id = o.customer_id
WHERE order_status = 'Delivered'
GROUP BY 1, 2
HAVING COUNT(o.order_id) > 2
ORDER BY total_orders DESC;

-- (15) Calculate average order value by sales_channel.

-- SQL Concepts Used : COUNT(), SUM(), AVG(), ROUND(), GROUP BY

SELECT sales_channel,
	   COUNT(order_id) AS total_orders,
	   SUM(final_amount) AS total_revenue,
	   ROUND(AVG(final_amount),2) AS avg_order_value
FROM orders
WHERE order_status = 'Delivered'
GROUP BY 1
ORDER BY avg_order_value DESC;

-- (16) Find top 10 products by revenue.

-- SQL Concepts Used : CTE, JOIN, SUM(), Window Function, Revenue Share, LIMIT

WITH product_sales AS (
	SELECT p.product_id, 
		   p.product_name, 
		   p.category,
		   SUM(oi.item_total) AS revenue
	FROM products AS p
	JOIN order_items AS oi
	ON p.product_id = oi.product_id
	JOIN orders AS o
	ON oi.order_id = o.order_id
	WHERE order_status = 'Delivered'
	GROUP BY 1, 2, 3
)
SELECT product_id, 
	   product_name, 
	   category, 
	   revenue,
	   ROUND((revenue / SUM(revenue) OVER()) * 100, 2) AS revenue_share_pct
FROM product_sales
ORDER BY revenue DESC
LIMIT 10;	

-- (17) Calculate return rate by product category.

-- SQL Concepts Used : JOIN, LEFT JOIN, CASE, SUM(), ROUND(), GROUP BY

SELECT p.category, 
	   SUM(oi.quantity) AS total_unit_sold,
	   SUM(CASE WHEN r.return_id IS NOT NULL THEN oi.quantity ELSE 0 END) AS units_returned,
	   ROUND(SUM(CASE WHEN r.return_id IS NOT NULL THEN oi.quantity ELSE 0 END)::numeric / SUM(oi.quantity) * 100, 2) AS return_rate_pct
FROM products AS p
JOIN order_items AS oi
ON p.product_id = oi.product_id
LEFT JOIN returns AS r
ON oi.order_id = r.order_id AND oi.product_id = r.product_id
GROUP BY p.category
ORDER BY return_rate_pct DESC;	   

-- (18) Find products with average rating above 4.2.

-- SQL Concepts Used : JOIN, COUNT(), AVG(), ROUND(), GROUP BY, HAVING

SELECT p.product_id, 
	   p.product_name, 
	   p.category,
	   COUNT(re.review_id) AS total_review,
	   ROUND(AVG(re.rating),2) AS avg_rating
FROM products AS p
JOIN reviews AS re
ON p.product_id = re.product_id
GROUP BY 1, 2, 3
HAVING AVG(re.rating) > 4.2
ORDER BY avg_rating DESC;

-- (19) Show revenue contribution by payment method.

-- SQL Concepts Used : SUM(), Window Function, Percentage Contribution, GROUP BY

SELECT payment_method,
	   SUM(final_amount) AS revenue,
	   ROUND((SUM(final_amount) / SUM(SUM(final_amount)) OVER()) * 100.0, 2) AS revenue_contribution_pct
FROM orders
WHERE order_status = 'Delivered'
GROUP BY payment_method
ORDER BY revenue DESC;

-- (20) Find customer acquisition month and first order month for each customer.

-- SQL Concepts Used : LEFT JOIN, MIN(), COALESCE(), TO_CHAR(), GROUP BY

SELECT c.customer_id, 
	   c.customer_name,
	   TO_CHAR(c.signup_date, 'FMMonth YYYY') AS acquisition_month,
	   COALESCE(TO_CHAR(MIN(o.order_date), 'FMMonth YYYY'),'No Order') AS first_order_month
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
GROUP BY 1, 2, 3
ORDER BY c.customer_id;

-- (21) Identify the top 3 revenue-generating products in each product category.

-- SQL Concepts Used : CTE, RANK(), PARTITION BY, Window Function

WITH product_revenue AS (
	SELECT p.category, 
		   p.product_name,
		   SUM(oi.item_total) AS revenue
		   FROM products AS p
		   JOIN order_items AS oi
		   ON p.product_id = oi.product_id
		   JOIN orders AS o
		   ON oi.order_id = o.order_id
		   WHERE order_status = 'Delivered'
		   GROUP BY 1, 2
),
ranked_product AS (
	SELECT *,
	RANK() OVER(PARTITION BY category ORDER BY revenue DESC) AS product_rank
	FROM product_revenue
)
SELECT *
FROM ranked_product
WHERE product_rank <= 3
ORDER BY 1;

-- (22) Analyze month-over-month revenue growth trends.

-- SQL Concepts Used : CTE, LAG(), Window Function, Month-over-Month Growth

WITH monthly_revenue AS (
	SELECT DATE_TRUNC('month', order_date) AS month_date,
	SUM(final_amount) AS total_revenue
	FROM orders
	WHERE order_status = 'Delivered'
	GROUP BY 1
),
revenue_with_lag AS (
	SELECT month_date, 
		   total_revenue,
		   LAG(total_revenue) OVER(ORDER BY month_date)AS prev_month_revenue
	FROM monthly_revenue
)
SELECT TO_CHAR(month_date, 'FMMonth YYYY') AS month,
	   total_revenue,
	   prev_month_revenue,
	   ROUND(COALESCE((total_revenue - prev_month_revenue) / prev_month_revenue * 100, 0), 2) AS growth_pct
FROM revenue_with_lag
ORDER BY month_date;

-- (23) Segment customers into High, Medium, and Low value groups based on total spend.

-- SQL Concepts Used : CTE, LEFT JOIN, COALESCE(), CASE, Customer Segmentation

WITH customer_spending AS (
	SELECT c.customer_id, 
		   c.customer_name,
		   COALESCE(SUM(o.final_amount), 0) AS total_spend
	FROM customers AS c
	LEFT JOIN orders AS o
	ON c.customer_id = o.customer_id AND order_status = 'Delivered'
	GROUP BY 1, 2
),
segments AS (
	SELECT customer_id, 
		   customer_name, 
		   total_spend,
		   CASE 
		   	   WHEN total_spend >= 6000 THEN 'High' 
		   	   WHEN total_spend >= 3000 THEN 'Medium'
			   ELSE 'Low'
		   END AS customer_segments
	FROM customer_spending
)
SELECT * 
FROM segments
ORDER BY total_spend DESC;

-- (24) Find existing customers inactive for more than 90 days since their last delivered order.

-- SQL Concepts Used : CTE, JOIN, MAX(), Date Difference, Inactive Customer Analysis

WITH latest_system_date AS (
	SELECT MAX(order_date) AS max_date
	FROM orders
),
customer_last_order AS (
	SELECT c.customer_id, 
		   c.customer_name,
		   MAX(o.order_date) AS last_order_date
	FROM customers AS c
	JOIN orders AS o
	ON c.customer_id = o.customer_id 
	WHERE order_status = 'Delivered'
	GROUP BY 1, 2
)
SELECT clo.customer_name,
	   clo.last_order_date,
	   (lsd.max_date - clo.last_order_date) AS days_since_last_order
FROM customer_last_order AS clo , latest_system_date AS lsd
WHERE (lsd.max_date - clo.last_order_date) > 90
ORDER BY days_since_last_order DESC;


-- (25) Calculate running total revenue by month.

-- SQL Concepts Used : CTE, SUM() OVER(), Running Total, Window Frame

WITH monthly_revenue AS (
	SELECT DATE_TRUNC('month', order_date) AS month_date,
		   SUM(final_amount) AS total_revenue
	FROM orders
	WHERE order_status = 'Delivered'
	GROUP BY 1
) 
SELECT TO_CHAR(month_date, 'FMMonth YYYY') AS month,
	   total_revenue,
	   SUM(total_revenue) OVER(ORDER BY month_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM monthly_revenue
ORDER BY month_date;

-- (26) Identify products with high return count but high sales volume.

-- SQL Concepts Used : CTE, JOIN, LEFT JOIN, CASE, Return Rate Analysis

WITH product_performance AS (
	SELECT p.product_id, 
		   p.product_name, 
		   p.category,
		   SUM(oi.quantity) AS total_units_sold,
		   SUM(CASE
		   			WHEN r.return_id IS NOT NULL THEN oi.quantity ELSE 0
			   END
		   ) AS total_units_returned	   
	FROM products AS p
	JOIN order_items AS oi
	ON p.product_id = oi.product_id
	LEFT JOIN returns AS r
	ON oi.order_id = r.order_id AND oi.product_id = r.product_id
	GROUP BY 1, 2, 3
) 
SELECT *,
	   ROUND((total_units_returned * 100.0 / total_units_sold), 2) AS return_rate_pct	   
FROM product_performance
WHERE total_units_sold > 100 AND  total_units_returned >= 5
ORDER BY total_units_returned DESC;

-- (27) Find best-selling product for each skin_type.

-- SQL Concepts Used : CTE, RANK(), PARTITION BY, Best-selling Product Analysis

WITH product_Sales AS (
	SELECT p.skin_type,
		   p.product_name, 
		   p.category,
		   SUM(oi.quantity) AS total_units_sold
	FROM products AS p
	JOIN order_items AS oi
	ON p.product_id = oi.product_id
	JOIN orders AS o
	ON oi.order_id = o.order_id
	WHERE order_status = 'Delivered'
	GROUP BY 1, 2, 3
),
ranked_product AS (
	SELECT *,
		   RANK() OVER(PARTITION BY skin_type ORDER BY total_units_sold DESC) AS product_rank
	FROm product_Sales
)
SELECT * 
FROM ranked_product
WHERE product_rank = 1
ORDER BY total_units_sold DESC;

-- (28) Analyze product-level gross margin and profitability.

-- SQL Concepts Used : CTE, JOIN, Gross Profit, Gross Margin %, Profitability Analysis

WITH product_margin AS (
	SELECT p.product_id,
		   p.product_name,
	       p.category,
		   SUM(oi.quantity) AS total_units_sold,
		   SUM(oi.item_total) AS total_revenue,
		   SUM(p.cost_price * oi.quantity) AS total_cost,
		   SUM(oi.item_total) - SUM(p.cost_price * oi.quantity) AS gross_profit
	FROM products AS p
	JOIN order_items AS oi
	ON p.product_id = oi.product_id
	JOIN orders AS o
	ON oi.order_id = o.order_id
	WHERE order_status = 'Delivered'
	GROUP BY 1, 2, 3
)
SELECT *,
	   ROUND((gross_profit / total_revenue) * 100, 2) AS gross_margin_pct
FROM product_margin
ORDER BY gross_margin_pct DESC;

-- (29) Build an RFM-style customer summary: recency, frequency, monetary value.

-- SQL Concepts Used : CTE, CROSS JOIN, MAX(), COUNT(DISTINCT), RFM Segmentation, CASE

WITH latest_date AS (
	SELECT MAX(order_date) AS max_order_date
	FROM orders
),
customer_rfm AS (
	SELECT c.customer_id,
		   c.customer_name,
		   MAX(o.order_date) AS last_order_date,
		   l.max_order_date - MAX(o.order_date) AS recency,
		   COUNT(DISTINCT o.order_id) AS frequency,
		   ROUND(SUM(o.final_amount), 2) AS monetary
	FROM customers AS c
	JOIN orders AS o
	ON c.customer_id = o.customer_id
	CROSS JOIN latest_date AS l
	WHERE order_status = 'Delivered'
	GROUP BY c.customer_id,
		     c.customer_name,
			 l.max_order_date
)
SELECT *,
	   CASE
	   		WHEN recency <= 30 AND frequency >= 5 AND monetary >= 5000 THEN 'Champion'
			WHEN recency <= 60 AND frequency >= 3 THEN 'Loyal Customer'
			WHEN recency > 120 THEN 'At Risk'
			ELSE 'Regular Customer'
	   END AS customer_segment
FROM customer_rfm
ORDER BY monetary DESC;

-- (30) Find which acquisition channel brings the highest average customer lifetime value.

-- SQL Concepts Used : CTE, JOIN, SUM(), AVG(), Customer Lifetime Value

WITH customer_lifetime_value AS (
	SELECT c.customer_id,
		   c.customer_name,
		   c.acquisition_channel,
		   ROUND(SUM(o.final_amount), 2) AS customer_ltv
	FROM customers AS c
	JOIN orders AS o
	ON c.customer_id = o.customer_id
	WHERE order_status = 'Delivered'
	GROUP BY 1, 2, 3
)
SELECT acquisition_channel,
	   COUNT(customer_id) AS total_customers,
	   ROUND(AVG(customer_ltv), 2) AS avg_customer_ltv
FROM customer_lifetime_value
GROUP BY acquisition_channel
ORDER BY avg_customer_ltv DESC;

---
