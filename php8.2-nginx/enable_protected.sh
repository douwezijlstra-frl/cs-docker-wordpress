#!/bin/bash

# Check if the required arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <username> <password>"
    exit 1
fi

# Set the path for the htpasswd file
HTPASSWD_FILE="/etc/nginx/.htpasswd"  # Change this path to your preferred location for the htpasswd file

# Generate the password hash using htpasswd utility
HTPASSWD_HASH=$(openssl passwd -apr1 $2)

# Create or update the htpasswd file
echo "$1:$HTPASSWD_HASH" > $HTPASSWD_FILE

# Set appropriate permissions for the htpasswd file (adjust if needed)
chmod 640 $HTPASSWD_FILE
chown root:www-data $HTPASSWD_FILE

# check if .htpasswd file exists
if [ -f /etc/nginx/.htpasswd ]; then
  continue
else
  # exit with error htpasswd file could not be created
    echo "htpasswd file not found - protected mode could not be enabled"
    exit 1
fi


# Modify the Nginx server configuration to enable basic authentication
sed -i 's/auth_basic off;/auth_basic "Protected";/' /etc/nginx/sites-enabled/default

# Check if the Nginx configuration is valid
nginx -t

# If the configuration test is successful, reload Nginx to apply changes
if [ $? -eq 0 ]; then
    nginx -s reload
else
    echo "Nginx configuration test failed. Please check your configuration files."
fi

echo "Basic authentication enabled for the 'WordPress' site."