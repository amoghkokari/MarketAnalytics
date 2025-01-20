-- 2. Leading brand in the Dips & Salsa category
-- Assumption: The leading brand is defined by the highest total sales in this category.

SELECT 
    p.brand, 
    SUM(t.final_quantity) AS total_quantity,
    SUM(t.final_sale) AS total_amount
FROM 
    transactions t
JOIN 
    products p ON t.barcode = p.barcode AND p.barcode != "NULL" AND t.barcode != "NULL"
WHERE 
    p.category_2 = 'Dips & Salsa'
GROUP BY 
    p.brand
ORDER BY 
    total_quantity DESC, total_amount DESC
LIMIT 1;

-- response

-- brand     total_quantity  total_amount
-- --------  --------------  ------------
-- TOSTITOS  60              260.99   
