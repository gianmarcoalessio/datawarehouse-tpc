#!/bin/bash

# Check if a directory argument was provided
if [ $# -eq 0 ]
then
    echo "No directory provided. Please provide a directory as an argument."
    exit 1
fi

# Check if the provided directory exists
if [ ! -d "$1" ]
then
    echo "Directory $1 does not exist."
    exit 1
fi

# Create or clear the output file
echo "filename,real,user,sys" > $1/execution_times.csv

# Loop over .txt files in the directory
for file in $1/*.txt
do
    # Extract the real, user, and sys times using grep and awk
    real_time=$(grep "real" $file | awk '{print $2}')
    user_time=$(grep "user" $file | awk '{print $2}')
    sys_time=$(grep "sys" $file | awk '{print $2}')

    # Write the filename and execution times to the CSV file
    echo "$(basename $file),$real_time,$user_time,$sys_time" >> $1/execution_times.csv
done

echo "Execution times have been written to $1/execution_times.csv."