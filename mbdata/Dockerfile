FROM python:alpine
MAINTAINER Florian Dejonckheere <florian@floriandejonckheere.be>

RUN apk update && apk add postgresql-client postgresql-libs postgresql-dev gcc musl-dev
#RUN apk update && apk add py3-psycopg2 py3-six py3-certifi py3-setuptools postgresql-client git

#RUN git clone https://github.com/lalinsky/mbdata.git /tmp/mbdata
#RUN cd /tmp/mbdata && python3 setup.py install

RUN pip install psycopg2 mbdata

ADD crontab /etc/crontabs/root

CMD ["crond", "-f", "-l", "0"]
