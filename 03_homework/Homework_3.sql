SELECT vendor_id, COUNT(*) AS booth_count
FROM vendor_booth_assignments
GROUP BY vendor_id;

SELECT customer.customer_id, 
       customer.customer_first_name, 
       customer.customer_last_name, 
       SUM(customer_purchases.quantity * customer_purchases.cost_to_customer_per_qty) AS total_spent
FROM customer
JOIN customer_purchases ON customer.customer_id = customer_purchases.customer_id
GROUP BY customer.customer_id, customer.customer_first_name, customer.customer_last_name
HAVING SUM(customer_purchases.quantity * customer_purchases.cost_to_customer_per_qty) > 2000
ORDER BY customer.customer_last_name, customer.customer_first_name;



DROP TABLE IF EXISTS temp.new_vendor;
CREATE TABLE temp.new_vendor AS
SELECT *
FROM vendor;
INSERT INTO temp.new_vendor (vendor_id, vendor_name, vendor_type, vendor_owner_first_name, vendor_owner_last_name)
VALUES (10, 'Thomass Superfood Store', 'Fresh Focused', 'Thomas', 'Rosenthal');

SELECT customer_id, 
       STRFTIME('%m', market_date) AS month, 
       STRFTIME('%Y', market_date) AS year
FROM customer_purchases;

SELECT customer_id, 
       SUM(quantity * cost_to_customer_per_qty) AS total_spent
FROM customer_purchases
WHERE STRFTIME('%m', market_date) = '04' 
  AND STRFTIME('%Y', market_date) = '2019'
GROUP BY customer_id
