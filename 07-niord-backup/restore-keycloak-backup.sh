#!/bin/bash

if [ ! -f "$1" ]; then
    echo "Missing backup file: $1"
    exit
fi

NIORDKC_DB_PASSWORD=${NIORDKC_DB_PASSWORD:-}
START_TIME=$SECONDS

# Restore the database
echo "***** Restoring niord-keycloak database backup $1"
gunzip < $1 | mysql -h niordkc-mysql -P 3306 -u niordkc --password=${NIORDKC_DB_PASSWORD} niordkc

ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo "$(date): Restored back-up in $ELAPSED_TIME seconds"
