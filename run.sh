#!/bin/sh
set -e

readonly LDAP_SSL_KEY="/etc/ldap/ssl/ldap.key"
readonly LDAP_SSL_CERT="/etc/ldap/ssl/ldap.crt"


make_snakeoil_certificate() {
    echo "Make snakeoil certificate for ${LDAP_DOMAIN}..."
    openssl req -subj "/CN=${LDAP_DOMAIN}" \
                -new \
                -newkey rsa:2048 \
                -days 365 \
                -nodes \
                -x509 \
                -keyout ${LDAP_SSL_KEY} \
                -out ${LDAP_SSL_CERT}

    chmod 600 ${LDAP_SSL_KEY}
}


file_exist ${LDAP_SSL_CERT} \
  || make_snakeoil_certificate

echo "starting slapd on port 389 and 636..."
chown -R openldap:openldap /etc/ldap
exec /usr/sbin/slapd -h "ldap:/// ldapi:/// ldaps:///" \
  -u openldap \
  -g openldap \
  -d ${DEBUG_LEVEL}
