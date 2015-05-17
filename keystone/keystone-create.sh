#!/bin/sh

VOLUME_CONFIG=~/openstack/keystone/conf
VOLUME_LOG=~/openstack/keystone/log

# create  a keystone contianer and linked with database
# after creation, start keystone container
docker run -d \
  --link os-db:postgres \
  --hostname keystone \
  --name keystone \
  -v $VOLUME_CONFIG:/etc/keystone \
  -v $VOLUME_LOG:/var/log/keystone \
  kenlee/keystone 
