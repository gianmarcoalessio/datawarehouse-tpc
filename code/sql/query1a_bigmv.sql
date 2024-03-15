EXPLAIN ANALYZE
SELECT 
    CONCAT(supplierNation.n_name, ', ', customerNation.n_name) AS CombinedNations, 
    CONCAT(exportRegion.r_name, ', ', importRegion.r_name) AS CombinedRegions, 
    SUM(l_extendedprice * (1 - l_discount)) AS TotalRevenue,
    EXTRACT(month FROM o_orderdate) AS OrderMonth, 
    EXTRACT(quarter FROM o_orderdate) AS OrderQuarter, 
    EXTRACT(year FROM o_orderdate) AS OrderYear,
    p_type AS PartType
FROM 
    big_view bv 
INNER JOIN 
    nation supplierNation ON bv.s_nationkey = supplierNation.n_nationkey
INNER JOIN 
    customer c ON bv.c_custkey = c.c_custkey
INNER JOIN 
    nation customerNation ON c.c_nationkey = customerNation.n_nationkey
INNER JOIN 
    region exportRegion ON supplierNation.n_regionkey = exportRegion.r_regionkey
INNER JOIN 
    region importRegion ON customerNation.n_regionkey = importRegion.r_regionkey
WHERE 
    p_type = 'ECONOMY POLISHED TIN' AND supplierNation.n_name = 'FRANCE'
GROUP BY 
    ROLLUP(PartType), 
    ROLLUP(CombinedNations, CombinedRegions),
    ROLLUP(OrderYear, OrderQuarter, OrderMonth);