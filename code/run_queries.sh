#!/bin/bash

source utils.sh

mkdir -p ./results/res_$timestamp

# CLEAN

# Query 1 Execution with Output
execute_query_file "./sql/query1a.sql" > ./results/res_$timestamp/query1a_$timestamp.txt
# to be repeated 3 times, with different parameters?

# Query 3 Execution with Output
execute_query_file "./sql/query3a.sql" > ./results/res_$timestamp/query3a_$timestamp.txt


# INDEXES

# Add indexes for Query 1
execute_query_file "./sql/query1_add_indexes.sql"

# Query 1 Execution with Output
execute_query_file "./sql/query1a.sql" > ./results/res_$timestamp/query1a_indexed_$timestamp.txt

# See indexes size
./get_stats.sh -i

# Remove indexes for Query 1
execute_query_file "./sql/query1_drop_indexes.sql"


# Add indexes for Query 3
execute_query_file "./sql/query3_add_indexes.sql"

# Query 3 Execution with Output
execute_query_file "./sql/query3a.sql" > ./results/res_$timestamp/query3a_indexed_$timestamp.txt

# See indexes size
./get_stats.sh -i

# # Remove indexes for Query 3
execute_query_file "./sql/query3_drop_indexes.sql"


# MATERIALIZED VIEWS

# Query 1 Create materialized view
execute_query_file "./sql/query_create_mv.sql"

# Query 1 on materialized view
execute_query_file query1a_mv.sql > ./results/res_$timestamp/query1a_mv_$timestamp.txt

# Query 3 on materialized view
execute_query_file query3a_mv.sql > ./results/res_$timestamp/query3a_mv_$timestamp.txt

# Query materialized view
execute_query "DROP MATERIALIZED VIEW big_view;"