# if wp config get MULTISITE returns 'true', then multisite is enabled
if [[ $(sudo -u www-data wp config get MULTISITE) == "1" ]]; then
    
# if wp config get SUBDOMAIN_INSTALL returns 'true', then subdomain is enabled
if [[ $(sudo -u www-data wp config get SUBDOMAIN_INSTALL) == "1" ]]; then
    echo >&2 "Subdomain multisite is enabled - installing config accordingly"
    mv /etc/nginx/sites-available/wordpress-subdomain.conf /etc/nginx/sites-enabled/default
    return 0
else
    echo >&2 "Subdirectory multisite is enabled - installing config accordingly"
    mv /etc/nginx/sites-available/wordpress-subdirectory.conf /etc/nginx/sites-enabled/default
    return 0
fi
else
    echo >&2 "Multisite is disabled - continuing..."
    return 1
fi