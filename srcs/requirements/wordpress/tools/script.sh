#!/bin/bash

# Erstelle Verzeichnisse für die WordPress-Dateien, geh da hin loesche alles was noch drinne war

sleep 8

mkdir -p /var/www/html
cd /var/www/html
rm -rf *

# Lade die neueste WordPress-Version herunter
wp core download --allow-root

#Kopiere wp config an richtigen ort
cp /wp-config.php /var/www/html/wp-config.php

# Ersetze Platzhalter in der Konfigurationsdatei durch Umgebungsvariablen
sed -i -r "s/db1/$m_db_name/1"   /var/www/html/wp-config.php
sed -i -r "s/user1/$m_db_user/1"  /var/www/html/wp-config.php
sed -i -r "s/pwd1/$m_db_pwd/1"    /var/www/html/wp-config.php

# Installiere und konfiguriere WordPress
wp core install --url=$DOMAIN_NAME/ --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

# Erstelle einen neuen Benutzer

if ! wp user get $WP_USER --allow-root > /dev/null 2>&1; then
	wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root
else
	echo "Benutzer $WP_USER existiert bereits."
fi


# Installiere  Theme und Plugin
wp theme install astra --allow-root
# wp plugin install redis-cache --allow-root

# Konfiguriere PHP-FPM für die Port-Bindung

sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 0.0.0.0:9000|g' /etc/php/7.4/fpm/pool.d/www.conf
mkdir -p /run/php

# wp user list --allow-root
# to check all users in database

echo "HelloWorld"
cat /etc/php/7.4/fpm/pool.d/www.conf | grep "listen ="

exec php-fpm7.4 -F
