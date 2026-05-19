--- IMPORT DATA ---

-- customers

COPY customers (customer_id,customer_name,city,state,gender,age_group,signup_date,acquisition_channel)
FROM 'D:\Data Analytics\SQL\Minimalist Skincare SQL Project\Customers.csv'
DELIMITER ','
CSV HEADER

-- products

COPY products (product_id,product_name,category,concern,skin_type,key_ingredient,size,mrp,cost_price,stock_qty,launch_date)
FROM 'D:\Data Analytics\SQL\Minimalist Skincare SQL Project\Products.csv'
DELIMITER ','
CSV HEADER

-- orders

COPY orders (order_id,customer_id,order_date,order_status,payment_method,sales_channel,gross_amount,discount_amount,shipping_fee,final_amount,delivered_date)
FROM 'D:\Data Analytics\SQL\Minimalist Skincare SQL Project\Orders.csv'
DELIMITER ','
CSV HEADER

-- order_items

COPY order_items (order_item_id,order_id,product_id,quantity,unit_price,discount_pct,item_total)
FROM 'D:\Data Analytics\SQL\Minimalist Skincare SQL Project\Order_Items.csv'
DELIMITER ','
CSV HEADER

-- returns

COPY returns (return_id,order_id,product_id,return_date,return_reason,refund_status)
FROM 'D:\Data Analytics\SQL\Minimalist Skincare SQL Project\Returns.csv'
DELIMITER ','
CSV HEADER

-- reviews

COPY reviews (review_id,customer_id,product_id,order_id,rating,review_date)
FROM 'D:\Data Analytics\SQL\Minimalist Skincare SQL Project\Reviews.csv'
DELIMITER ','
CSV HEADER

---