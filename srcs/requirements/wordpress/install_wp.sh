#! /bin/sh

if [ -f "/var/www/html/wordpress/wp_installed" ]
then
	echo "wp is already installed."
else
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /bin/wp
	chmod +x /bin/wp

	mkdir -p /var/www/html/wordpress
	chmod -R 755 /var/www/html/wordpress
	chown -R 1000:1000 /var/www/html/wordpress

	rm -f /var/www/html/wordpress/wp-config.php
	rm -f /var/www/html/wordpress/wp-config-sample.php

	wp core download --path=/var/www/html/wordpress --locale=fr_FR --allow-root
	wp config create --dbname="$DATABASE" --dbuser="$DB_USER" --dbpass="$DB_USER_PASSWORD" --dbhost="$HOSTNAME" --path=/var/www/html/wordpress --allow-root
	wp core install --url="$DOMAIN_NAME" --title="$TITLE" --admin_user="$WP_ADMIN" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --path="/var/www/html/wordpress" --allow-root
	wp user create $WP_USER $WP_USER_EMAIL --role="author" --user_pass="$WP_USER_PASSWORD" --path="/var/www/html/wordpress" --allow-root

	touch /var/www/html/wordpress/wp_installed
fi

echo "install_wp script done"

exec "$@"
