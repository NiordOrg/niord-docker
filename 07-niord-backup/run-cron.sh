#!/bin/bash

# prepend application environment variables to crontab
# env | egrep '^MY_VAR' | cat - /tmp/my_cron > /etc/cron.d/my_cron

printenv | grep "DB_PASSWORD" >> /etc/environment

# Run cron deamon
# -m off : sending mail is off
# tail makes the output to cron.log viewable with the $(docker logs container_id) command
cron  && tail -f /var/log/cron.log
