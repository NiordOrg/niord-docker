#!/bin/bash

if [ "$1" = "build" ]; then

  rm -rf niord-appsrv

  echo "**********************************************"
  echo "** Building Niord appsrv                    **"
  echo "**********************************************"

  if [ ! -f "$2" ]; then
    echo "Web application $2 does not exist."
    exit
  fi

  # Build a fully configured Wildfly
  git clone https://github.com/NiordOrg/niord-appsrv.git
  source niord-appsrv/02-wildfly/wildfly-env.sh
  ./niord-appsrv/02-wildfly/install-wildfly.sh
  cp "$2" $WILDFLY_PATH/standalone/deployments/

  rm -rf $WILDFLY_PATH/standalone/configuration/standalone_xml_history

  VERSION=${3:-1.0.2}
  DOCKER_TAG="dmadk/niord-appsrv:$VERSION"
  echo "**********************************************"
  echo "** Building $DOCKER_TAG         **"
  echo "**********************************************"
  docker build --no-cache -t $DOCKER_TAG .

  rm -rf niord-appsrv
  exit


elif [ "$1" = "push" ]; then  
  VERSION=${2:-1.0.2}
  DOCKER_TAG="dmadk/niord-appsrv:$VERSION"
  echo "Pushing $DOCKER_TAG to docker.io - make sure you are logged in"
  docker push $DOCKER_TAG
  exit     


else
    echo Unknown target: "$1"
    echo Valid targets are:
fi

echo "  build <war> <version>   Builds the specified version including the specified war"
echo "  push  <version>         Pushes version to docker.io"


