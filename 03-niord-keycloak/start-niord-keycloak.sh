#!/bin/bash

VERSION=${1:-1.0.1}
DOCKER_TAG="dmadk/niord-keycloak:$VERSION"

echo "Running $DOCKER_TAG Keycloak server"

docker pull $DOCKER_TAG

docker run \
  --name niord-keycloak \
  -p 8090:8080 \
  --link niordkc-mysql:kcdb \
  -d $DOCKER_TAG
