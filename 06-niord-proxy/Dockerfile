FROM java:openjdk-8-jdk

ADD niord-proxy-swarm.jar /opt/niord-proxy-swarm.jar

ENV EXECUTION_MODE development
ENV NIORD_PROXY_SERVER https://niord.e-navigation.net
ENV NIORD_PROXY_AREAS ""
ENV NIORD_REPO_PATH ""
ENV NIORD_REPO_TYPE ""
ENV NIORD_PROXY_TRACKING_ID ""
ENV NIORD_PROXY_WMS_URL ""

# TODO: Resolve logging in wildfly swarm
# See https://groups.google.com/forum/#!topic/wildfly-swarm/nQCHhWSaEuY

EXPOSE 8080
ENTRYPOINT java \
   -Djboss.server.log.dir=/var/log \
   -Djava.net.preferIPv4Stack=true \
   -Dniord-proxy.server=$NIORD_PROXY_SERVER \
   -Dniord-proxy.areas=$NIORD_PROXY_AREAS \
   -Dniord-proxy.repoRootPath=$NIORD_REPO_PATH \
   -Dniord-proxy.repoRootType=$NIORD_REPO_TYPE \
   -Dniord-proxy.mode=$EXECUTION_MODE \
   -Dniord-proxy.analyticsTrackingId=$NIORD_PROXY_TRACKING_ID \
   -Dniord-proxy.wmsServerUrl=$NIORD_PROXY_WMS_URL \
   -jar /opt/niord-proxy-swarm.jar
