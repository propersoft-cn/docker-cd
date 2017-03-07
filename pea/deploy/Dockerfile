FROM node:latest
MAINTAINER Alpha Hinex <AlphaHinex@gmail.com>

ENV WORKDIR /opt/pea

ADD pea-cd-entrypoint.sh /pea-cd-entrypoint.sh

RUN apt-get update \
 && apt-get install -y git \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && chmod +x /pea-cd-entrypoint.sh

EXPOSE 9000 8080

ENTRYPOINT ["/pea-cd-entrypoint.sh"]
