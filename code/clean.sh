source utils.sh

execute_query_file "./sql/query1a.sql" > ./results/query1a_clean_$timestamp.txt

execute_query_file "./sql/query3a.sql" > ./results/query3a_clean_$timestamp.txt

# Create mv
execute_query_file "./sql/query_create_mv.sql"

execute_query_file "./sql/query1a_bigmv.sql" > ./results/query1a_bigmv_$timestamp.txt

execute_query_file "./sql/query3a_bigmv.sql" > ./results/query3a_bigmv_$timestamp.txt




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