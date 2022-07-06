#!/bin/sh

mysql_install_db

/etc/init.d/mysql start

if [ -d "/var/lib/mysql/$DATABASE" ]
then
	echo "Database already exists"
else

mysql --user=root -p <<_EOF_

UPDATE mysql.user SET Password=('$DB_ADMIN_PASSWORD') WHERE User='root';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';
FLUSH PRIVILEGES;
_EOF_

echo "CREATE DATABASE IF NOT EXISTS $DATABASE; GRANT ALL ON $DATABASE.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot

fi

/etc/init.d/mysql stop

exec "$@"
