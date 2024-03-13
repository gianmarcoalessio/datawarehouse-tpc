-- SET :nation = '';

--EXPLAIN ANALYZE
SELECT
    EXTRACT(YEAR FROM o.o_orderdate) AS year,
    EXTRACT(QUARTER FROM o.o_orderdate) AS quarter,
    EXTRACT(MONTH FROM o.o_orderdate) AS month,
    p.p_type AS part_type,
    n.n_name AS exporting_nation_name,
    r.r_name AS exporting_region_name,
    SUM(l.l_extendedprice * (1 - l.l_discount)) AS total_revenue
FROM
    lineitem l
JOIN
    orders o ON l.l_orderkey = o.o_orderkey
JOIN
    part p ON l.l_partkey = p.p_partkey
JOIN
    supplier s ON l.l_suppkey = s.s_suppkey
JOIN
    nation n ON s.s_nationkey = n.n_nationkey
JOIN
    region r ON n.n_regionkey = r.r_regionkey
JOIN
    customer c ON o.o_custkey = c.c_custkey
WHERE
    p.p_type = 'ECONOMY POLISHED TIN'
    AND n.n_name = 'FRANCE'
GROUP BY ROLLUP(
    EXTRACT(YEAR FROM o.o_orderdate),
    EXTRACT(QUARTER FROM o.o_orderdate),
    EXTRACT(MONTH FROM o.o_orderdate),
    p.p_type,
    n.n_name,
    r.r_name)
ORDER BY
    year, quarter, month, part_type, exporting_nation_name, exporting_region_name;

