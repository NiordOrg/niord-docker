#!/bin/bash

NIORD_HOME=${NIORD_HOME:-~/.niord}

VERSION=${1:-1.0.1}
DOCKER_TAG="dmadk/niord-appsrv:$VERSION"

echo "Running $DOCKER_TAG application server with niord.home=$NIORD_HOME"

docker pull $DOCKER_TAG

docker run \
  --name niord-appsrv \
  -p 8080:8080 \
  --link niord-mysql:niorddb \
  --link niord-smtp:niordsmtp \
  --link msi-mysql:msidb \
  -e NIORD_HOME=/opt/niord \
  -v $NIORD_HOME:/opt/niord \
  -d $DOCKER_TAG
