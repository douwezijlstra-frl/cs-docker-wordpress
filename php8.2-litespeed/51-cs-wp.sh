#!/bin/bash

echo >&2 "Setting CS WP Env..."

if [ -z ${CS_AUTH_KEY} ]; then
  echo >&2 "CS_AUTH_KEY not set, generating random key..."
  export CS_AUTH_KEY=$(xxd -l24 -ps /dev/urandom | xxd -r -ps | base64 | tr -d = | tr + - | tr / _)
fi

# Ensure we always have the correct auth key.
sed -i "s/CS_AUTH_KEY=.*/CS_AUTH_KEY=$CS_AUTH_KEY/g" /usr/local/lsws/conf/httpd_config.conf

# if it does not exist, create it.
grep -q -e 'CS_AUTH_KEY' /usr/local/lsws/conf/httpd_config.conf || sed -i "/extprocessor lsphp/a  env                     CS_AUTH_KEY=$CS_AUTH_KEY" /usr/local/lsws/conf/httpd_config.conf

if [ -f /var/www/html/wordpress/wp-content/mu-plugins/cstacks-config.php ]; then
  echo >&2 "Updating ComputeStacks integration with latest version..."
  rm -f /var/www/html/wordpress/wp-content/mu-plugins/cstacks-config.php
  sudo -u www-data cp /opt/cs-wordpress-plugin-main/cstacks-config.php /var/www/html/wordpress/wp-content/mu-plugins/
  grep -q -e 'CS_PLUGIN_DIR' /var/www/html/wordpress/wp-config.php || sed -i "/WP_MEMORY_LIMIT/a define( 'CS_PLUGIN_DIR', '/opt/cs-wordpress-plugin-main' );" /var/www/html/wordpress/wp-config.php
else
  echo >&2 "ComputeStakcs mu-plugin missing, skipping installation..."
fi
