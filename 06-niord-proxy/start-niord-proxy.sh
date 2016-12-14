#!/bin/bash

NIORD_PROXY_SERVER=https://niord.e-navigation.net
NIORD_HOME=${NIORD_HOME:-~/.niord}
NIORD_REPO_PATH=/opt/niord/repo
NIORD_REPO_TYPE=shared
EXECUTION_MODE=development
PROXY_TRACKING_ID=${PROXY_TRACKING_ID:-}

VERSION=${1:-1.0.0}
DOCKER_TAG="dmadk/niord-proxy:$VERSION"

echo "Running $DOCKER_TAG Niord proxy with niord-proxy.server=$NIORD_PROXY_SERVER"

docker pull $DOCKER_TAG

docker run \
  --name niord-proxy \
  -p 9090:8080 \
  -e EXECUTION_MODE=$EXECUTION_MODE \
  -e NIORD_PROXY_SERVER=$NIORD_PROXY_SERVER \
  -e NIORD_REPO_PATH=$NIORD_REPO_PATH \
  -e NIORD_REPO_TYPE=$NIORD_REPO_TYPE \
  -e NIORD_PROXY_TRACKING_ID=$PROXY_TRACKING_ID \
  -v $NIORD_HOME:/opt/niord \
  -d $DOCKER_TAG
