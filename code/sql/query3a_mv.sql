-- EXPLAIN ANALYZE
SELECT 
    year,
    quarter,
    month,
    customer_name,
    SUM(revenue_loss) AS revenue_loss
FROM 
    mv_query3
GROUP BY 
    year,
    quarter,
    month,
    customer_name;