# docker-certbot

Container that redirects all HTTP traffic to HTTPS and will create lets encrypt certificates to be exported and read from other containers or systems.

## docker exec
```shell
docker exec -ti CONTAINERID certbot-run DIR="CertParentDir" NAME="CertRequestName" EMAIL="cert@domain.com" \
    DOMAIN="-d domain.com -d www.domain.com"
```

This will create all kinds of certificates (key, crt, fullchain, pfx) in the directory "/nginx/ssl/$CertParentDir/$CertRequestName". The generated *.pfx has the password "1234". You can then mount the same docker volume (/nginx/ssl) in another container to use the generated certificates (i.e. nginx webserver).

## docker -u 1000:1000 (no root initiative)

As part to make containers more secure, this container will not run as root, but as uid:gid 1000:1000. Therefore the default TCP port 80 was changed to 8080 (/source/certbot.conf).

## build with
* [11notes/nginx:stable](https://github.com/11notes/docker-nginx) - Parent container
* [Alpine Linux](https://alpinelinux.org/) - Alpine Linux
* [Docker](https://www.docker.com/) - Docker Container System
* [Certbot](https://certbot.eff.org/) - Certbot Let's Encrypt