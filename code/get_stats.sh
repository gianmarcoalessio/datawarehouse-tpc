#!/bin/bash

source utils.sh

filename=$1

# Redirect all output to a file with timestamp in the name
exec >$filename 2>&1

# Function to gather data statistics
gather_statistics() {
    OPTIND=1 # Reset OPTIND before each call to getopts
    table=$1 # Pass table name as an argument
    shift    # Shift arguments to the left

    echo $table

    echo "*** Statistics for Table: ${table} ***"

    while getopts "rtic" opt; do
        case ${opt} in
        r)
            # Number of rows
            row_count=$(execute_query "SELECT COUNT(*) FROM ${table};")
            echo "Number of rows: ${row_count}"
            ;;
        t)
            # Table size
            table_size=$(execute_query "SELECT pg_size_pretty(pg_total_relation_size('${table}'));")
            echo "Table size: ${table_size}"
            ;;
        i)  # Index size
            all_sizes=$(execute_query "SELECT indexname, pg_size_pretty(pg_relation_size(indexname::text)) AS index_size FROM pg_indexes WHERE tablename = '${table}';")
            echo "All sizes: ${all_sizes}"
            ;;
        c)
            # Get columns for the table
            COLUMNS=$(execute_query "SELECT column_name FROM information_schema.columns WHERE table_name = '${table}';")

            # Convert COLUMNS to an array
            IFS=$'\n' read -rd '' -a COLUMNS <<<"$COLUMNS"

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
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            ;;
        esac
    done
}

# Specify the relevant tables
TABLES=("lineitem" "orders" "part" "supplier" "nation" "region" "customer")

# Gather statistics
for table in "${TABLES[@]}"; do
    gather_statistics "$table" $2
done
