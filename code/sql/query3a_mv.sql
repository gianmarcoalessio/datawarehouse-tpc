SELECT 
    DATE_PART('year', V.o_orderdate) AS yearOrder,
    DATE_PART('quarter', V.o_orderdate) AS quarterOrder,
    DATE_PART('month', V.o_orderdate) AS monthOrder,
    V.c_name AS customer_name,
    SUM(V.l_extendedprice * (1 - V.l_discount)) AS revenue_loss
FROM 
    big_view AS V
WHERE 
    V.l_returnflag = 'R'
    AND V.c_name = 'Customer#000000236'
    AND DATE_PART('quarter', V.o_orderdate) = 1
GROUP BY ROLLUP(
    yearOrder,
    quarterOrder,
    monthOrder,
    customer_name)
ORDER BY
    yearOrder, quarterOrder, monthOrder, customer_name;