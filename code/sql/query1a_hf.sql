EXPLAIN ANALYZE
SELECT 
    CONCAT(supplierNation.n_name, ', ', customerNation.n_name) AS CombinedNations, 
    CONCAT(exportRegion.r_name, ', ', importRegion.r_name) AS CombinedRegions, 
    SUM(L.l_extendedprice * (1 - L.l_discount)) AS TotalRevenue,
    EXTRACT(month FROM O.o_orderdate) AS OrderMonth, 
    EXTRACT(quarter FROM O.o_orderdate) AS OrderQuarter, 
    EXTRACT(year FROM O.o_orderdate) AS OrderYear,
    P.p_type AS PartType
FROM 
    lineitem_part L -- Updated to use the partitioned table
INNER JOIN 
    orders O ON L.l_orderkey = O.o_orderkey
INNER JOIN 
    part P ON L.l_partkey = P.p_partkey
INNER JOIN 
    supplier S ON L.l_suppkey = S.s_suppkey
INNER JOIN 
    customer Cu ON O.o_custkey = Cu.c_custkey
INNER JOIN 
    nation supplierNation ON S.s_nationkey = supplierNation.n_nationkey
INNER JOIN 
    nation customerNation ON Cu.c_nationkey = customerNation.n_nationkey
INNER JOIN 
    region exportRegion ON supplierNation.n_regionkey = exportRegion.r_regionkey
INNER JOIN 
    region importRegion ON customerNation.n_regionkey = importRegion.r_regionkey
WHERE 
    P.p_type = 'ECONOMY POLISHED TIN' AND supplierNation.n_name = 'FRANCE'
GROUP BY 
    ROLLUP(PartType), 
    ROLLUP(CombinedNations, CombinedRegions),
    ROLLUP(OrderYear, OrderQuarter, OrderMonth);
