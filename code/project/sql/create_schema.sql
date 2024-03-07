-- TPC-H Schema Creation Script 

-- Tables definition:
CREATE TABLE NATION  ( N_NATIONKEY  INTEGER NOT NULL,
        N_NAME       CHAR(25) NOT NULL,
        N_REGIONKEY  INTEGER NOT NULL,
        N_COMMENT    VARCHAR(152));

CREATE TABLE REGION  ( R_REGIONKEY  INTEGER NOT NULL,
        R_NAME       CHAR(25) NOT NULL,
        R_COMMENT    VARCHAR(152));

CREATE TABLE PART  ( P_PARTKEY     INTEGER NOT NULL,
        P_NAME        VARCHAR(55) NOT NULL,
        P_MFGR        CHAR(25) NOT NULL,
        P_BRAND       CHAR(10) NOT NULL,
        P_TYPE        VARCHAR(25) NOT NULL,
        P_SIZE        INTEGER NOT NULL,
        P_CONTAINER   CHAR(10) NOT NULL,
        P_RETAILPRICE DECIMAL(15,2) NOT NULL,
        P_COMMENT     VARCHAR(23) NOT NULL );

CREATE TABLE SUPPLIER ( S_SUPPKEY     INTEGER NOT NULL,
        S_NAME        CHAR(25) NOT NULL,
        S_ADDRESS     VARCHAR(40) NOT NULL,
        S_NATIONKEY   INTEGER NOT NULL,
        S_PHONE       CHAR(15) NOT NULL,
        S_ACCTBAL     DECIMAL(15,2) NOT NULL,
        S_COMMENT     VARCHAR(101) NOT NULL);

CREATE TABLE PARTSUPP ( PS_PARTKEY     INTEGER NOT NULL,
        PS_SUPPKEY     INTEGER NOT NULL,
        PS_AVAILQTY    INTEGER NOT NULL,
        PS_SUPPLYCOST  DECIMAL(15,2)  NOT NULL,
        PS_COMMENT     VARCHAR(199) NOT NULL );

CREATE TABLE CUSTOMER ( C_CUSTKEY     INTEGER NOT NULL,
        C_NAME        VARCHAR(25) NOT NULL,
        C_ADDRESS     VARCHAR(40) NOT NULL,
        C_NATIONKEY   INTEGER NOT NULL,
        C_PHONE       CHAR(15) NOT NULL,
        C_ACCTBAL     DECIMAL(15,2)   NOT NULL,
        C_MKTSEGMENT  CHAR(10) NOT NULL,
        C_COMMENT     VARCHAR(117) NOT NULL);

CREATE TABLE ORDERS  ( O_ORDERKEY       INTEGER NOT NULL,
        O_CUSTKEY        INTEGER NOT NULL,
        O_ORDERSTATUS    CHAR(1) NOT NULL,
        O_TOTALPRICE     DECIMAL(15,2) NOT NULL,
        O_ORDERDATE      DATE NOT NULL,
        O_ORDERPRIORITY  CHAR(15) NOT NULL,  
        O_CLERK          CHAR(15) NOT NULL, 
        O_SHIPPRIORITY   INTEGER NOT NULL,
        O_COMMENT        VARCHAR(79) NOT NULL);

CREATE TABLE LINEITEM ( L_ORDERKEY    INTEGER NOT NULL,
        L_PARTKEY     INTEGER NOT NULL,
        L_SUPPKEY     INTEGER NOT NULL,
        L_LINENUMBER  INTEGER NOT NULL,
        L_QUANTITY    DECIMAL(15,2) NOT NULL,
        L_EXTENDEDPRICE  DECIMAL(15,2) NOT NULL,
        L_DISCOUNT    DECIMAL(15,2) NOT NULL,
        L_TAX         DECIMAL(15,2) NOT NULL,
        L_RETURNFLAG  CHAR(1) NOT NULL,
        L_LINESTATUS  CHAR(1) NOT NULL,
        L_SHIPDATE    DATE NOT NULL,
        L_COMMITDATE  DATE NOT NULL,
        L_RECEIPTDATE DATE NOT NULL,
        L_SHIPINSTRUCT CHAR(25) NOT NULL,
        L_SHIPMODE     CHAR(10) NOT NULL,
        L_COMMENT      VARCHAR(44) NOT NULL);

-- Copy Data (using dynamic version for flexibility)
\copy NATION     FROM '../../TPC-H_V3.0.1/dbgen/nation.tbl' DELIMITER '|';
\copy REGION     FROM '../../TPC-H_V3.0.1/dbgen/region.tbl' DELIMITER '|';
\copy PART       FROM '../../TPC-H_V3.0.1/dbgen/part.tbl' DELIMITER '|';
\copy SUPPLIER   FROM '../../TPC-H_V3.0.1/dbgen/supplier.tbl' DELIMITER '|';
\copy PARTSUPP   FROM '../../TPC-H_V3.0.1/dbgen/partsupp.tbl' DELIMITER '|';
\copy CUSTOMER   FROM '../../TPC-H_V3.0.1/dbgen/customer.tbl' DELIMITER '|';
\copy ORDERS     FROM '../../TPC-H_V3.0.1/dbgen/orders.tbl' DELIMITER '|';
\copy LINEITEM   FROM '../../TPC-H_V3.0.1/dbgen/lineitem.tbl' DELIMITER '|';

-- PK and FK
ALTER TABLE PART     ADD PRIMARY KEY (p_partkey);
ALTER TABLE SUPPLIER ADD PRIMARY KEY (s_suppkey);
ALTER TABLE PARTSUPP ADD PRIMARY KEY (ps_partkey,ps_suppkey);
ALTER TABLE CUSTOMER ADD PRIMARY KEY (c_custkey);
ALTER TABLE ORDERS   ADD PRIMARY KEY (o_orderkey);
ALTER TABLE LINEITEM ADD PRIMARY KEY (l_orderkey,l_linenumber);
ALTER TABLE NATION   ADD PRIMARY KEY (n_nationkey);
ALTER TABLE REGION   ADD PRIMARY KEY (r_regionkey);

ALTER TABLE PARTSUPP ADD FOREIGN KEY (ps_partkey)  REFERENCES PART (p_partkey);
ALTER TABLE PARTSUPP ADD FOREIGN KEY (ps_suppkey)  REFERENCES SUPPLIER (s_suppkey);
ALTER TABLE CUSTOMER ADD FOREIGN KEY (c_nationkey) REFERENCES NATION (n_nationkey);
ALTER TABLE ORDERS   ADD FOREIGN KEY (o_custkey)   REFERENCES CUSTOMER (c_custkey);
ALTER TABLE LINEITEM ADD FOREIGN KEY (l_orderkey)  REFERENCES ORDERS (o_orderkey);
ALTER TABLE LINEITEM ADD FOREIGN KEY (l_partkey)   REFERENCES PART (p_partkey);
ALTER TABLE LINEITEM ADD FOREIGN KEY (l_suppkey)   REFERENCES SUPPLIER (s_suppkey);
ALTER TABLE NATION   ADD FOREIGN KEY (n_regionkey) REFERENCES REGION (r_regionkey);
ALTER TABLE SUPPLIER ADD FOREIGN KEY (s_nationkey) REFERENCES NATION (n_nationkey);