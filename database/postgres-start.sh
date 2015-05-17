#!/bin/sh

. ./postgres-env.sh

# Start data volume container first
docker start $DATA_VOLUME_CONTAINER

# Then start database container 
docker start $OPENSTACK_DB

