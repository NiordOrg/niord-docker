FROM mysql:latest

ENV MYSQL_ROOT_PASSWORD password
ENV MYSQL_PASSWORD password
ENV MYSQL_DATABASE databasename
ENV MYSQL_USER mysql

COPY niord-entrypoint.sh /niord-entrypoint.sh
RUN chmod 755 /niord-entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/niord-entrypoint.sh"]
CMD ["mysqld"]

