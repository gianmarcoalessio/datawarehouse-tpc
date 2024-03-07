#!/bin/bash

# Generate timestamp
timestamp=$(date +%Y%m%d_%H%M%S)  # Example format: 20231127_153240

# Parameters for Query 3
ship_mode=$1
month_num=$2

# Parameters for Query 4
customer_name=$3
quarter_num=$4

# Database Credentials
db_user="admin"
db_name="dmbd"

# CLEAN

# Query 3 Execution with Output
psql -U $db_user -d $db_name -f project/sql/query3.sql -v ship_mode="$ship_mode" -v month_num="$month_num" > project/results/query3_$timestamp.txt
# to be repeated 3 times, with different parameters?

# Query 4 Execution with Output
psql -U $db_user -d $db_name -f project/sql/query4.sql -v customer_name="$customer_name" -v quarter_num="$quarter_num" > project/results/query4_$timestamp.txt
# to be repeated 3 times, with different parameters


# INDEXES

# Query 3 indexes
psql -U $db_user -d $db_name -f project/sql/query3_indexes.sql

# Query 3 Execution with Output
psql -U $db_user -d $db_name -f project/sql/query3.sql -v ship_mode="$ship_mode" -v month_num="$month_num" > project/results/query3_$timestamp.txt
# to be repeated 3 times, with different parameters

# TODO: is good to run query 4 again after creating the indexes, can the indexes influence the query?

# Query 4 indexes
psql -U $db_user -d $db_name -f project/sql/query4_indexes.sql

# Query 4 Execution with Output
psql -U $db_user -d $db_name -f project/sql/query4.sql -v customer_name="$customer_name" -v quarter_num="$quarter_num" > project/results/query4_$timestamp.txt