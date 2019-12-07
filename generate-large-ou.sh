#!/bin/bash

for i in $(seq 1 2000); do
  userdn="cn=large${i},ou=large_ou,dc=planetexpress,dc=com"
  read -r -d '' doc <<EOF
dn: ${userdn}
objectClass: top
objectClass: person
objectClass: organizationalPerson
objectClass: inetOrgPerson
cn: Large User${i}
sn: User${i}
description: Human
givenName: Large
mail: large${i}@planetexpress.com
uid: user${i}
userPassword:: e1NTSEF9TVVobE45STRwQm9CcW1SWjBxL1F1MUlBK1JQSDljNkcK
EOF
  echo "${doc}" > bootstrap/data/large-group/people/10_user${i}.ldif
done

read -r -d '' group_doc <<EOF
dn: cn=large_group,ou=large_ou,dc=planetexpress,dc=com
objectclass: Group
objectclass: top
groupType: 2147483650
cn: large_group
EOF
echo "${group_doc}" > bootstrap/data/large-group/30_groups_large.ldif

for i in $(seq 1 2000); do
  userdn="cn=large${i},ou=large_ou,dc=planetexpress,dc=com"
  echo "member: ${userdn}" >> bootstrap/data/large-group/30_groups_large.ldif
done
