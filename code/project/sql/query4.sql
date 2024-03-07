EXPLAIN ANALYZE
SELECT 
    c_name, -- Customer Name

    -- Time Aggregation (Rollup) Columns 
    EXTRACT(YEAR FROM o_orderdate) AS order_year,
    EXTRACT(QUARTER FROM o_orderdate) AS order_quarter,
    EXTRACT(MONTH FROM o_orderdate) AS order_month,

    SUM(l_extendedprice * (1 - l_discount)) AS revenue_loss

FROM lineitem l
JOIN orders o ON l.l_orderkey = o.o_orderkey
JOIN customer c ON o.o_custkey = c.c_custkey

WHERE l_returnflag = 'R'
  AND c_name = ':customer_name' -- Filtering
  AND EXTRACT(QUARTER FROM o_orderdate) = :quarter_num

GROUP BY ROLLUP (c_name, EXTRACT(YEAR FROM o_orderdate), 
                 EXTRACT(QUARTER FROM o_orderdate),
                 EXTRACT(MONTH FROM o_orderdate))
ORDER BY revenue_loss DESC; -- Focus on top revenue loss
