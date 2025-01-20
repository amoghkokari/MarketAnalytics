-- 1. Who are Fetch’s power users?
-- Assumption: Power users are defined as users with the highest number of transactions and total sales.

SELECT 
    t.user_id, 
    COUNT(DISTINCT t.receipt_id) AS recipt_count, 
    SUM(t.final_sale) AS total_sales,
    SUM(t.final_quantity) AS total_quantity,
    COUNT(t.barcode) AS total_products
FROM 
    transactions t
WHERE
    t.user_id != "NULL"
GROUP BY 
    t.user_id
ORDER BY 
    recipt_count DESC, total_products DESC, total_sales DESC
LIMIT 10;


-- Response

-- user_id                   recipt_count  total_sales  total_quantity  total_products
-- ------------------------  ------------  -----------  --------------  --------------
-- 64e62de5ca929250373e6cf5  10            57.65        13              22            
-- 62925c1be942f00613f7365e  10            49.87        12              20            
-- 64063c8880552327897186a5  9             43.72        14              18            
-- 604278958fe03212b47e657b  7             46.61        15              20            
-- 609af341659cf474018831fb  7             25.55        9               14            
-- 624dca0770c07012cd5e6c03  7             21.91        13              14            
-- 6327a07aca87b39d76e03864  7             15.64        11              14            
-- 5d77d06b0d1bff4316a3ef47  6             60.73        14              12            
-- 6240f64ee073a81bcca57670  6             57.33        9               12            
-- 605a982894a5c74ba439e5ab  6             56.52        8               12   