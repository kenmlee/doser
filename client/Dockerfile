# VERSION 0.0.1

FROM kenlee/openstack-base
MAINTAINER Ken Lee <kenmlee@163.com>

ENV REFRESHED_AT 2015-04-25

# pythone-keystoneclient already include in kenlee/openstack-base image
RUN apt-get -qq update && apt-get install -y python-glanceclient

COPY openstack-init.sh /

