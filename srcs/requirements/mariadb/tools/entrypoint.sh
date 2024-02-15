#!/bin/bash
set -e

# Create the /run/mysqld directory and change its ownership to mysql
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# Initialize database if necessary
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    # Start the server in the background
    mysqld_safe --datadir=/var/lib/mysql --user=mysql &

    # Allow any signal which would kill a process to stop mysqld
    for i in `seq 30 -1 0`; do
        if echo 'SELECT 1' | mysql &> /dev/null; then
            break
        fi
        sleep 1
    done

    if [ "$i" = 0 ]; then
        echo >&2 'MySQL init process failed.'
        exit 1
    fi

    # Setup user accounts and database
    mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
    mysql -u root -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -u root -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
    mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
    mysql -u root -e "FLUSH PRIVILEGES;"

    # Stop the server
    if ! kill -s TERM "$!" || ! wait "$!"; then
        echo >&2 'MySQL init process failed.'
        exit 1
    fi
fi

# Start the server
exec mysqld --datadir=/var/lib/mysql --bind-address=0.0.0.0 --user=mysql