-- 3. Percentage of sales in the Health & Wellness category by generation
-- Assumption: Generations are defined as follows: took these assumptions from https://en.wikipedia.org/wiki/Generation
-- BETWEEN '1883' AND '1900' : 'Lost Generation'
-- BETWEEN '1901' AND '1927' : 'GI Generation'
-- BETWEEN '1928' AND '1945' : 'Silent Generation'
-- BETWEEN '1946' AND '1964' : 'Baby Boomers'
-- BETWEEN '1965' AND '1980' : 'Generation X'
-- BETWEEN '1981' AND '1996' : 'Millennials'
-- BETWEEN '1997' AND '2010' : 'Generation Z'
-- BETWEEN '2010' AND '2025' : 'Generation Alpha'
-- BETWEEN '2025' AND '2039' : 'Generation Beta'
-- Also I am considering Health & Wellness categoy only for those records where birth_date is present, hence if we add all percentages up it will amount to 100

WITH total_sales AS (
    SELECT SUM(t.final_sale) AS total_health_wellness_sales
    FROM transactions t
    JOIN products p ON t.barcode = p.barcode
    JOIN users u ON t.user_id = u.id AND u.birth_date != "NULL"
    WHERE p.category_1 = 'Health & Wellness'
)
SELECT 
    CASE 
        WHEN strftime('%Y', u.birth_date) BETWEEN '1883' AND '1900' THEN 'Lost Generation'
        WHEN strftime('%Y', u.birth_date) BETWEEN '1901' AND '1927' THEN 'GI Generation'
        WHEN strftime('%Y', u.birth_date) BETWEEN '1928' AND '1945' THEN 'Silent Generation'
        WHEN strftime('%Y', u.birth_date) BETWEEN '1946' AND '1964' THEN 'Baby Boomers'
        WHEN strftime('%Y', u.birth_date) BETWEEN '1965' AND '1980' THEN 'Generation X'
        WHEN strftime('%Y', u.birth_date) BETWEEN '1981' AND '1996' THEN 'Millennials'
        WHEN strftime('%Y', u.birth_date) BETWEEN '1997' AND '2010' THEN 'Generation Z'
        WHEN strftime('%Y', u.birth_date) BETWEEN '2010' AND '2025' THEN 'Generation Alpha'
        WHEN strftime('%Y', u.birth_date) BETWEEN '2025' AND '2039' THEN 'Generation Beta'
        ELSE 'Unknown'
    END AS generation,
    ROUND((SUM(t.final_sale) / total_sales.total_health_wellness_sales) * 100, 2) AS percentage_of_sales
FROM 
    transactions t
JOIN 
    users u ON t.user_id = u.id AND u.birth_date != "NULL"
JOIN 
    products p ON t.barcode = p.barcode
JOIN 
    total_sales
WHERE 
    p.category_1 = 'Health & Wellness'
GROUP BY 
    generation;



-- Response

-- generation    percentage_of_sales
-- ------------  -------------------
-- Baby Boomers  29.87              
-- Generation X  24.12              
-- Millennials   46.01 
