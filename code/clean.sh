source utils.sh

# Remove indexes for Query 1
execute_query_file "./sql/query1_drop_indexes.sql"

# # Remove indexes for Query 3
execute_query_file "./sql/query3_drop_indexes.sql"

# Query materialized view
execute_query "DROP MATERIALIZED VIEW big_view;"