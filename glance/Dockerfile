# Glance container by Ken Lee
#
# Version: 0.0.1
FROM kenlee/openstack-base
MAINTAINER Ken Lee "kenmlee@163.com"

ENV REFRESHED_AT 2015-04-30

# 9292 for glance-api, 9191 for glance-registry
EXPOSE 9292 9191

RUN apt-get -qq update && apt-get install -y glance python-glanceclient python-psycopg2

VOLUME ["/etc/glance", "/var/log/glance", "/var/lib/glance/images"]

#COPY glance-entrypoint.sh /
#ENTRYPOINT ["glance-control api start && glance-control registry start"]
