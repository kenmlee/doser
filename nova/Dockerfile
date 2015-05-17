# Nova Controller by Ken Lee
#
# Version 0.0.1
FROM kenlee/openstack-base
MAINTAINER Ken Lee "kenmlee@163.com"

ENV REFRESHED_AT 2015-04-30

EXPOSE 8774

RUN apt-get -qq update && apt-get install -y \
	nova-api \
	nova-cert \
	nova-conductor \
	nova-consoleauth \
	nova-novncproxy \
	nova-scheduler \
	python-novaclient \
	python-psycopg2

VOLUME ["/etc/nova", "/var/log/nova"]

