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

