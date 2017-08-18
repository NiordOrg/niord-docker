#!/bin/bash

if [ ! -f "$1" ]; then
    echo "Missing backup file: $1"
    exit
fi


NIORD_DB_PASSWORD=${NIORD_DB_PASSWORD:-}
START_TIME=$SECONDS

# Restore the database
echo "***** Restoring niord-appsrv database backup $1"
gunzip < $1 | mysql -h niord-mysql -P 3306 -u niord --password=${NIORD_DB_PASSWORD} niord

ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo "$(date): Restored back-up in $ELAPSED_TIME seconds"
