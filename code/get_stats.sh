#!/bin/bash

source utils.sh

# Redirect all output to a file with timestamp in the name
exec > "project/results/stats_${timestamp}.txt" 2>&1

# Specify relevant tables and columns for Query 1 and 3
TABLES=("lineitem" "orders" "customer" "supplier" "nation" "region") 
COLUMNS=("l_orderkey" "l_suppkey" "o_orderdate" "l_extendedprice" "l_discount" "s_nationkey" "c_nationkey" "n_regionkey" "r_regionkey" "l_returnflag" "c_name" "c_custkey") 


# Get table sizes
echo "*** Table Sizes ***"
execute_query "SELECT relname AS table_name, n_live_tup AS estimated_row_count FROM pg_stat_user_tables;"

# Get distinct value counts
echo "*** Distinct Value Counts ***"
for table in "${TABLES[@]}"; do
    for column in "${COLUMNS[@]}"; do
        execute_query "SELECT '$table' as table_name, '$column' as column_name, n_distinct FROM pg_stats WHERE tablename = '$table' AND attname = '$column';"
    done
done

# Get Min/Max (adjust as needed)
echo "*** Minimum and Maximum Values ***"
for table in "${TABLES[@]}"; do
    for column in "${COLUMNS[@]}"; do
        execute_query "SELECT '$table' as table_name, '$column' as column_name, min($table.$column), max($table.$column) FROM $table;"
    done
done

# All the tables this time
TABLES=("lineitem" "orders" "customer" "supplier" "nation" "region" "part" "partsupp")
# Get table sizes in a human-readable format
echo "*** Table Sizes (Human-Readable) ***"
for table in "${TABLES[@]}"; do
    execute_query "SELECT '$table' as table_name, pg_size_pretty(pg_relation_size('$table')) as table_size_pretty FROM $table;"
done
