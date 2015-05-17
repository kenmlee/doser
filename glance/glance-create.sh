#!/bin/sh

VOLUME_CONFIG=~/openstack/glance/conf
VOLUME_LOG=~/openstack/glance/log
VOLUME_IMAGES=~/openstack/glance/images

# create  a glance-registry contianer and linked with database and keystone
# after creation, start glance-registry container
docker run -d \
  --link os-db:postgres \
  --link keystone:keystone \
  --hostname glance-registry \
  --name glance-registry \
  -v $VOLUME_CONFIG:/etc/glance \
  -v $VOLUME_LOG:/var/log/glance \
  -v $VOLUME_IMAGES:/var/lib/glance/images \
  kenlee/glance glance-registry

# create  a glance-api contianer and linked with database and keystone
# after creation, start glance-api container
docker run -d \
  --link os-db:postgres \
  --link keystone:keystone \
  --link glance-registry:glance-registry \
  --hostname glance \
  --name glance \
  -v $VOLUME_CONFIG:/etc/glance \
  -v $VOLUME_LOG:/var/log/glance \
  -v $VOLUME_IMAGES:/var/lib/glance/images \
  kenlee/glance glance-api
