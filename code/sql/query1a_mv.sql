EXPLAIN ANALYZE
SELECT 
    DATE_PART('year', V.o_orderdate) AS yearOrder,
    DATE_PART('quarter', V.o_orderdate) AS quarterOrder,
    DATE_PART('month', V.o_orderdate) AS monthOrder,
    V.p_type AS ptype,
    V.exporting_nation_name,
    V.exporting_region_name,
    SUM(V.l_extendedprice * (1 - V.l_discount)) AS total_revenue
FROM 
    big_view AS V
WHERE 
    V.p_type = 'ECONOMY POLISHED TIN'
    AND V.exporting_nation_name = 'FRANCE'
GROUP BY ROLLUP(
    yearOrder,
    quarterOrder,
    monthOrder,
    ptype,
    exporting_nation_name,
    exporting_region_name)
ORDER BY
    yearOrder, quarterOrder, monthOrder, ptype, exporting_nation_name, exporting_region_name;