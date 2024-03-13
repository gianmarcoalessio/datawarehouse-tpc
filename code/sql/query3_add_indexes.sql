-- Create indexes for Query 3
CREATE INDEX idx_orders_o_custkey ON orders (o_custkey);
CREATE INDEX idx_customer_c_name ON customer (c_name);
CREATE INDEX idx_lineitem_l_orderkey ON lineitem (l_orderkey);

