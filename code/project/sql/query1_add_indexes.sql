-- Index on orders.o_orderkey 
CREATE INDEX idx_orders_o_orderkey ON orders (o_orderkey);

-- Index on customer.c_custkey
CREATE INDEX idx_customer_c_custkey ON customer (c_custkey);

-- Index on supplier.s_suppkey
CREATE INDEX idx_supplier_s_suppkey ON supplier (s_suppkey);

-- Index on supplier.s_nationkey 
CREATE INDEX idx_supplier_s_nationkey ON supplier (s_nationkey);

-- Index on lineitem.l_orderdate
CREATE INDEX idx_lineitem_l_orderdate ON lineitem (l_orderdate);

-- Optional composite index on (lineitem.l_orderkey, l.l_suppkey)
CREATE INDEX idx_lineitem_orderkey_suppkey ON lineitem (l_orderkey, l_suppkey); 

-- Filtering (example, you must provide your nation name)
-- UPDATE supplier SET s_name = ':your_nation_name'::bpchar 
   -- WHERE s_nationkey = (SELECT n_nationkey FROM nation WHERE n_name = ':your_nation_name'); 
