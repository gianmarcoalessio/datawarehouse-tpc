-- EXPLAIN ANALYZE
SELECT
    EXTRACT(YEAR FROM big_view.o_orderdate) AS year,
    EXTRACT(QUARTER FROM big_view.o_orderdate) AS quarter,
    EXTRACT(MONTH FROM big_view.o_orderdate) AS month,
    big_view.p_type AS part_type,
    big_view.exporting_nation_name,
    big_view.exporting_region_name,
    SUM(big_view.l_extendedprice * (1 - big_view.l_discount)) AS total_revenue
FROM
    big_view
WHERE
    big_view.p_type = 'ECONOMY POLISHED TIN'
    AND big_view.exporting_nation_name = 'FRANCE'
GROUP BY ROLLUP(
    EXTRACT(YEAR FROM big_view.o_orderdate),
    EXTRACT(QUARTER FROM big_view.o_orderdate),
    EXTRACT(MONTH FROM big_view.o_orderdate),
    big_view.p_type,
    big_view.exporting_nation_name,
    big_view.exporting_region_name)
ORDER BY
    year, quarter, month, part_type, exporting_nation_name, exporting_region_name;