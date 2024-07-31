USE BikeStoreDB;

SELECT * FROM production.brands; 
SELECT * FROM production.categories;
SELECT * FROM production.products;
SELECT * FROM production.stocks;
SELECT * FROM sales.customers;
SELECT * FROM sales.order_items;
SELECT * FROM sales.orders;
SELECT * FROM sales.staffs;
SELECT * FROM sales.stores;


SELECT 
	orders.order_id, 
	CONCAT (customers.first_name,' ', customers.last_name) AS Name , 
	customers.city, customers.state, order_date, 
	SUM(items.quantity) AS Total_units, 
	SUM(items.quantity * items.list_price) AS Revenue,
	product_name,
	category_name,
	store_name,
	CONCAT(staff.first_name,' ', staff.last_name) AS SalesRep
From sales.customers AS customers 
JOIN 
sales.orders AS orders
ON customers.customer_id = orders.customer_id 
JOIN 
sales.order_items AS items 
ON items.order_id = orders.order_id
JOIN
production.products AS product
ON product.product_id = items.product_id
JOIN
production.categories AS cat
ON cat.category_id = product.brand_id 
JOIN
sales.stores AS store
ON store.store_id = orders.store_id
JOIN
sales.staffs AS staff
ON staff.staff_id = orders.staff_id
GROUP BY
orders.order_id, CONCAT (customers.first_name,' ', customers.last_name), customers.city, customers.state, order_date, product_name, category_name,
	store_name, CONCAT(staff.first_name,' ', staff.last_name)

	