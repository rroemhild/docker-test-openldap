#!/bin/sh
set -eu


readonly LDAP_BINDDN="cn=admin,dc=planetexpress,dc=com"


file_exist() {
    local file=$1

    [[ -e $file ]]
}


reconfigure_slapd() {
    echo "Reconfigure slapd..."
    cat <<EOL | debconf-set-selections
slapd slapd/internal/generated_adminpw password ${LDAP_ADMIN_SECRET}
slapd slapd/internal/adminpw password ${LDAP_ADMIN_SECRET}
slapd slapd/password2 password ${LDAP_ADMIN_SECRET}
slapd slapd/password1 password ${LDAP_ADMIN_SECRET}
slapd slapd/dump_database_destdir string /var/backups/slapd-VERSION
slapd slapd/domain string ${LDAP_DOMAIN}
slapd shared/organization string ${LDAP_ORGANISATION}
slapd slapd/backend string HDB
slapd slapd/purge_database boolean true
slapd slapd/move_old_database boolean true
slapd slapd/allow_ldap_v2 boolean false
slapd slapd/no_configuration boolean false
slapd slapd/dump_database select when needed
EOL

    dpkg-reconfigure -f noninteractive slapd
}


configure_tls() {
    echo "Configure TLS..."
    ldapmodify -Y EXTERNAL -H ldapi:/// -f /bootstrap/ldif/tls.ldif -Q
}


configure_logging() {
    echo "Configure logging..."
    ldapmodify -Y EXTERNAL -H ldapi:/// -f /bootstrap/ldif/logging.ldif -Q
}


load_initial_data() {
    echo "Load data..."
    data=$(find /bootstrap/ldif -maxdepth 1 -name \*_\*.ldif -type f | sort)
    for ldif in ${data}; do
        echo "Processing file ${ldif}..."
        ldapadd -x -D ${LDAP_BINDDN} -w ${LDAP_ADMIN_SECRET} -H ldapi:/// -f ${ldif}
    done
}


## Init

reconfigure_slapd

chown -R openldap:openldap /etc/ldap
slapd -h "ldapi:///" -u openldap -g openldap

configure_tls
configure_logging
load_initial_data

kill -INT `cat /run/slapd/slapd.pid`

exit 0

