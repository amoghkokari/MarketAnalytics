-- Since we have transactions only for 2024, only the growth interms of users onbaorded can be measured for year-over-year user acquisition as proxy for compnay growth

WITH user_growth AS (
    -- Aggregate user counts per year
    SELECT 
        strftime('%Y', created_date) AS year, 
        COUNT(*) AS new_users
    FROM 
        users
    WHERE 
        strftime('%Y', created_date) <= '2024' -- Ensure we include data up to 2024
    GROUP BY 
        year
),
growth_calculation AS (
    -- Calculate YoY growth
    SELECT 
        year,
        new_users,
        LAG(new_users) OVER (ORDER BY year) AS previous_year_users,
        ROUND(
            ((new_users - LAG(new_users) OVER (ORDER BY year)) * 100.0) 
            / NULLIF(LAG(new_users) OVER (ORDER BY year), 0), 2
        ) AS yoy_growth_percentage
    FROM 
        user_growth
)
-- Final output
SELECT 
    year,
    new_users,
    COALESCE(yoy_growth_percentage, 0) AS yoy_growth_percentage
FROM 
    growth_calculation
ORDER BY 
    year;


-- response

-- year  new_users  yoy_growth_percentage
-- ----  ---------  ---------------------
-- 2014  30         0                    
-- 2015  51         70.0                 
-- 2016  70         37.25                
-- 2017  644        820.0                
-- 2018  2168       236.65               
-- 2019  7093       227.17               
-- 2020  16883      138.02               
-- 2021  19159      13.48                
-- 2022  26807      39.92                
-- 2023  15464      -42.31               
-- 2024  11631      -24.79      