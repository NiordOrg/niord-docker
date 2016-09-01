FROM jboss/base-jdk:8

USER root

# Set the WILDFLY_VERSION env variable
ENV WILDFLY_VERSION 10.1.0.Final
ENV WILDFLY_SHA1 9ee3c0255e2e6007d502223916cefad2a1a5e333
ENV JBOSS_HOME /opt/jboss/wildfly
ENV NIORD_HOME /opt/niord

ARG KEYCLOAK_ADMIN_USER=admin
ARG KEYCLOAK_ADMIN_PASWORD=keycloak

ADD niord-appsrv/wildfly-$WILDFLY_VERSION /opt/jboss/wildfly

# Ensure signals are forwarded to the JVM process correctly for graceful shutdown
ENV LAUNCH_JBOSS_IN_BACKGROUND true

RUN yum install -y epel-release && yum install -y jq && yum clean all

ADD https://raw.githubusercontent.com/NiordOrg/niord-appsrv/master/03-keycloak/niord-dev-realm.json /opt/jboss/wildfly/import-realm.json

# Expose the ports we're interested in
EXPOSE 8080

CMD /opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0 -Dniord.home=${NIORD_HOME} -Dkeycloak.import=/opt/jboss/wildfly/import-realm.json
