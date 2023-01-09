FROM php:7.2-apache-buster

ENV APACHE_DOCUMENT_ROOT /var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

#RUN apt install -y zlib1g \
#    && docker-php-ext-configure zip --with-libzip --with-zlib-dir=/usr/include \
#    && docker-php-ext-install pdo pdo_mysql mysqli zip
#RUN apt install -y zlib1g \
#    && docker-php-ext-configure zip --with-libzip --with-zlib-dir=/usr/include \
#    && docker-php-ext-install pdo pdo_mysql mysqli zip

RUN a2enmod rewrite

RUN docker-php-ext-install pdo pdo_mysql mysqli

# LDAP Installation
RUN apt-get update \
 && apt-get install libldap2-dev -y \
 && rm -rf /var/lib/apt/lists/* \
 && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
 && docker-php-ext-install ldap

RUN yes | pecl install xdebug-2.7.0 \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini

RUN usermod -u 431 www-data

RUN set -eux; apt-get update; apt-get install -y libzip-dev zlib1g-dev; docker-php-ext-install zip

RUN apt-get install -y mariadb-client

RUN apt-get -y update; apt-get install -y libicu-dev; docker-php-ext-configure intl; docker-php-ext-install intl

RUN echo "<?php phpinfo(); ?>" > /var/www/html/info.php\
    && php -m > /var/www/html/php1.html