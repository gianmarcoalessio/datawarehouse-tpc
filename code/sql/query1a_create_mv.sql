-- 421 MB
EXPLAIN ANALYZE
CREATE MATERIALIZED VIEW mv_query1 AS
SELECT
    EXTRACT(YEAR FROM o.o_orderdate) AS year,
    EXTRACT(QUARTER FROM o.o_orderdate) AS quarter,
    EXTRACT(MONTH FROM o.o_orderdate) AS month,
    p.p_type AS part_type,
    CONCAT(supplierNation.n_name, ', ', customerNation.n_name) AS CombinedNations, 
    CONCAT(exportRegion.r_name, ', ', importRegion.r_name) AS CombinedRegions,
    l.l_extendedprice * (1 - l.l_discount) AS total_revenue
FROM
    lineitem l
JOIN
    orders o ON l.l_orderkey = o.o_orderkey
JOIN
    part p ON l.l_partkey = p.p_partkey
JOIN
    supplier s ON l.l_suppkey = s.s_suppkey
JOIN
    customer c ON o.o_custkey = c.c_custkey
JOIN
    nation supplierNation ON s.s_nationkey = supplierNation.n_nationkey
JOIN
    nation customerNation ON c.c_nationkey = customerNation.n_nationkey
JOIN
    region exportRegion ON supplierNation.n_regionkey = exportRegion.r_regionkey
JOIN
    region importRegion ON customerNation.n_regionkey = importRegion.r_regionkey
WHERE
    supplierNation.n_name = 'FRANCE';
