#!/bin/bash

pushd `dirname ${BASH_SOURCE}` > /dev/null
export MYSQL_DOCKER_DIR=`pwd`
popd > /dev/null

VERSION=${1:-latest}
NIORD_HOME=${NIORD_HOME:-~/.niord}
export NIORD_HOME

$MYSQL_DOCKER_DIR/start-niordkc-mysql.sh $VERSION
$MYSQL_DOCKER_DIR/start-niord-mysql.sh $VERSION
$MYSQL_DOCKER_DIR/start-msi-mysql.sh $VERSION
