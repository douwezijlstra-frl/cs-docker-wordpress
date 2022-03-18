#!/bin/bash

echo >&2 "Setting CS WP Env..."

if [ -z ${CS_AUTH_KEY} ]; then
  echo >&2 "CS_AUTH_KEY not set, generating random key..."
  export CS_AUTH_KEY=$(xxd -l24 -ps /dev/urandom | xxd -r -ps | base64 | tr -d = | tr + - | tr / _)
elif [[ ${CS_AUTH_KEY} -lt 20 ]]; then
  echo >&2 "CS_AUTH_KEY is too short to be real, generating random key..."
  export CS_AUTH_KEY=$(xxd -l24 -ps /dev/urandom | xxd -r -ps | base64 | tr -d = | tr + - | tr / _)
fi
sed -i "s/SET_CS_AUTH/$CS_AUTH_KEY/g" /usr/local/lsws/conf/httpd_config.conf

if [ -f /var/www/html/wordpress/wp-content/mu-plugins/cstacks-config.php ]; then
  echo >&2 "Updating ComputeStacks integration with latest version..."
  rm -f /var/www/html/wordpress/wp-content/mu-plugins/cstacks-config.php
  sudo -u www-data cp /opt/cs-wordpress-plugin-main/cstacks-config.php /var/www/html/wordpress/wp-content/mu-plugins/
else
  echo >&2 "ComputeStakcs mu-plugin missing, skipping installation..."
fi
