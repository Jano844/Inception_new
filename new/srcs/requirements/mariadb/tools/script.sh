#!/bin/sh

# Start the MariaDB server in the background
echo "HelloWorld" 

service mariadb start

until mysqladmin ping &>/dev/null; do
	echo "wait for Mariadb"
	sleep 1
done


# echo "MariaDB is started."

echo "CREATE DATABASE IF NOT EXISTS \`$m_db_name\` ;" > db1.sql
echo "CREATE USER IF NOT EXISTS '$m_db_user'@'%' IDENTIFIED BY '$m_db_pwd' ;" >> db1.sql
echo "GRANT ALL PRIVILEGES ON \`$m_db_name\`.* TO '$m_db_user'@'%' ;" >> db1.sql
# echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '12345' ;" >> db1.sql
echo "FLUSH PRIVILEGES;" >> db1.sql

mysql < db1.sql

sleep 2

service mariadb stop

sleep 2

exec mariadbd --user=mysql
