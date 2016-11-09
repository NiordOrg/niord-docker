# niord-smtp

The niord-appsrv docker container, by default, should be linked to a docker SMTP relay container.

One option is to use namshi/smtp found at https://github.com/namshi/docker-smtp.

If e.g. Amazon SES is used as the SMTP server, the relay docker image can be started using:

    docker run \
      --name niord-smtp \
      -e SES_REGION=<<Amazon SES region, e.g. eu-west-1>> \
      -e SES_USER=<<Amazon SES SMTP user>> \
      -e SES_PASSWORD=<<Amazon SES SMTP password>> \
      -d namshi/smtp

