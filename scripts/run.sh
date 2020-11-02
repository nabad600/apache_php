#!/bin/sh
chown -R www-data:www-data /var/www/;
exec /usr/sbin/httpd -D FOREGROUND -f /etc/apache2/httpd.conf &
exec /usr/sbin/php-fpm7.3 -F
