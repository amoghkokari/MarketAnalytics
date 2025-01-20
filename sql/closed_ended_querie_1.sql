-- 1. Top 5 brands by receipts scanned among users 21 and over
-- Assumption: "21 and over" means users whose age (based on birth_date) is 21 or more at the time of the scan_date.

-- TIMESTAMPDIFF(YEAR, u.birth_date, t.scan_date) >= 21 for mysql
-- remove AND p.brand != 'NULL' if you want NULL as brand name
-- remove AND p.barcode != 'NULL' AND t.barcode != 'NULL' if you want to consider NULL single barcode value

SELECT 
    p.brand, 
    COUNT(DISTINCT t.receipt_id) AS total_receipt_scanned
FROM 
    transactions t
JOIN 
    users u ON t.user_id = u.id
JOIN 
    products p ON t.barcode = p.barcode AND p.brand != 'NULL' AND p.barcode != 'NULL' AND t.barcode != 'NULL'
WHERE
    ((((JulianDay(t.scan_date)) - JulianDay(u.birth_date)) / 365.25) >= 21.0)
GROUP BY
    p.brand
ORDER BY
    total_receipt_scanned DESC
LIMIT 5;


-- Response

-- without AND p.barcode != 'NULL' AND t.barcode != 'NULL'
-- brand            total_receipt_scanned
-- ---------------  ---------------------
-- NERDS CANDY      14                   
-- DOVE             14                   
-- SOUR PATCH KIDS  13                   
-- HERSHEY'S        13                   
-- COCA-COLA        13  

-- with AND p.barcode != 'NULL' AND t.barcode != 'NULL'
-- brand            total_receipt_scanned
-- ---------------  ---------------------
-- NERDS CANDY      3                    
-- DOVE             3                    
-- TRIDENT          2                    
-- SOUR PATCH KIDS  2                    
-- MEIJER           2 