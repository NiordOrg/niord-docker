# niord-smtp

## Using Amazon SES

The niord-appsrv docker container, by default, should be linked to a docker SMTP relay container.

One option is to use namshi/smtp found at https://github.com/namshi/docker-smtp.

If e.g. Amazon SES is used as the SMTP server, the relay docker image can be started using:

    docker run \
      --name niord-smtp \
      -e SES_REGION=<<Amazon SES region, e.g. eu-west-1>> \
      -e SES_USER=<<Amazon SES SMTP user>> \
      -e SES_PASSWORD=<<Amazon SES SMTP password>> \
      -d namshi/smtp

## Using Postfix Relay

Alternatively, use the very simple niord-smtp docker container, which makes the 
following assumptions:

* The target SMTP server has been configured to accept unauthenticated SMTP connecitons
  on port 25.
  
**Credits**
The niord-smtp docker container is based on the docker-postfix container found at
https://github.com/juanluisbaptiste/docker-postfix.
However, the docker-postfix container required SMTP username and password, and was hardcoded to 
connect to port 587.

    docker create \
          --name niord-smtp \
          --restart=unless-stopped \
          -p 1025:25 \
          -e SMTP_SERVER=$DMA_SMTP_SERVER \
          -e SERVER_HOSTNAME=niord.dma.dk \
          dmadk/niord-smtp:1.0.0
