#!/bin/bash

# Start MySQL
/sbin/service mysqld start

mysql -e 'CREATE DATABASE IF NOT EXISTS `b2`;'

# Start Apache
/usr/local/apache/bin/apachectl start

tail -f /usr/local/apache/logs/error_log