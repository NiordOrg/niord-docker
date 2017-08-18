FROM ubuntu:latest

# Credits: Mostly copied and modified from https://www.ekito.fr/people/run-a-cron-job-with-docker/

RUN apt-get update -q && \
    apt-get install -qy cron mysql-client && \
    apt-get clean -q

# Add crontab file in the cron directory
ADD crontab /etc/cron.d/backup-cron

ADD run-cron.sh /run-cron.sh

# Add the backup scripts run by the cron job
ADD hourly-backup.sh /hourly-backup.sh
ADD daily-backup.sh /daily-backup.sh

# Add restore scripts
ADD restore-appsrv-backup.sh /restore-appsrv-backup.sh
ADD restore-keycloak-backup.sh /restore-keycloak-backup.sh

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/backup-cron
RUN chmod +x /hourly-backup.sh
RUN chmod +x /daily-backup.sh
RUN chmod +x /restore-appsrv-backup.sh
RUN chmod +x /restore-keycloak-backup.sh
RUN chmod +x /run-cron.sh

RUN /usr/bin/crontab /etc/cron.d/backup-cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

CMD ["/run-cron.sh"]
