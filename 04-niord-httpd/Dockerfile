FROM httpd:2.4

ENV APPSRV_NAME localhost
ENV KEYCLOAK_NAME localhost
ENV PROXY_NAME localhost

# Add Niord-specific configuraiton
ADD niord.conf /usr/local/apache2/conf/
RUN echo "Include conf/niord.conf" >> /usr/local/apache2/conf/httpd.conf

# Add custom docker entry point
ADD niord-httpd-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/niord-httpd-entrypoint.sh

# Exposed ports
EXPOSE 80
EXPOSE 443

CMD ["/usr/local/bin/niord-httpd-entrypoint.sh"]
