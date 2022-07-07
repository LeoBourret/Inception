FROM debian:buster

RUN apt-get update && apt-get -y install \
wget \
php \
php-cgi \
php-mysql \
php-fpm \
php-pdo \
php-gd \
php-cli \
php-mbstring \
&& rm -rf /var/lib/apt/list/*

RUN mkdir /run/php

RUN sed -i 's/listen = \/run\/php\/php7\.3-fpm\.sock/listen = 0\.0\.0\.0:9000/g' /etc/php/7.3/fpm/pool.d/www.conf

RUN mkdir /run/php

EXPOSE 9000

CMD ["/usr/sbin/php-fpm", "-F"]
