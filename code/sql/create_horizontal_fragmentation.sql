CREATE TABLE lineitem_part (
    LIKE lineitem
) PARTITION BY RANGE (EXTRACT(year FROM l_shipdate));

CREATE TABLE lineitem_1992 PARTITION OF lineitem_part
    FOR VALUES FROM (1992) TO (1993);

CREATE TABLE lineitem_1993 PARTITION OF lineitem_part
    FOR VALUES FROM (1993) TO (1994);

-- Repeat for each year up to 1998

CREATE TABLE lineitem_1998 PARTITION OF lineitem_part
    FOR VALUES FROM (1998) TO (1999);
