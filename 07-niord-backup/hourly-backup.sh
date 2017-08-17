#!/bin/bash

NIORD_HOME=${NIORD_HOME:-/opt/niord}
NIORD_DB_PASSWORD=${NIORD_DB_PASSWORD:-}
NIORDKC_DB_PASSWORD=${NIORDKC_DB_PASSWORD:-}

START_TIME=$SECONDS
TIMESTAMP="$(date "+%Y%m%d-%H%M%S")"
BACKUP_DIR=${NIORD_HOME}/backup/hourly
NIORD_FILE=${BACKUP_DIR}/niord_${TIMESTAMP}.sql.gz
NIORDKC_FILE=${BACKUP_DIR}/niordkc_${TIMESTAMP}.sql.gz

# Back-up the databases
mkdir -p $BACKUP_DIR
mysqldump -h niord-mysql -P 3306 -u niord --password=${NIORD_DB_PASSWORD} niord | gzip > ${NIORD_FILE}
mysqldump -h niordkc-mysql -P 3306 -u niordkc --password=${NIORDKC_DB_PASSWORD} niordkc | gzip > ${NIORDKC_FILE}

# Delete files older than 7 days from the backup folder
find ${BACKUP_DIR}/ -mtime +7 -exec rm {} \;

ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo "$(date): Hourly back-up of niord DB in $ELAPSED_TIME seconds"
