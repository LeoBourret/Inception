#!/bin/sh

mysql_install_db

/etc/init.d/mysql start

if [ -d "/var/lib/mysql/$DATABASE" ]
then
	echo "Database already exists"
else

echo "before heredoc"

mysql --user=root --skip-password <<_EOF_

ALTER USER root@localhost IDENTIFIED WITH mysql_native_password;
ALTER USER root@localhost IDENTIFIED BY '$DB_ROOT_PASSWORD';
DELETE FROM mysql.user WHERE User='';
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';
FLUSH PRIVILEGES;
_EOF_


echo "before pipe"

echo "CREATE DATABASE IF NOT EXISTS $DATABASE; GRANT ALL ON $DATABASE.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot -p$DB_ROOT_PASSWORD

sed -i "s/password = /password = $DB_ROOT_PASSWORD/g" /etc/mysql/debian.cnf

fi

echo "before stop"

/etc/init.d/mysql stop

echo "after stop"

exec "$@"
