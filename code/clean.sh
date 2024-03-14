source utils.sh

# Create partitioned table
execute_query_file "./sql/create_horizontal_fragmentation.sql"

echo "lineitem_returned size: $(execute_query "SELECT pg_size_pretty(pg_total_relation_size('lineitem_returned'));")" >> ./results/res_$timestamp/stat_mv_$timestamp.txt
echo "lineitem_not_returned size: $(execute_query "SELECT pg_size_pretty(pg_total_relation_size('lineitem_not_returned'));")" >> ./results/res_$timestamp/stat_mv_$timestamp.txt


execute_query_file_time ./sql/query1a_hf.sql 2> ./results/query1a_hf_$timestamp.txt

execute_query_file_time ./sql/query3a_hf.sql 2> ./results/query3a_hf_$timestamp.txt


# Remove indexes for Query 1
execute_query_file "./sql/query1_drop_indexes.sql"

# Remove indexes for Query 3
execute_query_file "./sql/query3_drop_indexes.sql"

# Query materialized view
execute_query_v "DROP MATERIALIZED VIEW big_view;"

# Query materialized view
execute_query "DROP MATERIALIZED VIEW mv_query1;"

# Query materialized view
execute_query "DROP MATERIALIZED VIEW mv_query3;"

# Drop partitioned table
execute_query_file "./sql/drop_horizontal_fragmentation.sql"