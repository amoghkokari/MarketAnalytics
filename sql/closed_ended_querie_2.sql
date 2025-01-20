-- 2. Top 5 brands by sales among users with accounts for at least six months
-- Assumption: Users with accounts for at least six months are identified by the difference between created_date and purchase_date.

-- TIMESTAMPDIFF(MONTH, u.created_date, t1.purchase_date) >= 6 for mysql
-- remove AND p.brand != 'NULL' if you want NULL as brand name

WITH recent_active_users AS (
    SELECT DISTINCT u.id AS user_id
    FROM users u
    INNER JOIN transactions t ON t.user_id = u.id AND t.user_id != 'NULL' AND u.id != 'NULL' AND t.purchase_date != 'NULL' AND u.created_date != 'NULL'
    WHERE ((julianday(t.purchase_date) - julianday(u.created_date)) >= 180.0)
)
SELECT 
    p.brand, 
    ROUND(SUM(t.final_sale),2) AS total_sales,
    ROUND(SUM(t.final_quantity),2) AS total_sales_quantity
FROM 
    transactions t
INNER JOIN 
    users u ON t.user_id = u.id AND u.id != 'NULL' AND t.user_id != 'NULL'
INNER JOIN 
    products p ON t.barcode = p.barcode AND p.brand != 'NULL' AND p.barcode != 'NULL' AND t.barcode != "NULL"
JOIN 
    recent_active_users
WHERE
    u.id IN (SELECT user_id FROM recent_active_users)
GROUP BY 
    p.brand
ORDER BY 
    total_sales DESC
LIMIT 5;


-- Response
-- brand                      total_sales  total_sales_quantity
-- -------------------------  -----------  --------------------
-- COCA-COLA                  204655.82    32943.0             
-- ANNIE'S HOMEGROWN GROCERY  188329.68    30336.0             
-- DOVE                       183870.13    29467.0             
-- BAREFOOT                   180482.61    29072.0             
-- ORIBE                      164788.47    26544.0  