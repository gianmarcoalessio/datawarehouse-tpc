-- Remove indexes individually:
DROP INDEX idx_orders_o_orderkey;
DROP INDEX idx_customer_c_custkey;
DROP INDEX idx_supplier_s_suppkey;
DROP INDEX idx_supplier_s_nationkey;
DROP INDEX idx_lineitem_l_orderdate;
DROP INDEX idx_lineitem_orderkey_suppkey; -- Remove if you created the composite index
