FROM python:2.7.12-alpine
MAINTAINER Alpha Hinex <AlphaHinex@gmail.com>

ENV WORKDIR /opt/propersoft

ADD entrypoint.sh /entrypoint.sh

RUN apk update \
 && apk add git \
 && chmod +x /entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
