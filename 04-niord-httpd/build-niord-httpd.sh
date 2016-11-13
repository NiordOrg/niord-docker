#!/bin/bash

if [ "$1" = "build" ]; then

  echo "**********************************************"
  echo "** Building Niord HTTPD                     **"
  echo "**********************************************"

  VERSION=${2:-1.0.0}
  DOCKER_TAG="dmadk/niord-httpd:$VERSION"
  echo "**********************************************"
  echo "** Building $DOCKER_TAG         **"
  echo "**********************************************"
  docker build --no-cache -t $DOCKER_TAG .

  exit


elif [ "$1" = "push" ]; then  
  VERSION=${2:-1.0.0}
  DOCKER_TAG="dmadk/niord-httpd:$VERSION"
  echo "Pushing $DOCKER_TAG to docker.io - make sure you are logged in"
  docker push $DOCKER_TAG
  exit     


else
    echo Unknown target: "$1"
    echo Valid targets are:
fi

echo "  build <version>   Builds the specified version"
echo "  push  <version>   Pushes version to docker.io"


