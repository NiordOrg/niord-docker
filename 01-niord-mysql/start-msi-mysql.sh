#!/bin/bash

NIORD_HOME=${NIORD_HOME:-~/.niord}

VERSION=${1:-1.0.0}
DOCKER_TAG="dmadk/niord-mysql:$VERSION"

echo "Running $DOCKER_TAG legacy MSI database with data in $NIORD_HOME/mysql/oldmsi"

docker pull $DOCKER_TAG

docker run \
  --name msi-mysql \
  -p 13308:3306 \
  -e MYSQL_ROOT_PASSWORD=mysql \
  -e MYSQL_DATABASE=oldmsi \
  -e MYSQL_USER=oldmsi \
  -e MYSQL_PASSWORD=oldmsi \
  -v $NIORD_HOME/mysql/oldmsi:/var/lib/mysql \
  -d $DOCKER_TAG

