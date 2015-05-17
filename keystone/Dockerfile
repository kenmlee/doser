# KeyStone by Ken Lee
#
# Version: 0.0.1
FROM kenlee/openstack-base
MAINTAINER Ken Lee "kenmlee@163.com"

ENV REFRESHED_AT 2015-04-23

EXPOSE 5000 35357

RUN apt-get -qq update && apt-get install -y keystone python-keystone python-psycopg2

ENTRYPOINT ["keystone-all"]

VOLUME ["/etc/keystone", "/var/log/keystone"]
