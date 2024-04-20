#!/bin/bash

sleep 2

# Initialize database if necessary
if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
    echo "Initializing database..."

    # Start the server in the background
    mysqld_safe --datadir=/var/lib/mysql --user=mysql &
    sleep 5

    # Setup user and database
    mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};" -h localhost
    mysql -u root -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD_FILE}';" -h localhost
    mysql -u root -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO 'root'@'%';" -h localhost
    mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}'; FLUSH PRIVILEGES;" -h localhost

    # Shutdown the server
    mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown
else
    echo "Database already initialized"
fi

# Start the server
exec mysqld --bind-address=0.0.0.0 --user=mysql
