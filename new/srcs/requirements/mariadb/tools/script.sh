#!/bin/bash

# wait until Mariadb is fully stated
until mysqladmin ping --silent; do
    echo "Warte auf MariaDB..."
    sleep 2
done

# creating database and the user
# mysql -e "CREATE DATABASE IF NOT EXISTS $m_db_name;"
# mysql -e "CREATE USER IF NOT EXISTS '$m_db_user'@'%' IDENTIFIED BY '$m_db_pwd';"
# mysql -e "GRANT ALL PRIVILEGES ON $m_db_name.* TO '$m_db_user'@'%';"
# mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '12345';"
# mysql -e "FLUSH PRIVILEGES;"

# creating database and the user
mysql -e "CREATE DATABASE IF NOT EXISTS mariadb_name;"
mysql -e "CREATE USER IF NOT EXISTS 'mariadb_user'@'%' IDENTIFIED BY 'mariadb_password';"
mysql -e "GRANT ALL PRIVILEGES ON mariadb_name.* TO 'mariadb_user'@'%';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '12345';"
mysql -e "FLUSH PRIVILEGES;"


# start mariadb and set it to foreground
exec mysqld
