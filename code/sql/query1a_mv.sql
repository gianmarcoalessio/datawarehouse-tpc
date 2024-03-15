EXPLAIN ANALYZE
SELECT 
    month AS OrderMonth, 
    quarter AS OrderQuarter, 
    year AS OrderYear,
    CombinedNations, 
    CombinedRegions,
    part_type AS PartType,
    SUM(total_revenue) AS TotalRevenue
FROM 
    mv_query1
WHERE 
    part_type = 'ECONOMY POLISHED TIN'
GROUP BY 
    ROLLUP(PartType), 
    ROLLUP(CombinedNations, CombinedRegions),
    ROLLUP(OrderYear, OrderQuarter, OrderMonth);