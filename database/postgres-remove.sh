#!/bin/sh

. ./postgres-env.sh

# Remove postgreSQL server container
docker rm $OPENSTACK_DB

# Remove postgreSQL data volume
docker rm $DATA_VOLUME_CONTAINER
