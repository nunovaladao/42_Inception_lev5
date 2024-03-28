#! /bin/bash

# Modify PHP-FPM configuration
sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = wordpress:9000|' /etc/php/7.4/fpm/pool.d/www.conf

# Cria o diretório para o PHP
mkdir -p /run/php/

# Check if wp-config.php exists
if [ ! -f /var/www/html/wordpress/wp-config.php ]; then

    # Install WP-CLI
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp && \
    chmod +x /usr/local/bin/wp

    mkdir -p /var/www/html/wordpress
    cd /var/www/html/wordpress
    wp core download --allow-root # Download WordPress

    sleep 5
    cp wp-config-sample.php wp-config.php # Create wp-config.php

    # Modify wp-config.php
    wp config set DB_NAME ${MYSQL_DATABASE} --allow-root
    wp config set DB_USER ${MYSQL_USER} --allow-root
    wp config set DB_PASSWORD ${MYSQL_PASSWORD} --allow-root
    wp config set DB_HOST ${MYSQL_HOST} --allow-root

    # Install WordPress
    wp core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" \
    --admin_email="$WP_ADMIN_EMAIL" --skip-email --allow-root
    wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASSWORD --allow-root
else 
    echo "Wordpress already installed and configured"
fi

# Start PHP-FPM
exec php-fpm7.4 -F