#!/bin/sh
 
set -e
 
# Determine the Application Root Path
if [ -z "$APP_ENV" ]
then
  # By default, assume root context
  export H_REF="/";
  export APP_ENV="/";
else
  # Ensure that H_REF has a trailing slash
  export H_REF="$APP_ENV/";
  # Update the base H_REF with the Application Root Path
  sed -i 's#<base href="/"#<base href="'${H_REF}'"#' /usr/share/nginx/html/index.html
  # Insert a rewrite rule to reflect the Application Root
  REWRITE="\            rewrite\ ^${APP_ENV}(\/\|\$)(\.\*)\ \/\$2\ break;"
  sed -i "/location.*/a ${REWRITE}" /etc/nginx/nginx.conf
fi
 
# Generate an env.js for the current environment
# envsubst < /usr/share/nginx/html/env.template.js > /usr/share/nginx/html/env.js
 
nginx -g 'daemon off;'