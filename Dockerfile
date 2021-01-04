FROM debian:buster-slim
MAINTAINER Rafael Römhild <rafael@roemhild.de>

# Install slapd and requirements
RUN apt-get update \
	&& apt-get dist-upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get \
        install -y --no-install-recommends \
            slapd \
            ldap-utils \
            openssl \
            ca-certificates \
            tini \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir /etc/ldap/ssl /bootstrap

# ADD bootstrap files
ADD ./bootstrap /bootstrap

# Initialize LDAP with data
RUN /bin/bash /bootstrap/slapd-init.sh

VOLUME ["/etc/ldap/slapd.d", "/etc/ldap/ssl", "/var/lib/ldap", "/run/slapd"]

EXPOSE 10389 10636

USER openldap

ENTRYPOINT ["/usr/bin/tini", "--", "/usr/sbin/slapd"]
CMD ["-h", "ldapi:/// ldap://0.0.0.0:10389 ldaps://0.0.0.0:10636", "-d", "256"]
