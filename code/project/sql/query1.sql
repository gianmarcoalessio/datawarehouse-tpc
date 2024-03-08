-- SET :nation = '';

EXPLAIN ANALYZE -- Add this at the beginning to get the execution plan 
WITH revenue AS (
    SELECT 
        l_orderkey, 
        l_extendedprice * (1 - l_discount) AS revenue,
        o_orderdate,
        CASE 
            WHEN s.s_nationkey = c.c_nationkey THEN 'Domestic' -- Check domestic sales
            ELSE 'Export'                                     -- Otherwise, it's an Export
        END AS type,
        s.s_nationkey AS exporter_nationkey, 
        s.s_name AS exporter_nation,
        r1.r_name AS exporter_region,  
        c.c_nationkey AS importer_nationkey, 
        c.c_name AS importer_nation,
        r2.r_name as importer_region
    FROM lineitem l
    JOIN orders o ON l.l_orderkey = o.o_orderkey
    JOIN supplier s ON l.l_suppkey = s.s_suppkey
    JOIN customer c ON o.o_custkey = c.c_custkey
    JOIN nation n1 ON s.s_nationkey = n1.n_nationkey -- Supplier's nation
    JOIN nation n2 ON c.c_nationkey = n2.n_nationkey -- Customer's nation
    JOIN region r1 ON n1.n_regionkey = r1.r_regionkey -- Supplier's region
    JOIN region r2 ON n2.n_regionkey = r2.r_regionkey -- Customer's region
)
SELECT 
    EXTRACT(MONTH FROM revenue.o_orderdate) AS sales_month, -- Access from revenue CTE
    EXTRACT(QUARTER FROM revenue.o_orderdate) AS sales_quarter, 
    EXTRACT(YEAR FROM revenue.o_orderdate) AS sales_year,
    type,
    exporter_nation, 
    exporter_region,
    importer_nation,
    importer_region,
    SUM(revenue) AS total_revenue 
FROM revenue
WHERE type = 'Export' -- Add filtering for exports if needed
  AND exporter_nation = ':nation'  -- Filter by exporter nation
GROUP BY 
    EXTRACT(YEAR FROM revenue.o_orderdate), 
    EXTRACT(QUARTER FROM revenue.o_orderdate),
    EXTRACT(MONTH FROM revenue.o_orderdate),
    type,
    exporter_nation,
    exporter_region,
    importer_nation,
    importer_region;
