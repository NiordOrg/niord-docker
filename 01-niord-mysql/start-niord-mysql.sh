#!/bin/bash

NIORD_HOME=${NIORD_HOME:-~/.niord}

VERSION=${1:-5.7.28}
DOCKER_TAG="mysql:$VERSION"

echo "Running $DOCKER_TAG Niord database with data in $NIORD_HOME/mysql/niord"

docker pull $DOCKER_TAG

docker run \
  --name niord-mysql \
  -p 13307:3306 \
  -e MYSQL_ROOT_PASSWORD=mysql \
  -e MYSQL_DATABASE=niord \
  -e MYSQL_USER=niord \
  -e MYSQL_PASSWORD=niord \
  -v $NIORD_HOME/mysql/niord:/var/lib/mysql \
  -d $DOCKER_TAG

