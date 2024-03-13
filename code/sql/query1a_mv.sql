-- EXPLAIN ANALYZE
SELECT 
    year,
    quarter,
    month,
    part_type,
    exporting_nation_name,
    exporting_region_name,
    SUM(total_revenue) AS total_revenue
FROM 
    mv_query1
GROUP BY ROLLUP(
    year,
    quarter,
    month,
    part_type,
    exporting_nation_name,
    exporting_region_name)
ORDER BY 
    year, 
    quarter, 
    month, 
    part_type, 
    exporting_nation_name, 
    exporting_region_name;