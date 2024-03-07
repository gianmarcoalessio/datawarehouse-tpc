#!/bin/bash 

tpch_version="3.0.1"
size=10
db_name="dmbd"
db_user="admin"

cd "./TPC-H_V${tpch_version}/dbgen"
make clean
make -f Makefile
printf "\nGenerating using dbgen with size: $size"
./dbgen -v -s $size
sed -i 's/|$//' nation.tbl region.tbl supplier.tbl customer.tbl part.tbl partsupp.tbl orders.tbl lineitem.tbl

cd ../../project/sql

printf "\n\nCreating the db\n"
createdb -h localhost -U $db_user $db_name -p 5432
printf "\nImporting data\n"
psql -U$db_user -d $db_name -a -f create_schema.sql -v tpch_version="${tpch_version}"