-- 851 MB
EXPLAIN ANALYZE
CREATE MATERIALIZED VIEW mv_query3 AS
SELECT
    o.o_orderdate, 
    c.c_name AS customer_name,
    l.l_extendedprice * (1 - l.l_discount) AS revenue_loss
FROM
    lineitem l
JOIN
    orders o ON l.l_orderkey = o.o_orderkey
JOIN
    customer c ON o.o_custkey = c.c_custkey
WHERE
    l.l_returnflag = 'R';