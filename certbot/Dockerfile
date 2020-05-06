FROM python:3.7-alpine
MAINTAINER Florian Dejonckheere <florian@floriandejonckheere.be>

RUN apk add certbot docker

ADD crontab /etc/crontabs/root

CMD ["crond", "-f", "-l", "0"]
