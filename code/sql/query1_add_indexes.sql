-- Index 1
CREATE INDEX idx_lineitem_orderkey_suppkey ON lineitem (l_orderkey, l_suppkey);

-- Index 2
CREATE INDEX idx_orders_custkey ON orders (o_custkey);

-- Index 3
CREATE INDEX idx_part_type ON part (p_type);

-- Index 4
CREATE INDEX idx_nation_name ON nation (n_name);
