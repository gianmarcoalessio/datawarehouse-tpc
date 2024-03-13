#!/bin/bash

source utils.sh

mkdir -p ./results/res_$timestamp

# See stats
./get_stats.sh ./results/res_$timestamp/stat_idx_$timestamp.txt -rti

# CLEAN

# Repeat Query 1 Execution with Output 10 times
for i in {1..10}
do
  execute_query_file_time "./sql/query1a.sql" 2> ./results/res_$timestamp/query1a_clean_${i}_$timestamp.txt
done

# Repeat Query 3 Execution with Output 10 times
for i in {1..10}
do
  execute_query_file_time "./sql/query3a.sql" 2> ./results/res_$timestamp/query3a_clean_${i}_$timestamp.txt
done

# INDEXES

# Add indexes for Query 1
execute_query_file "./sql/query1_add_indexes.sql"

# Repeat Query 1 Execution with Output 10 times
for i in {1..10}
do
  execute_query_file_time "./sql/query1a.sql" 2> ./results/res_$timestamp/query1a_indexed_${i}_$timestamp.txt
done

# See indexes size of query 1
./get_stats.sh ./results/res_$timestamp/stat_idx1_$timestamp.txt -rti

# Remove indexes for Query 1
execute_query_file "./sql/query1_drop_indexes.sql"

# Add indexes for Query 3
execute_query_file "./sql/query3_add_indexes.sql"

# Repeat Query 3 Execution with Output 10 times
for i in {1..10}
do
  execute_query_file_time "./sql/query3a.sql" 2> ./results/res_$timestamp/query3a_indexed_${i}_$timestamp.txt
done

# See indexes size of query 3
./get_stats.sh ./results/res_$timestamp/stat_idx3_$timestamp.txt -rti

# Remove indexes for Query 3
execute_query_file "./sql/query3_drop_indexes.sql"


# MATERIALIZED VIEWS BIG

# Query 1 Create big materialized view
execute_query_file "./sql/query_create_mv.sql"

# Repeat Query 1 on big materialized view 10 times
for i in {1..10}
do
  execute_query_file_time ./sql/query1a_bigmv.sql 2> ./results/res_$timestamp/query1a_bigmv_${i}_$timestamp.txt
done

# Repeat Query 3 on big materialized view 10 times
for i in {1..10}
do
  execute_query_file_time ./sql/query3a_bigmv.sql 2> ./results/res_$timestamp/query3a_bigmv_${i}_$timestamp.txt
done

# See materialized view size
./get_stats.sh ./results/res_$timestamp/stat_bigmv_$timestamp.txt -rti

# Query materialized view
execute_query "DROP MATERIALIZED VIEW big_view;"


# MATERIALIZED VIEWS

# Query 1 Create materialized view
execute_query_file "./sql/query1a_create_mv.sql"

# Repeat Query 1 on materialized view 10 times
for i in {1..10}
do
  execute_query_file_time ./sql/query1a_mv.sql 2> ./results/res_$timestamp/query1a_mv_${i}_$timestamp.txt
done

# See table size
./get_stats.sh ./results/res_$timestamp/stat_mv1_$timestamp.txt -rti

# Query materialized view
execute_query "DROP MATERIALIZED VIEW mv_query1;"

# Query 3 Create materialized view
execute_query_file "./sql/query3a_create_mv.sql"

# Repeat Query 3 on materialized view 10 times
for i in {1..10}
do
  execute_query_file_time ./sql/query3a_mv.sql 2> ./results/res_$timestamp/query3a_mv_${i}_$timestamp.txt
done

# See table size
./get_stats.sh ./results/res_$timestamp/stat_mv3_$timestamp.txt -rti

# Query materialized view
execute_query "DROP MATERIALIZED VIEW mv_query3;"