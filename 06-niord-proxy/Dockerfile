FROM java:openjdk-8-jdk

ADD niord-proxy-swarm.jar /opt/niord-proxy-swarm.jar

ENV NIORD_PROXY_SERVER https://niord.e-navigation.net

# TODO: Resolve logging in wildfly swarm
# See https://groups.google.com/forum/#!topic/wildfly-swarm/nQCHhWSaEuY

EXPOSE 8080
ENTRYPOINT java -Djboss.server.log.dir=/var/log -Dniord-proxy.server=$NIORD_PROXY_SERVER -jar /opt/niord-proxy-swarm.jar
