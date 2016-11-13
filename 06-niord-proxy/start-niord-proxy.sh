#!/bin/bash

NIORD_PROXY_SERVER=https://niord.e-navigation.net

VERSION=${1:-1.0.0}
DOCKER_TAG="dmadk/niord-proxy:$VERSION"

echo "Running $DOCKER_TAG Niord proxy with niord-proxy.server=$NIORD_PROXY_SERVER"

docker pull $DOCKER_TAG

docker run \
  --name niord-proxy \
  -p 9090:8080 \
  -e NIORD_PROXY_SERVER=$NIORD_PROXY_SERVER \
  -d $DOCKER_TAG