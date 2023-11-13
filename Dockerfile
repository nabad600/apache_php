FROM alpine:3.18
MAINTAINER Naba Das <nabad600@gmail.com>
RUN apk add --no-cache \
    apache2-proxy \
    php7-fpm \
    php7 \
    php7-opcache \
    php7-phar \
    php7-json \
    php7-iconv \
    php7-xml \
    php7-mbstring \
    php7-openssl \
    php7-pdo \
    php7-ldap \
    php7-gd \
    php7-curl \
    php7-ctype \
    php7-dom \
    php7-common \
    php7-pdo_mysql \
    php7-session \
    php7-soap \
    grep \
    git \
    curl \
    vim 
RUN  rm -rf /etc/init.d/*; \
     mkdir /run/apache2; \
     addgroup -g 1000 -S site; \
     adduser -G site -u 1000 -s /bin/sh -D site; \
     sed -rie 's|;error_log = log/php7/error.log|error_log = /dev/stdout|g' /etc/php7/php-fpm.conf 
COPY httpd7.conf /etc/apache2/httpd.conf
COPY www7.conf /etc/php7/php-fpm.d/www.conf
COPY php7.ini /etc/php7/php.ini
COPY scripts /scripts
RUN chmod -R 755 /scripts
CMD ["/scripts/run.sh"]
