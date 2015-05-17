#!/bin/sh

VOLUME_CONFIG=~/openstack/nova/conf
VOLUME_LOG=~/openstack/nova/log

# start a nova contianer and linked with database
# after start, run 'nova-manager db_sync' to initialize database
docker run -it \
  --link os-db:postgres \
  --entrypoint=/bin/bash \
  --rm \
  -v $VOLUME_CONFIG:/etc/nova \
  -v $VOLUME_LOG:/var/log/nova \
  kenlee/nova
