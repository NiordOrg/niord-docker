# niord-backup

A very Niord-specific docker container that will create hourly and daily database backups of the 
mysql databases for the niord app and Keycloak server.

Example:

    docker run \
      --name niord-backup \
      --link niord-mysql:niorddb \
      --link niordkc-mysql:kcdb \
      -e NIORD_DB_PASSWORD=$NIORD_DB_PASSWORD \
      -e NIORDKC_DB_PASSWORD=$NIORDKC_DB_PASSWORD \
      -e NIORD_HOME=/opt/niord \
      -v $NIORD_HOME:/opt/niord \
      -d dmadk/niord-backup:1.0.0

The database backup files will be placed under $NIORD_HOME/backup. 
Hourly backup files are automatically deleted after 3 days and daily backup file after 30 days.

## Restoring a backup

The following example will restore a timestamped niord-appsrv database backup file:

    enav@alpha:~$ docker stop niord-appsrv
    enav@alpha:~$ docker exec -it niord-backup bash
    root@e2557ba3e6b1:/# ./restore-appsrv-backup.sh /opt/niord/backup/hourly/niord_20170818-052501.sql.gz
    root@e2557ba3e6b1:/# exit
    enav@alpha:~$ docker start niord-appsrv
