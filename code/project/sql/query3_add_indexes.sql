-- Index on orders.o_custkey
CREATE INDEX idx_orders_o_custkey ON orders (o_custkey);

-- Index on orders.o_orderdate
CREATE INDEX idx_orders_o_orderdate ON orders (o_orderdate);

-- Index on customer.c_custkey
CREATE INDEX idx_customer_c_custkey ON customer (c_custkey);

-- Index on customer.c_name
CREATE INDEX idx_customer_c_name ON customer (c_name);

-- Index on lineitem.l_orderkey
CREATE INDEX idx_lineitem_l_orderkey ON lineitem (l_orderkey);

-- Index on lineitem.l_returnflag
CREATE INDEX idx_lineitem_l_returnflag ON lineitem (l_returnflag);
