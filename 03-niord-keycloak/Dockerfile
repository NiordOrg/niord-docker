FROM jboss/base-jdk:8

USER root

# Set the KEYCLOAK_VERSION env variable
ENV KEYCLOAK_VERSION 2.4.0.Final
ENV JBOSS_HOME /opt/jboss/keycloak

ADD niord-appsrv/keycloak-$KEYCLOAK_VERSION /opt/jboss/keycloak

# Ensure signals are forwarded to the JVM process correctly for graceful shutdown
ENV LAUNCH_JBOSS_IN_BACKGROUND true

RUN yum install -y epel-release && yum install -y jq && yum clean all

ADD https://raw.githubusercontent.com/NiordOrg/niord-appsrv/master/03-keycloak/niord-bootstrap-realm.json /opt/jboss/keycloak/import-realm.json

ADD https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh /opt/jboss/keycloak/bin/wait-for-it.sh
RUN chmod +x /opt/jboss/keycloak/bin/wait-for-it.sh

# Expose the ports we're interested in
EXPOSE 8080

# wait for database docker image before starting Keycloak
CMD /opt/jboss/keycloak/bin/wait-for-it.sh kcdb:3306 --timeout=60 --strict \
    -- /opt/jboss/keycloak/bin/standalone.sh -b 0.0.0.0 -Dkeycloak.import=/opt/jboss/keycloak/import-realm.json
