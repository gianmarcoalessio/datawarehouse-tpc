CREATE INDEX idx_lineitem_orderkey ON LINEITEM (l_orderkey); 
CREATE INDEX idx_orders_custkey ON ORDERS (o_custkey);
CREATE INDEX idx_customer_name ON CUSTOMER (c_name);
CREATE INDEX idx_lineitem_returnflag ON LINEITEM (l_returnflag);

-- Optionally, if beneficial:
CREATE INDEX idx_orders_orderdate ON ORDERS (o_orderdate);