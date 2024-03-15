-- EXPLAIN ANALYZE
SELECT
    EXTRACT(YEAR FROM o.o_orderdate) AS year,
    EXTRACT(QUARTER FROM o.o_orderdate) AS quarter,
    EXTRACT(MONTH FROM o.o_orderdate) AS month,
    c.c_name AS customer_name,
    SUM(l.l_extendedprice * (1 - l.l_discount)) AS revenue_loss
FROM
    lineitem l
JOIN
    orders o ON l.l_orderkey = o.o_orderkey
JOIN
    customer c ON o.o_custkey = c.c_custkey
WHERE
    l.l_returnflag = 'R' -- Assumendo che 'R' indichi gli articoli restituiti
    AND c.c_name = 'Customer#000307258' -- Sostituisci con il nome del cliente specifico
    AND EXTRACT(QUARTER FROM o.o_orderdate) = 4 -- Sostituisci SpecificQuarter con il numero del trimestre
GROUP BY ROLLUP(
    EXTRACT(YEAR FROM o.o_orderdate),
    EXTRACT(QUARTER FROM o.o_orderdate),
    EXTRACT(MONTH FROM o.o_orderdate),c_name)
ORDER BY
    year, quarter, month, customer_name;


