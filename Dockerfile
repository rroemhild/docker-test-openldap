FROM alpine:latest


ENV ORGANISATION_NAME="Planet Express, Inc."
ENV SUFFIX="dc=planetexpress,dc=com"
ENV ROOT_USER="admin"
ENV ROOT_PW="GoodNewsEveryone"

ENV LOG_LEVEL="stats"

RUN apk add gettext openldap openldap-clients openldap-back-mdb openldap-passwd-pbkdf2 openldap-overlay-memberof openldap-overlay-ppolicy openldap-overlay-refint && \
    mkdir -p /run/openldap /var/lib/openldap/openldap-data && \
    rm -rf /var/cache/apk/*

COPY scripts/* /etc/openldap/
COPY ldif /ldif

COPY docker-entrypoint.sh /

EXPOSE 389
EXPOSE 636

ENTRYPOINT ["/docker-entrypoint.sh"]