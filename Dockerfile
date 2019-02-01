# ------ HEADER ------ #
FROM 11notes/nginx:stable
ARG DEBIAN_FRONTEND=noninteractive

# ------ RUN  ------ #
USER root
ADD ./source/certbot.conf /nginx/etc/default.conf
ADD ./source/certbot.sh /usr/local/bin/certbot-run
RUN chmod +x /usr/local/bin/certbot-run \
    && chown -R nginx:nginx /nginx

WORKDIR /opt/certbot
ENV PATH /opt/certbot/venv/bin:$PATH

RUN export BUILD_DEPS="git \
                build-base \
                libffi-dev \
                linux-headers \
                py-pip \
                python-dev" \
    && apk -U upgrade \
    && apk add dialog \
                python \
                openssl-dev \
				augeas-libs \
                ${BUILD_DEPS} \
				openssl \
	&& pip install --upgrade pip \
    && pip --no-cache-dir install virtualenv \
    && git clone https://github.com/letsencrypt/letsencrypt /opt/certbot/src \
    && virtualenv --no-site-packages -p python2 /opt/certbot/venv \
    && /opt/certbot/venv/bin/pip install \
        -e /opt/certbot/src/acme \
        -e /opt/certbot/src \
        -e /opt/certbot/src/certbot-apache \
        -e /opt/certbot/src/certbot-nginx \ 
    && apk del ${BUILD_DEPS} \
    && rm -rf /var/cache/apk/* \
	&& certbot --version

RUN chown -R nginx:nginx /opt/certbot

# ------ VOLUMES ------ #
VOLUME ["/nginx/ssl"]

# ------ CMD/START/STOP ------ #
USER nginx
CMD ["nginx", "-g", "daemon off;"]