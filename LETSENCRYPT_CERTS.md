# LetsEncrypt Certificates for OpenLDAP
- Use https://github.com/matrix-org/docker-dehydrated#behaviour
    ```
    mkdir data
    echo "ldap.customdomain.com" > data/domains.txt

    # create a docker-compose.yml file
    version: '2'
    services:
      dehydrated:
        image: docker.io/matrixdotorg/dehydrated
        restart: unless-stopped
        volumes:
          - ./data:/data
        environment:
          - DEHYDRATED_GENERATE_CONFIG=yes
          - DEHYDRATED_CA="https://acme-v02.api.letsencrypt.org/directory"
          # - DEHYDRATED_CA="https://acme-staging-v02.api.letsencrypt.org/directory"
          - DEHYDRATED_CHALLENGE="dns-01"
          - DEHYDRATED_KEYSIZE="4096"
          - DEHYDRATED_HOOK="/usr/local/bin/lexicon-hook"
          - DEHYDRATED_RENEW_DAYS="30"
          - DEHYDRATED_KEY_RENEW="yes"
          - DEHYDRATED_EMAIL="myemail@gmail.com"
          - DEHYDRATED_ACCEPT_TERMS=yes
          - PROVIDER=cloudflare
          - LEXICON_CLOUDFLARE_USERNAME
          - LEXICON_CLOUDFLARE_TOKEN


    #run docker compose
    docker-compose up
    ```

# Copy Certificates to correct directory
```
cp fullchain-*.pem ldap/fullchain.crt
cp cert-*.pem ldap/ldap.crt
cp privkey-1623520297.pem ldap/ldap.key
```
