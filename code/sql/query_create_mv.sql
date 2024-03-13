CREATE MATERIALIZED VIEW big_view AS
SELECT 
    l.l_extendedprice, 
    l.l_discount, 
    l.l_returnflag,
    o.o_orderdate, 
    p.p_type,
    s.s_nationkey, 
    c.c_custkey,
    c.c_name,
    n.n_name AS exporting_nation_name,
    r.r_name AS exporting_region_name
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
    customer c ON o.o_custkey = c.c_custkey;