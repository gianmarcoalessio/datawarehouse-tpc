#!/bin/bash

source utils.sh

# Parameters for Query 1
nation=$1

# Parameters for Query 3
customer=$2
quarter=$3

# CLEAN

# Query 1 Execution with Output
#psql -U $db_user -d $db_name -f ./sql/query1.sql -v nation="$nation" > ./results/query1_$timestamp.txt
# to be repeated 3 times, with different parameters?

# Query 3 Execution with Output
psql -U $db_user -d $db_name -f ./sql/query3.sql -v customer="$customer" -v quarter="$quarter" > ./results/query3_$timestamp.txt

# INDEXES

# # Add indexes for Query 1
# execute_query_file "./sql/query1_add_indexes.sql"

# # Query 1 Execution with Output
# psql -U $db_user -d $db_name -f ./sql/query1.sql -v nation="$nation" > ./results/query1_indexed_$timestamp.txt

# # Remove indexes for Query 1
# execute_query_file "./sql/query1_drop_indexes.sql"

# # Add indexes for Query 3
# execute_query_file "./sql/query3_add_indexes.sql"

# # Query 3 Execution with Output
# psql -U $db_user -d $db_name -f ./sql/query3.sql -v customer="$customer" -v quarter="$quarter" > ./results/query3_indexed_$timestamp.txt

# # Remove indexes for Query 3
# execute_query_file "./sql/query3_drop_indexes.sql"
