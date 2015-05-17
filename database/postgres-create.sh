#!/bin/sh

. ./postgres-env.sh

# Create a data volume container for database storage
docker create -v $VOLUME:/var/lib/postgresql/data \
  --name $DATA_VOLUME_CONTAINER ubuntu /bin/true

# start a postgreSQL server container with the data volume above
docker run -d --volumes-from $DATA_VOLUME_CONTAINER \
  --hostname $OPENSTACK_DB \
  --name $OPENSTACK_DB \
  -e POSTGRES_PASSWORD=openstack-database \
  postgres
