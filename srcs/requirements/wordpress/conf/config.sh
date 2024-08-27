#!/bin/sh

# Check if wp-config.php already exists
if [ ! -f wp-config.php ]; then
    # Create wp-config.php from sample
    cp wp-config-sample.php wp-config.php

    # Set database details with the values provided by Docker build arguments
    sed -i "s/database_name_here/${DB_NAME}/" wp-config.php
    sed -i "s/username_here/${DB_USER}/" wp-config.php
    sed -i "s/password_here/${DB_PASS}/" wp-config.php
    sed -i "s/localhost/${WORDPRESS_DB_HOST:-localhost}/" wp-config.php

    # Generate and set the unique keys and salts
    curl -s https://api.wordpress.org/secret-key/1.1/salt/ >> wp-config.php
    echo "Unique keys and salts set."

    # Optional: Additional wp-config.php customizations can go here
fi
