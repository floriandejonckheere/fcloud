FROM python:3-alpine
MAINTAINER Florian Dejonckheere <florian@floriandejonckheere.be>

RUN sed -e "s/v3.10/edge/" -i /etc/apk/repositories
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN apk add deluge

VOLUME /config
VOLUME /data

EXPOSE 8112
EXPOSE 58846

EXPOSE 58946
EXPOSE 58946/udp
