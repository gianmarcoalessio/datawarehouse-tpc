#!/bin/bash

source utils.sh

# Redirect all output to a file with timestamp in the name
exec > "./results/stats_${timestamp}.txt" 2>&1

# Function to gather data statistics
gather_statistics() {
    table=$1  # Pass table name as an argument

    echo "*** Statistics for Table: ${table} ***"

    # Number of rows
    row_count=$(execute_query "SELECT COUNT(*) FROM ${table};")
    echo "Number of rows: ${row_count}"

    # Table size
    table_size=$(execute_query "SELECT pg_size_pretty(pg_total_relation_size('${table}'));")
    echo "Table size: ${table_size}"

    # Distinct values, minimum, and maximum for each query column
    for column in "${COLUMNS[@]}"; do 
        distinct_count=$(execute_query "SELECT COUNT(DISTINCT ${column}) FROM ${table};")
        min_value=$(execute_query "SELECT MIN(${column}) FROM ${table};")
        max_value=$(execute_query "SELECT MAX(${column}) FROM ${table};")

        echo "Column: ${column}"
        echo "  Distinct Values: ${distinct_count}"
        echo "  Minimum: ${min_value}"
        echo "  Maximum: ${max_value}"
    done
    echo ""
}

# Specify the relevant tables 
TABLES=("lineitem" "orders" "part" "supplier" "nation" "region" "customer")
COLUMNS=("l_orderkey" "l_partkey" "l_suppkey" "p_type" "n_name" "o_orderdate") 

# Gather statistics
for table in "${TABLES[@]}"; do
    gather_statistics "$table"
done