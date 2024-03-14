CREATE TABLE lineitem_returned AS
SELECT * FROM lineitem WHERE l_returnflag = 'R';

CREATE TABLE lineitem_not_returned AS
SELECT * FROM lineitem WHERE l_returnflag != 'R';