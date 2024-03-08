#!/bin/bash

source utils.sh

# Parameters for Query 1
nation=$1

# Parameters for Query 3
customer=$2
quarter=$3

# CLEAN

# Query 1 Execution with Output
psql -U $db_user -d $db_name -f project/sql/query1.sql -v nation="$nation" > project/results/query1_$timestamp.txt
# to be repeated 3 times, with different parameters?

# Query 3 Execution with Output
psql -U $db_user -d $db_name -f project/sql/query3.sql -v customer="$customer" -v quarter="$quarter" > project/results/query3_$timestamp.txt