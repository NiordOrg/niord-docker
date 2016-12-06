FROM jboss/base-jdk:8

USER root

# Set the WILDFLY_VERSION env variable
ENV WILDFLY_VERSION 10.1.0.Final
ENV WILDFLY_SHA1 9ee3c0255e2e6007d502223916cefad2a1a5e333
ENV JBOSS_HOME /opt/jboss/wildfly
ENV NIORD_HOME /opt/niord

# set locals for image to support UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ADD niord-appsrv/wildfly-$WILDFLY_VERSION /opt/jboss/wildfly

# Ensure signals are forwarded to the JVM process correctly for graceful shutdown
ENV LAUNCH_JBOSS_IN_BACKGROUND true

RUN yum install -y epel-release && yum install -y jq && yum clean all

ADD https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh /opt/jboss/wildfly/bin/wait-for-it.sh
RUN chmod +x /opt/jboss/wildfly/bin/wait-for-it.sh

# Expose the ports we're interested in
EXPOSE 8080

# wait for database docker image before starting Keycloak
CMD /opt/jboss/wildfly/bin/wait-for-it.sh niorddb:3306 --timeout=40 --strict \
    -- /opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0 -Dfile.encoding=UTF-8 -Dniord.home=${NIORD_HOME}
