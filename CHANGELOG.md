# Changelog


## v2.1 (rroemhild/test-openldap:2.1)

* Re-add PR #14: add_config_admin_pw


## v2.0 (rroemhild/test-openldap:2.0)

* Set ports higher than 10000 (10389 / 10636)
* Set user in dockerfile
* Use tini to start slapd
* Use CMD for slapd arguments


### Breaking changes

Different port numbers than in the version before

* 380 -> 10389
* 686 -> 10686
