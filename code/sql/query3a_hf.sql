SELECT
    EXTRACT(YEAR FROM o.o_orderdate) AS year,
    EXTRACT(QUARTER FROM o.o_orderdate) AS quarter,
    EXTRACT(MONTH FROM o.o_orderdate) AS month,
    c.c_name AS customer_name,
    SUM(l.l_extendedprice * (1 - l.l_discount)) AS revenue_loss
FROM
    lineitem_returned l
JOIN
    orders o ON l.l_orderkey = o.o_orderkey
JOIN
    customer c ON o.o_custkey = c.c_custkey
WHERE
    c.c_name = 'Customer#000000236'
    AND EXTRACT(QUARTER FROM o.o_orderdate) = 1
GROUP BY ROLLUP(
    EXTRACT(YEAR FROM o.o_orderdate),
    EXTRACT(QUARTER FROM o.o_orderdate),
    EXTRACT(MONTH FROM o.o_orderdate),
    c.c_name)
ORDER BY
    year, quarter, month, customer_name;