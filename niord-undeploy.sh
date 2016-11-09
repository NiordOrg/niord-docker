#!/bin/bash

echo "Stopping containers"
docker stop niordkc-mysql niord-mysql msi-mysql niord-keycloak niord-appsrv niord-httpd

full ()
{
    echo "Removing containers"
    docker rm niordkc-mysql niord-mysql msi-mysql niord-keycloak niord-appsrv niord-httpd
}

$1

exit 0
