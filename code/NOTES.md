# DMBD Project

See pdf for more information.

## Setup 

### (Optional) Linux configuration

Install the necessary packages
```bash
sudo apt-get update
sudo apt-get upgrade
sudo apt-get -y install build-essential
```

### Postgres configuration

Install postgres for linux:
```bash
sudo sh -c 'echo "deb https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install postgresql-15
```

Start the postgres service:
```bash
# START
sudo systemctl start postgresql
# STOP
sudo systemctl stop postgresql
```

Connect locally to postgres and create an user
```bash
sudo su - postgres
psql -U postgres -d postgres
CREATE USER admin WITH PASSWORD 'admin' SUPERUSER;
```

Allow local connection (not secure, only for testing), in this file change `peer` to `md5`:
```bash
sudo nano /etc/postgresql/15/main/pg_hba.conf

# Locate: local   all             postgres                                peer
# Change to: local   all             postgres                                md5

# Locate: local   all             all                                     peer
# Change to: local   all             all                                     md5

# Restart the service
sudo systemctl restart postgresql
```

Now you can access with
```bash
psql -U admin -d postgres
```
### Sync files from host to guest
```bash
rsync -avz . do-bigdata:~/projectbigdata
```

### Database setup

Follow the script to create the database and the tables, it will compile the dbgen and generate the data.

Run the setup script
```bash
# chmod +x setup.sh
./setup.sh
```

Check the database, password is `admin`
```bash
psql -U admin -d dmbd
```

## Queries

### Setup query 4

Select a Customer and a Quarter
```sql
SELECT c_name FROM customer;
SELECT EXTRACT(QUARTER FROM o_orderdate) FROM orders GROUP BY EXTRACT(QUARTER FROM o_orderdate);
```

Then see `project/sql/query4_template.sql`

### Setup query 3

Select a ship mode and a month number

```sql
dmbd=# SELECT DISTINCT l_shipmode 
FROM LINEITEM;
```

### Run the queries

```bash
# chmod +x run_queries.sh
./run_queries.sh 'MAIL' 7 'Customer#00012345' 3
```