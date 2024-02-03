#!/bin/bash

service mariadb start


kill $(cat /var/run/mysqld/mysqld.pid)
exec mysqld --bind-address=0.0.0.0
