#!/bin/bash

export USER_DIR=`pwd`
pushd `dirname ${BASH_SOURCE}` > /dev/null

if [ "$1" = "build" ]; then
  NIORD_PROXY_JAR="./niord-proxy-swarm.jar"
  FILE_PATH="$USER_DIR/$2"

  rm -f $NIORD_PROXY_JAR

  echo "**********************************************"
  echo "** Building Niord Proxy                     **"
  echo "**********************************************"

  if [ ! -f "$FILE_PATH" ]; then
    echo "Niord Proxy $FILE_PATH does not exist."
    exit
  fi

  # Copy the niord-proxy to this folder
  cp "$FILE_PATH" "$NIORD_PROXY_JAR"

  VERSION=${3:-1.0.0}
  DOCKER_TAG="dmadk/niord-proxy:$VERSION"
  echo "**********************************************"
  echo "** Building $DOCKER_TAG        **"
  echo "**********************************************"
  docker build --no-cache -t $DOCKER_TAG .

  rm -f "$NIORD_PROXY_JAR"
  exit


elif [ "$1" = "push" ]; then  
  VERSION=${2:-1.0.0}
  DOCKER_TAG="dmadk/niord-proxy:$VERSION"
  echo "Pushing $DOCKER_TAG to docker.io - make sure you are logged in"
  docker push $DOCKER_TAG
  exit     


else
    echo Unknown target: "$1"
    echo Valid targets are:
fi

echo "  build <war> <version>   Builds the specified version including the specified war"
echo "  push  <version>         Pushes version to docker.io"

popd > /dev/null

