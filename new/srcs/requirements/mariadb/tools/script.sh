# #!/bin/bash

# # wait until Mariadb is fully stated
# until mysqladmin ping --silent; do
#     echo "Warte auf MariaDB..."
#     sleep 2
# done

# # creating database and the user
# # mysql -e "CREATE DATABASE IF NOT EXISTS $m_db_name;"
# # mysql -e "CREATE USER IF NOT EXISTS '$m_db_user'@'%' IDENTIFIED BY '$m_db_pwd';"
# # mysql -e "GRANT ALL PRIVILEGES ON $m_db_name.* TO '$m_db_user'@'%';"
# # mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '12345';"
# # mysql -e "FLUSH PRIVILEGES;"

# # creating database and the user
# mysql -e "CREATE DATABASE IF NOT EXISTS mariadb_name;"
# mysql -e "CREATE USER IF NOT EXISTS 'mariadb_user'@'%' IDENTIFIED BY 'mariadb_password';"
# mysql -e "GRANT ALL PRIVILEGES ON mariadb_name.* TO 'mariadb_user'@'%';"
# mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '12345';"
# mysql -e "FLUSH PRIVILEGES;"


# # start mariadb and set it to foreground
# exec mysqld


#--------------------------------------


#!/bin/sh

# Start the MariaDB server in the background
service mariadb start

until mysqladmin ping &>/dev/null; do
	echo "wait for Mariadb"
	sleep 1
done


echo "MariaDB is started."

# echo "CREATE DATABASE IF NOT EXISTS $m_db_name ;" > db1.sql
# echo "CREATE USER IF NOT EXISTS '$m_db_user'@'%' IDENTIFIED BY '$m_db_pwd' ;" >> db1.sql
# echo "GRANT ALL PRIVILEGES ON $m_db_name.* TO '$m_db_user'@'%' ;" >> db1.sql
# echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '12345' ;" >> db1.sql
# echo "FLUSH PRIVILEGES;" >> db1.sql

echo "CREATE DATABASE IF NOT EXISTS \`mariadb_name\` ;" > db1.sql
echo "CREATE USER IF NOT EXISTS 'mariadb_user'@'%' IDENTIFIED BY 'mariadb_password' ;" >> db1.sql
echo "GRANT ALL PRIVILEGES ON \`mariadb_name\`.* TO 'mariadb_user'@'%' ;" >> db1.sql
# echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '12345' ;" >> db1.sql
echo "FLUSH PRIVILEGES;" >> db1.sql

mysql < db1.sql

sleep 2

service mariadb stop

sleep 2

exec mariadbd --user=mysql
