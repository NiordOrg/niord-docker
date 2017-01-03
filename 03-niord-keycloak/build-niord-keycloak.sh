#!/bin/bash

if [ "$1" = "build" ]; then

  rm -rf niord-appsrv

  echo "**********************************************"
  echo "** Building Niord Keycloak                  **"
  echo "**********************************************"

  # Build a fully configured Wildfly
  git clone https://github.com/NiordOrg/niord-appsrv.git
  source niord-appsrv/03-keycloak/keycloak-env.sh
  ./niord-appsrv/03-keycloak/install-keycloak-server.sh

  rm -rf $KEYCLOAK_PATH/standalone/configuration/standalone_xml_history

  VERSION=${2:-1.0.1}
  DOCKER_TAG="dmadk/niord-keycloak:$VERSION"
  echo "**********************************************"
  echo "** Building $DOCKER_TAG         **"
  echo "**********************************************"
  docker build --no-cache -t $DOCKER_TAG .

  rm -rf niord-appsrv
  exit


elif [ "$1" = "push" ]; then  
  VERSION=${2:-1.0.1}
  DOCKER_TAG="dmadk/niord-keycloak:$VERSION"
  echo "Pushing $DOCKER_TAG to docker.io - make sure you are logged in"
  docker push $DOCKER_TAG
  exit     


else
    echo Unknown target: "$1"
    echo Valid targets are:
fi

echo "  build <version>   Builds the specified version"
echo "  push  <version>   Pushes version to docker.io"


