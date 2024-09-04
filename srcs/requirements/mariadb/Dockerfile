FROM alpine:3.18

# Define arguments
ARG DB_PASS
ARG DB_USER
ARG DB_NAME
ARG DB_ROOT

RUN apk update && apk add --no-cache mariadb mariadb-client

RUN mkdir /var/run/mysqld; \
    chmod -R 0777 /var/run/mysqld; \
    { echo '[mysqld]'; \
      echo 'skip-host-cache'; \
      echo 'skip-name-resolve'; \
      echo 'bind-address=0.0.0.0'; \
    } | tee /etc/my.cnf.d/docker.cnf; \
    sed -i "s|skip-networking|skip-networking=0|g" \
      /etc/my.cnf.d/mariadb-server.cnf

# init the MariaDB
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Open port to allow connections to MariaDB
EXPOSE 3306
USER mysql

# Copy and Run the script
COPY ./tools/entrypoint.sh .
RUN sh entrypoint.sh
CMD ["/usr/bin/mysqld"]

