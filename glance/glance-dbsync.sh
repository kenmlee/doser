#!/bin/sh

VOLUME_CONFIG=~/openstack/glance/conf
VOLUME_LOG=~/openstack/glance/log
VOLUME_IMAGES=~/openstack/glance/images

# start a glance contianer and linked with database
# after start, run 'glance-manager db_sync' to initialize database
docker run -it \
  --link os-db:postgres \
  --entrypoint=/bin/bash \
  --rm \
  -v $VOLUME_CONFIG:/etc/glance \
  -v $VOLUME_LOG:/var/log/glance \
  kenlee/glance
