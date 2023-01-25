use `magist`;


# Basic exploration of the database



SELECT COUNT(order_id)
FROM orders;

SELECT order_status, COUNT(order_status) AS total
FROM orders
GROUP BY 1
ORDER BY total DESC;

SELECT MONTH(order_purchase_timestamp) AS moy, YEAR(order_purchase_timestamp) AS year__, COUNT(order_id)
FROM orders
GROUP BY 2,1
ORDER BY moy, year__ ASC;


SELECT COUNT(DISTINCT product_id)
FROM products;

SELECT product_category_name, COUNT(*)
FROM products
GROUP BY 1
ORDER BY 1 ASC;


SELECT COUNT(DISTINCT product_id)
FROM order_items;

SELECT payment_installments
FROM order_payments;

SELECT 
    order_id AS ID,
    payment_sequential AS sequential,
    payment_installments AS installments,
    payment_value AS value
FROM 
    order_payments
WHERE 
    order_id IN (
        SELECT 
            order_id
        FROM 
            order_payments
        WHERE 
            payment_sequential = 2)
ORDER BY
    ID, 
    sequential;



SELECT COUNT(*)
FROM product_category_name_translation;

SELECT DISTINCT(product_category_name), count(product_category_name)
FROM products
GROUP BY product_category_name
ORDER BY product_category_name DESC;

SELECT *
FROM order_payments;

SELECT *
FROM order_items;

SELECT *
FROM products;

SELECT *
FROM order_items
ORDER BY order_id;

SELECT *
FROM order_payments
ORDER BY order_id;


SELECT products.product_category_name, product_category_name_english, COUNT(*)
FROM products
JOIN product_category_name_translation
ON products.product_category_name = product_category_name_translation.product_category_name
GROUP BY 1
ORDER BY 3 DESC;


SELECT COUNT(DISTINCT YEAR(shipping_limit_date))
FROM order_items
ORDER BY 1 DESC;


SELECT products.product_id
FROM products 
WHERE product_category_name LIKE 'informatica_acessorios';

SELECT order_items.product_id, products.product_id, order_items.price
FROM order_items, products
WHERE products.product_category_name LIKE 'informatica_acessorios';


#AVERAGE TIME IN DAYS OF DELIVERY
SELECT AVG(DATEDIFF(order_delivered_customer_date, order_delivered_carrier_date)) AS average_date
FROM orders;

SELECT order_status, COUNT(DATEDIFF(order_estimated_delivery_date, order_delivered_customer_date)) AS on_time_or_not
FROM orders
GROUP BY 1
HAVING COUNT(DATEDIFF(order_estimated_delivery_date, order_delivered_customer_date)) LIKE 0;

SELECT *
FROM order_reviews;


# Creating a table where magist tech products will go:
CREATE TABLE 
    tech_products AS
SELECT 
    product_id,
    t.product_category_name_english AS product_category_name,
    product_name_length,
    product_description_length,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
FROM 
    products p
    INNER JOIN
    product_category_name_translation t
    ON p.product_category_name = t.product_category_name
WHERE 
    t.product_category_name_english IN
        ("computer_accessories",
        "telephony",
        "electronics",
        "computer",
        "audio",
        "console_games",
        "signaling_and_security");

SELECT distinct product_category_name
FROM tech_products;

SELECT *
FROM order_items;

SELECT product_category_name
FROM tech_products
WHERE product_category_name LIKE "computer_accessories";

SELECT *
FROM order_payments;


#How many items have been sold
SELECT COUNT(distinct order_items.product_id)
FROM order_items
JOIN tech_products
ON order_items.product_id = tech_products.product_id;

SELECT DATEDIFF(order_delivered_carrier_date, order_delivered_customer_date)
FROM orders
ORDER BY 1 DESC;
#-----------------------------------------------------------------------------


CREATE VIEW 
    tech_products AS
SELECT 
    product_id,
    t.product_category_name_english AS product_category_name,
    product_name_length,
    product_description_length,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
FROM 
    products p
    INNER JOIN
    product_category_name_translation t
    ON p.product_category_name = t.product_category_name
WHERE 
    t.product_category_name_english IN
        ("computers_accessories",
        "telephony",
        "electronics",
        "computers",
        "audio",
        "consoles_games",
        "signaling_and_security",
        "pc_gamer");
  

#How many items have been sold?        
SELECT COUNT(distinct order_items.product_id)
FROM order_items
JOIN tech_products
ON order_items.product_id = tech_products.product_id;
 
#Percetange from the total items sold? -- only 3.6% -- 3791/103886 = 0.036...
SELECT COUNT(*)
FROM order_payments;


#Average price of the items being sold from the total = 154 reals
SELECT ROUND(AVG(payment_value), 1)
FROM order_payments;


