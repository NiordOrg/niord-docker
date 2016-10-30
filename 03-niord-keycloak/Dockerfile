FROM jboss/base-jdk:8

USER root

# Set the KEYCLOAK_VERSION env variable
ENV KEYCLOAK_VERSION 2.2.1.Final
ENV JBOSS_HOME /opt/jboss/keycloak

ADD niord-appsrv/keycloak-$KEYCLOAK_VERSION /opt/jboss/keycloak

# Ensure signals are forwarded to the JVM process correctly for graceful shutdown
ENV LAUNCH_JBOSS_IN_BACKGROUND true

RUN yum install -y epel-release && yum install -y jq && yum clean all

ADD https://raw.githubusercontent.com/NiordOrg/niord-appsrv/master/03-keycloak/niord-dev-realm.json /opt/jboss/keycloak/import-realm.json

# Expose the ports we're interested in
EXPOSE 8080

CMD /opt/jboss/keycloak/bin/standalone.sh -b 0.0.0.0 -Dkeycloak.import=/opt/jboss/keycloak/import-realm.json
