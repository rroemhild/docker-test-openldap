# OpenLDAP Docker Image for testing

This image provides an OpenLDAP Server for testing LDAP applications, i.e. unit tests. The server is initialized with data from Futurama, Planet Express, Inc. Currently there are only entries for Fry, Lila and Bender. In the future I will add more Crew members and other objects, for more complex tests.

Parts of the image are based on the work from Nick Stenning [docker-slapd][slapd] and Bertrand Gouny [docker-openldap][openldap].

[slapd]: https://github.com/nickstenning/docker-slapd
[openldap]: https://github.com/osixia/docker-openldap


## Features

* Support for TLS
* Initialized with data from Futurama
* ~190MB Images size


## Usage

```
docker pull rroemhild/test-openldap
docker run --privileged -d -p 389:389 rroemhild/test-openldap
```


## LDAP Data

* BASEDN: dc=planetexpress,dc=com
* ADMIN_DN: cn=admin,dc=planetexpress,dc=com
* ADMIN_SECRET: GoodNewsEveryone


## Exposed ports

* 389


## Exposed volumes

* /etc/ldap/slapd.d
* /etc/ldap/ssl
* /var/lib/ldap
* /run/slapd

