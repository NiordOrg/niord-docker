#!/bin/bash
echo "Booting up niord"
docker run  --name niord-smtp  -p 1025:25  -e SMTP_SERVER=changethis.dma.dk -e SERVER_HOSTNAME=andchangethis.dma.dk --rm --detach  dmadk/niord-smtp:1.0.0
./01-niord-mysql/start-all.sh
./02-niord-appsrv/start-niord-appsrv.sh
./03-niord-keycloak/start-niord-keycloak.sh
./04-niord-httpd/start-niord-httpd.sh
./06-niord-proxy/start-niord-proxy.sh
echo "bootup complete"
docker ps -a