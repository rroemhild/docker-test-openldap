# OpenLDAP Docker Image for testing

This image provides an OpenLDAP Server for testing LDAP applications, i.e. unit tests. The server is initialized with the example domain `planetexpress.com` with data from the [Futurama Wiki][futuramawikia].

Parts of the image are based on the work from Nick Stenning [docker-slapd][slapd] and Bertrand Gouny [docker-openldap][openldap].

The Flask extension [flask-ldapconn][flaskldapconn] use this image for unit tests.

[slapd]: https://github.com/nickstenning/docker-slapd
[openldap]: https://github.com/osixia/docker-openldap
[flaskldapconn]: https://github.com/rroemhild/flask-ldapconn
[futuramawikia]: http://futurama.wikia.com


## Features

* Support for TLS
* Initialized with data from Futurama
* ~180MB Images size


## Usage

```
docker pull rroemhild/test-openldap
docker run --privileged -d -p 389:389 rroemhild/test-openldap
```


## LDAP Data

**BASEDN:** dc=planetexpress,dc=com

| Admin            | Secret           |
| ---------------- | ---------------- |
| cn=admin,dc=planetexpress,dc=com | GoodNewsEveryone |

### LDAP Users

*userPassword* is equal to *uid*

| DN               | userPassword     | eMail            |
| ---------------- | ---------------- | ---------------- |
| cn=Hubert J. Farnsworth,ou=people,dc=planetexpress,dc=com | professor | professor@planetexpress.com |
| cn=Philip J. Fry,ou=people,dc=planetexpress,dc=com | fry | fry@planetexpress.com |
| cn=John A. Zoidberg,ou=people,dc=planetexpress,dc=com | zoidberg | zoidberg@planetexpress.com |
| cn=Hermes Conrad,ou=people,dc=planetexpress,dc=com | hermes | hermes@planetexpress.com |
| cn=Turanga Leela,ou=people,dc=planetexpress,dc=com | leela | leela@planetexpress.com |
| cn=Bender Bending Rodríguez,ou=people,dc=planetexpress,dc=com | bender | bender@planetexpress.com |


## Exposed ports

* 389


## Exposed volumes

* /etc/ldap/slapd.d
* /etc/ldap/ssl
* /var/lib/ldap
* /run/slapd

