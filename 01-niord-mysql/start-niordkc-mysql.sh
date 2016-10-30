#!/bin/bash

NIORD_HOME=${NIORD_HOME:-~/.niord}

VERSION=${1:-latest}
DOCKER_TAG="mysql:$VERSION"

echo "Running $DOCKER_TAG Niord Keycloak database with data in $NIORD_HOME/mysql/niordkc"

docker pull $DOCKER_TAG

docker run \
  --name niordkc-mysql \
  -p 13306:3306 \
  -e MYSQL_ROOT_PASSWORD=mysql \
  -e MYSQL_DATABASE=niordkc \
  -e MYSQL_USER=niordkc \
  -e MYSQL_PASSWORD=niordkc \
  -v $NIORD_HOME/mysql/niordkc:/var/lib/mysql \
  -d $DOCKER_TAG


