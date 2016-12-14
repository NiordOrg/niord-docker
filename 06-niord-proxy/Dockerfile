FROM java:openjdk-8-jdk

ADD niord-proxy-swarm.jar /opt/niord-proxy-swarm.jar

ENV EXECUTION_MODE development
ENV NIORD_PROXY_SERVER https://niord.e-navigation.net
ENV NIORD_REPO_PATH ""
ENV NIORD_REPO_TYPE ""
ENV NIORD_PROXY_TRACKING_ID ""

# TODO: Resolve logging in wildfly swarm
# See https://groups.google.com/forum/#!topic/wildfly-swarm/nQCHhWSaEuY

EXPOSE 8080
ENTRYPOINT java \
   -Djboss.server.log.dir=/var/log \
   -Dniord-proxy.server=$NIORD_PROXY_SERVER \
   -Dniord-proxy.repoRootPath=$NIORD_REPO_PATH \
   -Dniord-proxy.repoRootType=$NIORD_REPO_TYPE \
   -Dniord-proxy.mode=$EXECUTION_MODE \
   -Dniord-proxy.analyticsTrackingId=$NIORD_PROXY_TRACKING_ID \
   -jar /opt/niord-proxy-swarm.jar
