# Use the Alpine Linux base image version 3.18
FROM alpine:3.18

# Define build arguments for database user, password, name, and root user
ARG DB_PASS
ARG DB_USER
ARG DB_NAME
ARG DB_ROOT

# Update the package list and install MariaDB server and client without caching the package index
RUN apk update && apk add --no-cache mariadb mariadb-client

# Create the directory for the MariaDB socket, set permissions
# Configure MariaDB for container operation
RUN mkdir /var/run/mysqld; \
    chmod -R 0777 /var/run/mysqld; \
    { echo '[mysqld]'; \
      echo 'skip-host-cache'; \
      echo 'skip-name-resolve'; \
      echo 'bind-address=0.0.0.0'; \
    } | tee /etc/my.cnf.d/docker.cnf; \
    sed -i "s|skip-networking|skip-networking=0|g" \
      /etc/my.cnf.d/mariadb-server.cnf

# Initialize the MariaDB database
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Expose port 3306 to allow external connections to MariaDB
EXPOSE 3306

# Switch to the 'mysql' user
USER mysql

# Copy the entrypoint script to the working directory of the container
COPY ./tools/entrypoint.sh .

# Run the entrypoint script
RUN sh entrypoint.sh

# Set the default command to start MariaDB and disable error logging
CMD ["/usr/bin/mysqld"]

