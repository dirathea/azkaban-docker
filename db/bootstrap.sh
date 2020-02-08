#!/bin/sh

echo "Start provisioning azkaban"
mysql -h $AZK_MYSQL_HOST -u $AZK_MYSQL_USER -p$AZK_MYSQL_PASSWORD $AZK_MYSQL_DATABASE < /create-all-sql.sql
echo "done"