#Average price of the items being sold from the tech table = 
SELECT tech_products.product_category_name, ROUND(SUM(order_payments.payment_value), 1)
FROM tech_products
JOIN order_items
ON tech_products.product_id = order_items.product_id
JOIN order_payments
ON order_items.order_id = order_payments.order_id
GROUP BY 1;


#Are expensive tech items popular? 
SELECT tech_products.product_category_name, ROUND(SUM(order_payments.payment_value), 1)
FROM tech_products
LEFT JOIN order_items
ON tech_products.product_id = order_items.product_id
LEFT JOIN order_payments
ON order_items.order_id = order_payments.order_id
WHERE order_payments.payment_value > 780
GROUP BY 1
ORDER BY 2, 1;


#How many months of data are there in the magist DB?
SELECT COUNT(distinct MONTH(order_purchase_timestamp))
FROM orders;


#How many sellers are there? 
SELECT COUNT(*)
FROM sellers;


#How many Tech sellers are there?
SELECT COUNT(distinct sellers.seller_id)
FROM sellers
JOIN order_items
ON sellers.seller_id = order_items.seller_id
JOIN tech_products
ON order_items.product_id = tech_products.product_id;


#What percentage of overall sellers are Tech sellers?
SELECT ROUND((SELECT COUNT(distinct sellers.seller_id)
FROM sellers
JOIN order_items
ON sellers.seller_id = order_items.seller_id
JOIN tech_products
ON order_items.product_id = tech_products.product_id)
/
(SELECT COUNT(*)
FROM sellers)*100, 1);


#What is the total amount earned by all sellers?
SELECT  ROUND(SUM(order_payments.payment_value),1)
FROM order_payments
JOIN order_items
ON order_payments.order_id = order_items.order_id
JOIN sellers
ON order_items.seller_id = sellers.seller_id;


#What is the total amount earned by all Tech sellers?
SELECT ROUND(SUM(order_payments.payment_value),1)
FROM order_payments
JOIN order_items
ON order_payments.order_id = order_items.order_id
JOIN sellers
ON order_items.seller_id = sellers.seller_id;


SELECT *
FROM tech_products;
SELECT *
FROM order_items;
SELECT *
FROM order_payments;
SELECT *
FROM sellers;
SELECT *
FROM orders
JOIN order_payments
ON orders.order_id = order_payments.payment_id
WHERE (order_status NOT LIKE 'canceled' 
AND order_status NOT LIKE 'unavailable' 
AND order_status NOT LIKE 'created' 
AND order_status NOT LIKE 'processing');


#What’s the average time between the order being placed and the product being delivered?
SELECT AVG(DATEDIFF(order_delivered_customer_date, order_delivered_carrier_date)) AS average_date
FROM orders;

#How many orders are delivered on time vs orders delivered with a delay?
SELECT DATEDIFF(order_delivered_customer_date, order_delivered_carrier_date) AS on_time_or_not, order_status, COUNT(*)
FROM orders
WHERE order_status LIKE 'delivered' AND
DATEDIFF(order_delivered_customer_date, order_delivered_carrier_date) = 0
GROUP BY 1,2;

SELECT *
FROM order_reviews
LEFT JOIN order_items
ON order_reviews.order_id = order_items.order_id
JOIN tech_products
ON order_items.product_id = tech_products.product_id
WHERE order_reviews.review_score >= 4
LIMIT 50;

SELECT order_items.order_id, COUNT(tech_products.product_id),order_items.price
FROM order_reviews
JOIN order_items
ON order_reviews.order_id = order_items.order_id
JOIN tech_products
ON order_items.product_id = tech_products.product_id
WHERE order_reviews.review_score >= 4
AND order_items.price > 760
GROUP BY 1, 3
ORDER BY 3 DESC;


SELECT tech_products.product_category_name, ROUND(SUM(order_payments.payment_value), 1),order_items.price,
(SELECT COUNT(tech_products.product_id)
	FROM order_reviews
	JOIN order_items
		ON order_reviews.order_id = order_items.order_id
	JOIN tech_products
		ON order_items.product_id = tech_products.product_id
	WHERE order_reviews.review_score >= 4
	#AND order_items.price > 760
	)
FROM tech_products
LEFT JOIN order_items
ON tech_products.product_id = order_items.product_id
LEFT JOIN order_payments
ON order_items.order_id = order_payments.order_id
WHERE order_payments.payment_value > 780
GROUP BY 1,3
ORDER BY 2, 1;

SELECT MONTH(order_purchase_timestamp) AS moy, YEAR(order_purchase_timestamp) AS year__, COUNT(order_id)
FROM orders
GROUP BY 2,1
ORDER BY moy, year__ ASC;


SELECT COUNT(order_id), order_status
FROM orders
WHERE order_purchase_timestamp > '2018-10-01'
GROUP BY 2;