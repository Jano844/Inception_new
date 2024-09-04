FROM alpine:3.18

# Define arguments
ARG PHP_VERSION=81
ARG DB_NAME
ARG DB_USER
ARG DB_PASS

# Update and Upgrade Packeges
# Install PHP
RUN apk update && apk upgrade && apk add --no-cache \
    php${PHP_VERSION} \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-mysqli \
    php${PHP_VERSION}-json \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-dom \
    php${PHP_VERSION}-exif \
    php${PHP_VERSION}-fileinfo \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-openssl \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-zip \
    wget \
    unzip && \
    # Configure PHP-FPM to listen on port 9000
    sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" \
      /etc/php81/php-fpm.d/www.conf && \
    # Set owner and group for PHP-FPM socket
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" \
      /etc/php81/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" \
      /etc/php81/php-fpm.d/www.conf && \
    # Clean up the package cache
    rm -f /var/cache/apk/*

# Set the directory to /var/www/html
# Download latest WordPress
WORKDIR /var/www/html
RUN wget https://wordpress.org/latest.zip && \
    unzip latest.zip && \
    cp -rf wordpress/* . && \
    rm -rf wordpress latest.zip
COPY ./conf/config.sh .

# Run the configuration script
# the remove it and set rights
RUN sh config.sh && rm config.sh && \
    chmod -R 0777 wp-content/
CMD ["/usr/sbin/php-fpm81", "-F"]
