-- EXPLAIN ANALYZE -- Uncomment for execution plan analysis
SELECT
    EXTRACT(YEAR FROM o.o_orderdate) AS year,
    EXTRACT(QUARTER FROM o.o_orderdate) AS quarter,
    EXTRACT(MONTH FROM o.o_orderdate) AS month,
    c.c_name AS customer_name,
    SUM(l.l_extendedprice * (1 - l.l_discount)) AS revenue_loss
FROM
    lineitem_part l -- Updated to use the partitioned table
JOIN
    orders o ON l.l_orderkey = o.o_orderkey
JOIN
    customer c ON o.o_custkey = c.c_custkey
WHERE
    l.l_returnflag = 'R' -- Assuming 'R' indicates returned items
    AND c.c_name = 'Customer#000000236' -- Replace with the specific customer's name
    AND EXTRACT(QUARTER FROM o.o_orderdate) = 1 -- Replace with the specific quarter number
GROUP BY ROLLUP(
    EXTRACT(YEAR FROM o.o_orderdate),
    EXTRACT(QUARTER FROM o.o_orderdate),
    EXTRACT(MONTH FROM o.o_orderdate),
    c.c_name)
ORDER BY
    year, quarter, month, customer_name;
