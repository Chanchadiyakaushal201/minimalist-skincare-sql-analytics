--- DATABASE ---

CREATE DATABASE minimalist_skincare_db;

--- TABLES ---

-- customers

CREATE TABLE customers
(
	customer_id varchar(10) PRIMARY KEY,
	customer_name varchar(50),
	city varchar(50),
	state varchar(50),
	gender varchar(20),
	age_group varchar(10),
	signup_date date,
	acquisition_channel varchar(20)
);

-- products

CREATE TABLE products
(
	product_id varchar(10) PRIMARY KEY,
	product_name varchar(150),
	category varchar(50),
	concern varchar(50),
	skin_type varchar(50),
	key_ingredient varchar(50),
	size varchar(10),
	mrp numeric(10,2),
	cost_price numeric(10,2),
	stock_qty int,
	launch_date date
);

-- orders

CREATE TABLE orders
(
	order_id varchar(10) PRIMARY KEY,
	customer_id varchar(10),
	order_date date,
	order_status varchar(20),
	payment_method varchar(30),
	sales_channel varchar(30),
	gross_amount numeric(10,2),
	discount_amount numeric(10,2),
	shipping_fee numeric(10,2),
	final_amount numeric(10,2),
	delivered_date date,
	CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- order_items

CREATE TABLE order_items
(
	order_item_id varchar(15) PRIMARY KEY,
	order_id varchar(10),
	product_id varchar(10),
	quantity int,
	unit_price numeric(10,2),
	discount_pct numeric(5,2),
	item_total numeric(10,2),
	CONSTRAINT fk_orderitems_order FOREIGN KEY (order_id) REFERENCES orders(order_id),
	CONSTRAINT fk_orderitems_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- returns

CREATE TABLE returns
(
	return_id varchar(10) PRIMARY KEY,
	order_id varchar(10),
	product_id varchar(10),
	return_date date,
	return_reason varchar(100),
	refund_status varchar(50),
	CONSTRAINT fk_returns_order FOREIGN KEY (order_id) REFERENCES orders(order_id),
	CONSTRAINT fk_returns_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- reviews
 
CREATE TABLE reviews
(
	review_id varchar(10) PRIMARY KEY,
	customer_id varchar(10),
	product_id varchar(10),
	order_id varchar(10),
	rating int,
	review_date date,
	CONSTRAINT fk_reviews_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
	CONSTRAINT fk_reviews_product FOREIGN KEY (product_id) REFERENCES products(product_id),
	CONSTRAINT fk_reviews_order FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

---