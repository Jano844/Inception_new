FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && apt-get install -y php php7.4-fpm php-gd wget php-mysqli 

RUN mkdir -p /var/www/html /run/php

RUN chown -R www-data:www-data /var/www/html
RUN chown -R www-data:www-data /run/php


RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp
RUN apt-get install nano
WORKDIR /var/www/html

# Copy configuration files and scripts, add needed permissions
COPY ./tools/script.sh /script.sh
COPY ./conf/wp-config.php /wp-config.php
RUN chmod +x /script.sh

# Start the script
CMD ["/script.sh"]

