-- 1. Indexes on filtering columns 
-- CREATE INDEX idx_part_type ON part (p_type); 
-- CREATE INDEX idx_supplierNation_name ON nation (n_name);

-- 2. Indexes for joins (consider composite options first)
-- CREATE INDEX idx_lineitem_orderkey ON lineitem (l_orderkey);
CREATE INDEX idx_lineitem_partkey ON lineitem (l_partkey);
-- CREATE INDEX idx_lineitem_suppkey ON lineitem (l_suppkey);
CREATE INDEX idx_orders_custkey ON orders (o_custkey);
-- CREATE INDEX idx_customer_nationkey ON customer (c_nationkey);
-- CREATE INDEX idx_supplier_nationkey ON supplier (s_nationkey); 
-- CREATE INDEX idx_nation_regionkey ON nation (n_regionkey); 
-- CREATE INDEX idx_region_regionkey ON region (r_regionkey); 

-- 3. Potential composite indexes (evaluate against individual ones above)
CREATE INDEX idx_part_type_partkey ON part (p_type, p_partkey);
CREATE INDEX idx_supplier_nationkey_suppkey ON supplier (s_nationkey, s_suppkey); 

-- 4. Index for calculations involving EXTRACT (if beneficial)
-- CREATE INDEX idx_orders_orderdate ON orders (o_orderdate); 

