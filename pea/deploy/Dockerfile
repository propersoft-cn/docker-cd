FROM node:latest
MAINTAINER Alpha Hinex <AlphaHinex@gmail.com>

RUN apt-get update \
 && apt-get install -y git \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && chmod +x /pea-cd-entrypoint.sh
