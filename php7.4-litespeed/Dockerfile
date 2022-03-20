FROM cr.cmptstks.com/cs-public/images/php:7.4-litespeed

LABEL maintainer="https://computestacks.com"
LABEL org.opencontainers.image.authors="https://computestacks.com"
LABEL org.opencontainers.image.source="https://git.cmptstks.com/cs-public/images/wordpress/-/tree/main/php7.4-litespeed"
LABEL org.opencontainers.image.url="https://git.cmptstks.com/cs-public/images/wordpress/-/tree/main/php7.4-litespeed"
LABEL org.opencontainers.image.title="Wordpress with PHP 7.4 and OpenLiteSpeed"

COPY 51-cs-wp.sh /etc/my_init.d/
COPY 51-wordpress.sh /etc/my_init.d/
COPY root/vhosts /usr/src/lsws/conf/vhosts/

RUN rm /usr/src/lsws/conf/httpd_config.conf \
    ; \
    mkdir -p /usr/src/lsws/conf/vhosts/Wordpress \
    && touch /usr/src/lsws/conf/vhosts/Wordpress/htpasswd \
    && touch /usr/src/lsws/conf/vhosts/Wordpress/htgroup \
    && chmod 644 /usr/src/lsws/conf/vhosts/Wordpress/htpasswd \
    && chmod 644 /usr/src/lsws/conf/vhosts/Wordpress/htgroup \
    && chmod +x /etc/my_init.d/*.sh \
    && chown lsadm: -R /usr/src/lsws/conf/vhosts/ \
    ; \
    wget -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp \
    ; \
    mkdir -p /usr/src/wordpress \
    && cd /usr/src/wordpress \
    && wp core download --allow-root \
    && chown -R www-data:www-data /usr/src/wordpress \
    ; \
    wget -O /tmp/cswp.tar.gz https://git.cmptstks.com/cs-public/integrations/cs-wordpress-plugin/-/archive/main/cs-wordpress-plugin-main.tar.gz \
    && tar -xzvf /tmp/cswp.tar.gz --directory /opt \
    && rm -f /tmp/cswp.tar.gz \
    && chown -R www-data: /opt/cs-wordpress-plugin-main

COPY root/httpd_config.conf /usr/src/lsws/conf/httpd_config.conf

VOLUME ["/var/www", "/usr/local/lsws"]
