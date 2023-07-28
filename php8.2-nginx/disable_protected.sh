#!/bin/bash

# change anything that starts with auth_basic to auth_basic off
sed -i 's/auth_basic .*/auth_basic off;/g' /etc/nginx/sites-enabled/default