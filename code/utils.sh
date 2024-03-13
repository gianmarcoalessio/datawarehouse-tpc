# Generate timestamp
timestamp=$(date +%Y%m%d_%H%M%S)  # Example format: 20231127_153240

# Connect to your database 
db_user="admin"
db_name="dmbd"
db_password="admin"

# Export the password as an environment variable, not recommended for production
export PGPASSWORD=$db_password

# Function to execute SQL queries
execute_query_v() {
    psql -U $db_user -d $db_name -c "$1"
}

execute_query() {
    psql -U $db_user -d $db_name -t -c "$1"
}

execute_query_time() {
    time psql -U $db_user -d $db_name -t -c "$1"
}

# Function to execute SQL queries from a file
execute_query_file_time() {
    time psql -U $db_user -d $db_name -f "$1" > /dev/null
}

execute_query_file() {
    psql -U $db_user -d $db_name -f "$1"
}