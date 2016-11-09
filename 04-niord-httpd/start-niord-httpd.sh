#!/bin/bash

VERSION=${1:-1.0.0}
DOCKER_TAG="dmadk/niord-httpd:$VERSION"

echo "Running $DOCKER_TAG "

docker pull $DOCKER_TAG

docker run \
  --name niord-httpd \
  -p 80:80 \
  -p 443:443 \
  --link niord-appsrv:appsrv \
  --link niord-keycloak:keycloak \
  -e APPSRV_NAME=localhost.e-navigation.net \
  -e KEYCLOAK_NAME=localhost-kc.e-navigation.net \
  -v ~/ssl:/usr/local/apache2/conf/ssl \
  -d $DOCKER_TAG
