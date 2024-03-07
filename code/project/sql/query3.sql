-- SET :ship_mode = '';
-- SET :month_num  = 1;

EXPLAIN ANALYZE
SELECT
    EXTRACT(MONTH FROM o_orderdate) AS order_month,
    EXTRACT(YEAR FROM o_orderdate) AS order_year,
    c_nationkey, c_name AS customer_nation, 
    r.r_name AS customer_region,
    COUNT(DISTINCT o_orderkey) AS num_late_orders
FROM LINEITEM l
JOIN ORDERS o ON l.l_orderkey = o.o_orderkey
JOIN CUSTOMER c ON c.c_custkey = o.o_custkey
JOIN NATION n ON n.n_nationkey = c.c_nationkey
JOIN REGION r ON r.r_regionkey = n.n_regionkey
WHERE l_receiptdate > l_commitdate  -- Late delivery condition
  AND l_shipmode = ':ship_mode' -- Optional filtering by ship mode
  AND EXTRACT(MONTH FROM o_orderdate) = :month_num-- Optional filtering by month
GROUP BY ROLLUP (order_month, order_year, c_nationkey, c_name, r.r_name);