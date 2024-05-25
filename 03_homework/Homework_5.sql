SELECT
    vendor_name,
    product_name,
    5 * original_price AS total_revenue
FROM
    vendor_inventory
JOIN
    vendor ON vendor_name = vendor_name
JOIN
    product ON  product_name = product_name
ORDER BY
    vendor_name,
    product_name;


DROP TABLE IF EXISTS product_units;
CREATE TABLE product_units AS
SELECT 
    *,
    CURRENT_TIMESTAMP AS snapshot_timestamp
FROM 
    product
WHERE 
    product_qty_type = 'unit';
INSERT INTO product_units (product_id, product_name, product_category_id, product_size, product_qty_type, snapshot_timestamp)
VALUES 
    (1234, 'Sample Product', 'unit', 9.99, 'unit', CURRENT_TIMESTAMP);


DELETE FROM product_units
WHERE product_name = 'Sample Product'
  AND snapshot_timestamp < (SELECT MAX(snapshot_timestamp) 
                            FROM product_units 
                            WHERE product_name = 'Sample Product');

ALTER TABLE product_units
ADD current_quantity INT;

UPDATE product_units
SET current_quantity = (
    SELECT COALESCE(MAX(quantity), 0) 
    FROM vendor_inventory 
    WHERE vendor_inventory.product_id = product_units.product_id
);


