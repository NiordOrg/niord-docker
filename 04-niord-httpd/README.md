# niord-httpd

An Apache HTTPD server wrapped for use with the niord-appsrv and niord-keycloak docker containers, including configuration for SSL and proxying.

The docker image should be started with parameters for the niord application server and Keycloak server names,
and with a path to a local directory that contains the SSL certificates for the server domain name.
The certificates should be named server.crt, server.key and intermediate.crt (for the CA) respectively.

Example:

    docker run \
      --name niord-httpd \
      -p 80:80 \
      -p 443:443 \
      --link niord-appsrv:appsrv \
      --link niord-keycloak:keycloak \
      -e APPSRV_NAME=localhost.e-navigation.net \
      -e KEYCLOAK_NAME=localhost-kc.e-navigation.net \
      -v ~/ssl:/usr/local/apache2/conf/ssl \
      -d dmadk/niord-httpd:1.0.0

