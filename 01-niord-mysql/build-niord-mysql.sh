#!/bin/bash

VERSION=${2:-1.0.0}
DOCKER_TAG="dmadk/niord-mysql:$VERSION"

if [ "$1" = "build" ]; then

  echo "Building mysql docker image $DOCKER_TAG"
  docker build --no-cache -t $DOCKER_TAG .


elif [ "$1" = "push" ]; then

  echo "Pushing $DOCKER_TAG to docker.io - make sure you are logged in"
  docker push $DOCKER_TAG
  exit


else
    echo "Unknown target: $1"
    echo "Valid targets are:"
    echo "  build <version>   Builds the specified docker version"
    echo "  push  <version>   Pushes version to docker.io"
fi


