#!/bin/sh

. ./postgres-env.sh

# Stop database container first
docker stop $OPENSTACK_DB

# Then stop data volume container
docker stop $DATA_VOLUME_CONTAINER

