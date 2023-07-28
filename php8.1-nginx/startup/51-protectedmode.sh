# create file for protected mode if it doesn't exist yet
# if $PROTECTED_USERNAME and $PROTECTED_PASSWORD are set, create htpasswd file
if [[ -z "$PROTECTED_USERNAME" ]] || [[ -z "$PROTECTED_PASSWORD" ]]; then
  echo "Username and password not set, skipping protected mode"
  # make sure that the auth_basic parameter is set to off in /etc/nginx/sites-enabled/default
  sed -i 's/auth_basic .*/auth_basic off;/g' /etc/nginx/sites-enabled/default
else
  # create htpasswd file
  HTPASSWD_FILE="/etc/nginx/.htpasswd"  # Change this path to your preferred location for the htpasswd file

  # Generate the password hash using htpasswd utility
  HTPASSWD_HASH=$(openssl passwd -apr1 $PROTECTED_PASSWORD)

  #  Create or update the htpasswd file
  echo "$PROTECTED_USERNAME:$HTPASSWD_HASH" > $HTPASSWD_FILE

  # Set appropriate permissions for the htpasswd file (adjust if needed)
  chmod 640 $HTPASSWD_FILE
  chown root:www-data $HTPASSWD_FILE
  # add nested if loop, if $PROTECTED_ENABLED is set to true, enable protected mode
  if [[ "$PROTECTED_ENABLED" == 'true' ]]; then
    echo "Protected mode enabled"
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
  else
    echo "Protected mode disabled"
    # make sure that auth_basic parameter in /etc/nginx/sites-enabled/default is set to on
    sed -i 's/auth_basic .*/auth_basic off;/g' /etc/nginx/sites-enabled/default

  fi

fi