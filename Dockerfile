FROM debian:7
MAINTAINER Rafael Römhild <rafael@roemhild.de>

ENV DEBUG_LEVEL 256
ENV LDAP_DOMAIN planetexpress.com
ENV LDAP_ADMIN_SECRET GoodNewsEveryone
ENV LDAP_ORGANISATION Planet Express, Inc.
ENV DEBIAN_FRONTEND noninteractive

# Install slapd and requirements
RUN apt-get update \
    && apt-get -y --no-install-recommends install \
        slapd \
        ldap-utils \
        openssl \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Create TLS certificate and bootstrap directory
RUN mkdir /etc/ldap/ssl /bootstrap

# ADD run script
COPY ./run.sh /run.sh

# ADD bootstrap files
ADD ./bootstrap /bootstrap

# Initialize LDAP with data
RUN /bin/bash /bootstrap/slapd-init.sh

VOLUME ["/etc/ldap/slapd.d", "/etc/ldap/ssl", "/var/lib/ldap", "/run/slapd"]

EXPOSE 389

CMD []
ENTRYPOINT ["/bin/bash", "/run.sh"]

