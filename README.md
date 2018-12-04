# docker-certbot

Container that redirects all HTTP traffic to HTTPS and will create lets encrypt certificates to be exported and read from other containers or systems.

## docker exec
```shell
docker exec -ti CONTAINERID certbot-run DIR="CertParentDir" NAME="CertRequestName" EMAIL="cert@domain.com" DOMAIN="-d domain.com -d www.domain.com"
```

## build with

* [Alpine Linux](https://alpinelinux.org/) - Alpine Linux
* [Docker](https://www.docker.com/) - Docker Container System
* [Certbot](https://certbot.eff.org/) - Certbot Let's Encrypt