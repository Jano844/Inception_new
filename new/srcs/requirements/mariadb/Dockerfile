FROM alpine:3.18

# install MariaDB and needed Tools
RUN apk update && \
    apk add --no-cache mariadb mariadb-client bash

# copy config file and script
COPY ./conf/my.cnf /etc/mysql/my.cnf
COPY ./tools/script.sh /

# Setze MariaDB Verzeichnisse und Berechtigungen
RUN mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql

RUN chmod +x /script.sh

# start script
CMD ["/script.sh"]