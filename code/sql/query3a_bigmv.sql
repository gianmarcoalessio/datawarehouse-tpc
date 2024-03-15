EXPLAIN ANALYZE
SELECT
    EXTRACT(YEAR FROM big_view.o_orderdate) AS year,
    EXTRACT(QUARTER FROM big_view.o_orderdate) AS quarter,
    EXTRACT(MONTH FROM big_view.o_orderdate) AS month,
    big_view.c_name AS customer_name,
    SUM(big_view.l_extendedprice * (1 - big_view.l_discount)) AS revenue_loss
FROM
    big_view
WHERE
    big_view.l_returnflag = 'R'
    AND big_view.c_name = 'Customer#000000236'
    AND EXTRACT(QUARTER FROM big_view.o_orderdate) = 1 
GROUP BY ROLLUP(
    EXTRACT(YEAR FROM big_view.o_orderdate),
    EXTRACT(QUARTER FROM big_view.o_orderdate),
    EXTRACT(MONTH FROM big_view.o_orderdate),
    big_view.c_name)
ORDER BY
    year, quarter, month, customer_name;
