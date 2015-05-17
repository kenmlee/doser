#!/bin/sh

VOLUME_CONFIG=~/openstack/nova/conf
VOLUME_LOG=~/openstack/nova/log

# create  a nova-cert contianer and linked with nova-api and message-queue
# after creation, start nova-cert container
docker run -d \
  --link nova:nova \
  --link os-mq:rabbitmq \
  --hostname nova-cert \
  --name nova-cert \
  -v $VOLUME_CONFIG:/etc/nova \
  -v $VOLUME_LOG:/var/log/nova \
  kenlee/nova nova-cert

# create  a nova-api contianer and linked with database, message-queue, keystone,
# glance and nova-cert
# after creation, start nova-api container
docker run -d \
  --link os-db:postgres \
  --link keystone:keystone \
  --link glance:glance \
  --link os-mq:rabbitmq \
  --link nova-cert:nova-cert \
  --hostname nova \
  --name nova-api \
  -v $VOLUME_CONFIG:/etc/nova \
  -v $VOLUME_LOG:/var/log/nova \
  kenlee/nova nova-api

# create  a nova-scheduler contianer and linked with database and message-queue
# after creation, start nova-scheduler container
docker run -d \
  --link os-db:postgres \
  --link os-mq:rabbitmq \
  --hostname nova-scheduler \
  --name nova-scheduler \
  -v $VOLUME_CONFIG:/etc/nova \
  -v $VOLUME_LOG:/var/log/nova \
  kenlee/nova nova-scheduler

# create  a nova-consoleauth contianer and linked with message-queue
# after creation, start nova-consoleauth container
docker run -d \
  --link os-mq:rabbitmq \
  --hostname nova-consoleauth \
  --name nova-consoleauth \
  -v $VOLUME_CONFIG:/etc/nova \
  -v $VOLUME_LOG:/var/log/nova \
  kenlee/nova nova-consoleauth

# create  a nova-conductor contianer and linked with database and message-queue
# after creation, start nova-conductor container
docker run -d \
  --link os-db:postgres \
  --link os-mq:rabbitmq \
  --hostname nova-conductor \
  --name nova-conductor \
  -v $VOLUME_CONFIG:/etc/nova \
  -v $VOLUME_LOG:/var/log/nova \
  kenlee/nova nova-conductor

# create  a nova-novncproxy contianer and linked with database and message-queue
# after creation, start nova-novncproxy container
docker run -d \
  --link os-db:postgres \
  --link os-mq:rabbitmq \
  --hostname nova-novncproxy \
  --name nova-novncproxy \
  -v $VOLUME_CONFIG:/etc/nova \
  -v $VOLUME_LOG:/var/log/nova \
  kenlee/nova nova-novncproxy
