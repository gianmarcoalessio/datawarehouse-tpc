#!/bin/bash

source utils.sh

# CLEAN

# Query 1 Execution with Output
execute_query_file "./sql/query1a.sql" > ./results/query1a_$timestamp.txt
# to be repeated 3 times, with different parameters?

# Query 3 Execution with Output
execute_query_file "./sql/query3a.sql" > ./results/query3a_$timestamp.txt

# INDEXES

# # Add indexes for Query 1
execute_query_file "./sql/query1_add_indexes.sql"

# # Query 1 Execution with Output
execute_query_file "./sql/query1a.sql" > ./results/query1a_indexed_$timestamp.txt

# # Remove indexes for Query 1
execute_query_file "./sql/query1_drop_indexes.sql"

# # Add indexes for Query 3
execute_query_file "./sql/query3_add_indexes.sql"

# # Query 3 Execution with Output
execute_query_file "./sql/query3a.sql" > ./results/query3a_indexed_$timestamp.txt

# # Remove indexes for Query 3
# execute_query_file "./sql/query3_drop_indexes.sql"

# Query 1 Create materialized view
execute_query_file "./sql/query1a_create_mv.sql"

# Query 1 on materialized view
execute_query "SELECT * FROM mv_query1 WHERE exporting_nation_name = 'FRANCE';" > ./results/query1a_mv_$timestamp.txt

# Query 1 Drop materialized view
execute_query "DROP MATERIALIZED VIEW mv_query1;"