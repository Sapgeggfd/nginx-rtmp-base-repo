FROM debian:bookworm-slim

LABEL author="Sapge" maintainer="contact@sapge.com"


ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y git apt-transport-https lsb-release ca-certificates wget nginx libnginx-mod-rtmp \
    && apt-get purge -y --auto-remove \
    && rm -rf /var/lib/apt/lists/* 
    

RUN useradd -m -d /home/container/ -s /bin/bash container
ENV USER=container HOME=/home/container

RUN mkdir /home/container/modules-enabled \
    && mv /usr/lib/nginx/modules/ngx_rtmp_module.so /home/container/modules-enabled/ngx_rtmp_module.so

WORKDIR /home/container

STOPSIGNAL SIGINT

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD /entrypoint.sh