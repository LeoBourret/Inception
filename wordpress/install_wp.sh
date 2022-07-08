#! /bin/sh

if [ -f "/var/www/html/wp_installed" ]
then
	echo "wp is already installed."
else
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /bin/wp
	chmod +x /bin/wp

	mkdir -p /var/www/html
	chmod -R 755 /var/www/html
	chown -R 1000:1000 /var/www/html

	rm -f /var/www/html/wp-config.php
	rm -f /var/www/html/wp-config-sample.php

	wp core download --path=/var/www/html/ --locale=fr_FR --allow-root
	wp config create --dbname="$DATABASE" --dbuser="$USER" --dbpass="$PASSWORD" --dbhost="$HOSTNAME" --path=/var/www/html/ --allow-root
	wp core install --url="$DOMAIN_NAME" --title="$TITLE" --admin_user="$DB_ADMIN" --admin_password="$DB_ADMIN_PASSWORD" --admin_email="$DB_ADMIN_MAIL" --path="/var/www/html" --allow-root
	wp user create $DB_USER $DB_USER_MAIL --role="author" --user_pass="$DB_USER_PASSWORD" --path="/var/www/html" --allow-root

	touch /var/www/html/wp_installed
fi

echo "install_wp script done"

exec "$@"
