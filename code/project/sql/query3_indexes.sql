-- can be influenced by these indexes of the query 4
CREATE INDEX idx_lineitem_orderkey ON LINEITEM (l_orderkey); 

-- query 3
CREATE INDEX idx_lineitem_dates_orderkey ON LINEITEM (l_receiptdate, l_commitdate, l_orderkey);
-- If beneficial:
CREATE INDEX idx_orders_orderkey_date ON ORDERS (o_orderkey, o_orderdate);

