FROM alpine:3.5
MAINTAINER Smruti Ranjan Tripathy <smrutirtripathy@gmail.com>
RUN apk add --no-cache \
    apache2-proxy \
    php7.1-fpm \
    php7.1 \
    php7.1-opcache \
    php7.1-phar \
    php7.1-json \
    php7.1-iconv \
    php7.1-xml \
    php7.1-mbstring \
    php7.1-openssl \
    php7.1-pdo \
    php7.1-ldap \
    php7.1-gd \
    php7.1-curl \
    php7.1-ctype \
    php7.1-dom \
    php7.1-common \
    php7.1-pdo_mysql \
    php7.1-session \
    php7.1-soap \
    grep \
    git \
    curl \
    vim 
RUN  rm -rf /etc/init.d/*; \
     mkdir /run/apache2; \
     addgroup -g 1000 -S site; \
     adduser -G site -u 1000 -s /bin/sh -D site; \
     sed -rie 's|;error_log = log/php7/error.log|error_log = /dev/stdout|g' /etc/php7/php-fpm.conf 
COPY httpd.conf /etc/apache2/httpd.conf
COPY www.conf /etc/php7/php-fpm.d/www.conf
COPY php.ini /etc/php7/php.ini
COPY scripts /scripts
RUN chmod -R 755 /scripts
CMD ["/scripts/run.sh"]



