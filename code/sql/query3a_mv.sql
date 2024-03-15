EXPLAIN ANALYZE
SELECT
    year,
    quarter,
    month,
    customer_name,
    SUM(revenue_loss) AS revenue_loss
FROM
    mv_revenue_loss_summary
WHERE
    customer_name = 'Customer#000307358'
    AND quarter = 4
GROUP BY ROLLUP(year, quarter, month, customer_name)
ORDER BY year, quarter, month, customer_name;