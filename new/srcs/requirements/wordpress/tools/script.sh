#!/bin/bash

# Protokollierung aktivieren
set -e

# Erstelle Verzeichnisse für die WordPress-Dateien
mkdir -p /var/www/html

# Wechsle in das Verzeichnis, in dem WordPress installiert wird
cd /var/www/html

# Lösche alle Dateien im Verzeichnis
rm -rf *

# Lade das WP-CLI-Tool herunter
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Mache das WP-CLI-Tool ausführbar
chmod +x wp-cli.phar

# Verschiebe WP-CLI an den Ort, an dem es ausgeführt werden kann
mv wp-cli.phar /usr/local/bin/wp

# Lade die neueste WordPress-Version herunter
wp core download --allow-root

# Kopiere die benutzerdefinierte Konfigurationsdatei
cp /wp-config.php /var/www/html/wp-config.php

# Ersetze Platzhalter in der Konfigurationsdatei durch Umgebungsvariablen
sed -i -r "s/db1/$m_db_name/1"   /var/www/html/wp-config.php
sed -i -r "s/user/$m_db_user/1"  /var/www/html/wp-config.php
sed -i -r "s/pwd/$m_db_pwd/1"    /var/www/html/wp-config.php

cat /var/www/html/wp-config.php

# Installiere und konfiguriere WordPress
wp core install --url=$DOMAIN_NAME/ --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

# Erstelle einen neuen Benutzer
wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root

# Installiere und aktiviere ein Theme
wp theme install astra --activate --allow-root

# Installiere und aktiviere ein Plugin
wp plugin install redis-cache --activate --allow-root

# Aktualisiere alle Plugins
wp plugin update --all --allow-root

# Konfiguriere PHP-FPM für die Port-Bindung
sed -i 's|listen = /run/php/php-fpm.sock|listen = 9000|g' /etc/php8/php-fpm.d/www.conf

# Erstelle das Verzeichnis für PHP-FPM
mkdir -p /run/php

# **Überprüfung, ob PHP-FPM gestartet wird**
echo "Starte PHP-FPM..."
php-fpm -F &
sleep 5

# **Überprüfe, ob PHP-FPM auf Port 9000 lauscht**
echo "Überprüfe, ob PHP-FPM auf Port 9000 lauscht..."
if ! netstat -tuln | grep ":9000"; then
    echo "PHP-FPM läuft nicht auf Port 9000! Überprüfe die Konfiguration."
    exit 1
fi

echo "PHP-FPM läuft auf Port 9000."

# Aktiviere Redis-Cache
wp redis enable --allow-root

# Überprüfe, ob Redis funktioniert
if ! wp redis status --allow-root; then
    echo "Redis funktioniert nicht! Überprüfe die Redis-Konfiguration."
    exit 1
fi

# **Überprüfe PHP-FPM-Prozess**
if ! pgrep php-fpm > /dev/null; then
    echo "PHP-FPM-Prozess läuft nicht. Bitte überprüfe die Logs."
    exit 1
fi

echo "PHP-FPM-Prozess läuft erfolgreich."

# Starte Nginx im Vordergrund
nginx -g "daemon off;"
