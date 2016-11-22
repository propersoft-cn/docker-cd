FROM node:latest
MAINTAINER Alpha Hinex <AlphaHinex@gmail.com>

ENV WORKDIR /opt/ihos

ADD entrypoint.sh /entrypoint.sh

RUN apt-get update \
 && apt-get install -y git \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && chmod +x /entrypoint.sh

EXPOSE 9000 9090

ENTRYPOINT ["/entrypoint.sh"]
