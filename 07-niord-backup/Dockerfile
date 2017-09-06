FROM centos:latest

RUN yum -y update && \
    yum -y install mysql

# Add the backup scripts run by the containers cron jobs
ADD hourly-backup.sh /hourly-backup.sh
ADD daily-backup.sh /daily-backup.sh

# Add restore scripts
ADD restore-appsrv-backup.sh /restore-appsrv-backup.sh
ADD restore-keycloak-backup.sh /restore-keycloak-backup.sh

# Give execution rights on the cron job
RUN chmod +x /hourly-backup.sh
RUN chmod +x /daily-backup.sh
RUN chmod +x /restore-appsrv-backup.sh
RUN chmod +x /restore-keycloak-backup.sh


CMD mkdir -p /opt/niord/backup && touch /opt/niord/backup/backup.log && tail -f /opt/niord/backup/backup.log
