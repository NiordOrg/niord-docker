#!/bin/bash


echo "Updating HTTPD configuration with Niord Keycloak server: $KEYCLOAK_NAME"
sed -i 's@KEYCLOAK_NAME@'"$KEYCLOAK_NAME"'@' /usr/local/apache2/conf/niord.conf

echo "Updating HTTPD configuration with Niord application server: $APPSRV_NAME"
sed -i 's@APPSRV_NAME@'"$APPSRV_NAME"'@' /usr/local/apache2/conf/niord.conf

echo "Starting Apache HTTPD"
httpd-foreground
