-- **** Indexes for Query 1 Optimization ****

CREATE INDEX idx_part_type ON part (p_type);
CREATE INDEX idx_lineitem_orderkey_suppkey ON lineitem (l_orderkey, l_suppkey); 
CREATE INDEX idx_orders_custkey ON orders (o_custkey);
CREATE INDEX idx_nation_name ON nation (n_name);
CREATE INDEX idx_lineitem_order_part_supp_nation ON lineitem (l_orderkey, l_partkey, l_suppkey); 
