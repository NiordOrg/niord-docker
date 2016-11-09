#!/bin/bash

#script to create and deploy all containers needed for Niord in a development setup
NIORD_HOME=${NIORD_HOME:-~/.niord}
MYSQL_VERSION=5.7.16
NIORD_KEYCLOAK_VERSION=1.0.1
NIORD_APPSRV_VERSION=1.0.1
NIORD_HTTPD_VERSION=1.0.0

#pull images and create network and containers
full () {
    #pull the latest images
    echo "Pulling latest images"
    docker pull dmadk/niord-appsrv:$NIORD_APPSRV_VERSION
    docker pull dmadk/niord-keycloak:$NIORD_KEYCLOAK_VERSION
    docker pull dmadk/niord-httpd:$NIORD_HTTPD_VERSION
    docker pull mysql:$MYSQL_VERSION

    #create the containers and link them
    echo "Creating containers"
    docker create \
          --name niordkc-mysql \
          --restart=unless-stopped \
          -p 13306:3306 \
          -e MYSQL_ROOT_PASSWORD=mysql \
          -e MYSQL_DATABASE=niordkc \
          -e MYSQL_USER=niordkc \
          -e MYSQL_PASSWORD=niordkc \
          -v $NIORD_HOME/mysql/niordkc:/var/lib/mysql \
          mysql:$MYSQL_VERSION

    docker create \
          --name niord-mysql \
          --restart=unless-stopped \
          -p 13307:3306 \
          -e MYSQL_ROOT_PASSWORD=mysql \
          -e MYSQL_DATABASE=niord \
          -e MYSQL_USER=niord \
          -e MYSQL_PASSWORD=niord \
          -v $NIORD_HOME/mysql/niord:/var/lib/mysql \
          mysql:$MYSQL_VERSION

    docker create \
          --name msi-mysql \
          --restart=unless-stopped \
          -p 13308:3306 \
          -e MYSQL_ROOT_PASSWORD=mysql \
          -e MYSQL_DATABASE=oldmsi \
          -e MYSQL_USER=oldmsi \
          -e MYSQL_PASSWORD=oldmsi \
          -v $NIORD_HOME/mysql/oldmsi:/var/lib/mysql \
          mysql:$MYSQL_VERSION

    docker create \
          --name niord-keycloak \
          --restart=unless-stopped \
          -p 8090:8080 \
          --link niordkc-mysql:kcdb \
          dmadk/niord-keycloak:$NIORD_KEYCLOAK_VERSION

    docker create \
          --name niord-appsrv \
          -p 8080:8080 \
          --link niord-mysql:niorddb \
          --link msi-mysql:msidb \
          -e NIORD_HOME=/opt/niord \
          -v $NIORD_HOME:/opt/niord \
          dmadk/niord-appsrv:$NIORD_APPSRV_VERSION

    docker create \
          --name niord-httpd \
          -p 80:80 \
          -p 443:443 \
          --link niord-appsrv:appsrv \
          --link niord-keycloak:keycloak \
          -e APPSRV_NAME=localhost.e-navigation.net \
          -e KEYCLOAK_NAME=localhost-kc.e-navigation.net \
          -v ~/ssl:/usr/local/apache2/conf/ssl \
          dmadk/niord-httpd:$NIORD_HTTPD_VERSION
}

$1

# start all containers
echo "Starting containers"
docker start niordkc-mysql niord-mysql msi-mysql niord-keycloak niord-appsrv niord-httpd

exit 0
