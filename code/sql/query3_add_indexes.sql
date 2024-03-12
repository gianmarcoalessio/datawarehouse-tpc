CREATE INDEX idx_orders_quarter_custkey ON orders (EXTRACT(quarter FROM o_orderdate), o_custkey);
CREATE INDEX idx_customer_name ON customer (c_name);
CREATE INDEX idx_lineitem_returnflag_orderkey ON lineitem (l_returnflag, l_orderkey); 
