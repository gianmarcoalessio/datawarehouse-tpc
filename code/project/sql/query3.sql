EXPLAIN ANALYZE -- Add for execution plan analysis
WITH loss_per_item AS (
    SELECT
        l.l_orderkey, 
        l.l_extendedprice * (1 - l_discount) AS revenue_loss,
        o.o_orderdate,
        c.c_custkey,  -- Identify customer
        c.c_name      -- Customer Name
    FROM lineitem l
    JOIN orders o ON l.l_orderkey = o.o_orderkey
    JOIN customer c ON o.o_custkey = c.c_custkey
    WHERE l.l_returnflag = 'R' -- Only returned items 
) 
SELECT 
    EXTRACT(YEAR FROM o_orderdate) AS sales_year,
    EXTRACT(QUARTER FROM o_orderdate) AS sales_quarter,
    EXTRACT(MONTH FROM o_orderdate) AS sales_month, 
    c_name, 
    c_custkey, 
    SUM(revenue_loss) AS total_loss
FROM loss_per_item
WHERE 
    c_name = ':customer' AND -- Filter by customer
    EXTRACT(QUARTER FROM o_orderdate) = :quarter -- 1, 2, 3, or 4
GROUP BY
    EXTRACT(YEAR FROM o_orderdate),
    EXTRACT(QUARTER FROM o_orderdate),
    EXTRACT(MONTH FROM o_orderdate),     
    c_name,
    c_custkey; 
