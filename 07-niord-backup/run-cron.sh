#!/bin/bash

# prepend application environment variables to crontab
# env | egrep '^MY_VAR' | cat - /tmp/my_cron > /etc/cron.d/my_cron

printenv | grep "DB_PASSWORD" >> /etc/environment

# Run cron deamon
crond  && tail -f /var/log/cron.log
