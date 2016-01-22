#!/bin/bash

mysql=( mysql --protocol=socket -uroot -p"${MYSQL_ROOT_PASSWORD}" )

"${mysql[@]}" <<-EOSQL
    CREATE DATABASE IF NOT EXISTS '${MYSQL_DATABASE}';
    GRANT ALL ON '${MYSQL_DATABASE}'.* TO '${MYSQL_USER}'@'%' ;
EOSQL
