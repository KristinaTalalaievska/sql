 -- COALESCE
SELECT 
  COALESCE(product_name, ' ') || ' , ' ||  
  COALESCE(product_size, ' ' ) || ' ( ' || 
  COALESCE(product_qty_type, 'unit' )  || ' ) '
FROM product;

-- Windowed Functions
--2.1
SELECT customer_id, market_date,
ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date) AS visit_number

FROM customer_purchases

GROUP BY customer_id, market_date
ORDER BY customer_id, market_date


--2.2 
SELECT 
    customer_id 
    market_date, 
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date) AS visit_number
FROM customer_purchases;
WITH ReversedVisits AS (
    SELECT 
      customer_id,
      market_date, 
       ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date DESC) AS reversed_visit_number
    FROM customer_purchases
	)
	SELECT
	customer_id,
	market_date
	FROM ReversedVisits
	WHERE reversed_visit_number = 1;
 
 --2.3
SELECT 
    customer_id,
    product_id,
    market_date,
    quantity,
    cost_to_customer_per_qty,
count (*) OVER (PARTITION BY customer_id, product_id) AS 
quantity

from customer_purchases

--String manipulation

SELECT
product_name,
CASE WHEN instr ( product_name, '-') >
0 THEN
trim (substr (product_name, instr (product_name, '-') +1))
ELSE NULL
END AS product_category
from product

—UNION

WITH TotalSales AS (
    SELECT 
        market_date, 
        SUM(quantity * cost_to_customer_per_qty) AS total_sales
    FROM customer_purchases
    GROUP BY market_date
),
RankedSales AS (
    SELECT 
        market_date,
        total_sales,
        RANK() OVER (ORDER BY total_sales DESC) AS sales_rank_desc,
        RANK() OVER (ORDER BY total_sales ASC) AS sales_rank_asc
    FROM TotalSales
)
SELECT 
    market_date,
    total_sales,
    'Highest Sales' AS sales_type
FROM RankedSales
WHERE sales_rank_desc = 1

UNION

SELECT 
    market_date,
    total_sales,
    'Lowest Sales' AS sales_type
FROM RankedSales
WHERE sales_rank_asc = 1;
