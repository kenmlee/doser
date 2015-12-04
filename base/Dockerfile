# VERSION 0.0.1

FROM ubuntu:14.04.2
MAINTAINER Ken Lee <kenmlee@163.com>

ENV REFRESHED_AT 2015-05-17

RUN apt-get -qq update && apt-get install -y ubuntu-cloud-keyring
RUN echo "deb http://ubuntu-cloud.archive.canonical.com/ubuntu" \
   "trusty-updates/kilo main"  > /etc/apt/sources.list.d/cloudarchive-kilo.list

RUN apt-get -qq update && apt-get -y dist-upgrade

RUN apt-get install -y python-keystoneclient

ENV OS_USERNAME=admin \
    OS_TENANT_NAME=adminTenant \
    OS_PASSWORD=adminpasswd \
    OS_AUTH_URL=http://keystone:35357/v2.0 \
    OS_REGION_NAME=regionOne
