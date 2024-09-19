# # Use the Alpine Linux base image version 3.18
# FROM alpine:3.18

# # Install PHP and necessary extensions
# # Install bash for compatibility with the script
# RUN apk update && \
#     apk add --no-cache \
#         php8 \
#         php8-fpm \
#         php8-mysqli \
#         php8-curl \
#         curl \
#         bash  

# # Copy configuration files and scripts, add needed permissions
# COPY ./tools/script.sh /script.sh
# COPY ./conf/wp-config.php /wp-config.php
# RUN chmod +x /script.sh

# # Start the script
# CMD ["/script.sh"]




# Use the Alpine Linux base image version 3.18
FROM alpine:3.18

# Define arguments
ARG PHP_VERSION=81

# Update and Upgrade Packages
# Install PHP and necessary extensions
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
    curl \
    bash \
    php81-phar \
    wget \
    unzip && \
    # Configure PHP-FPM to listen on port 9000
    sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    # Set owner and group for PHP-FPM socket
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    # Clean up the package cache
    rm -f /var/cache/apk/*

# Copy configuration files and scripts, add needed permissions
COPY ./tools/script.sh /script.sh
COPY ./conf/wp-config.php /wp-config.php
RUN chmod +x /script.sh

# Start the script
CMD ["/script.sh"]

