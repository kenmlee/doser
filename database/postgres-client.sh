#!/bin/sh

. ./postgres-env.sh

# Start a postgreSQL client container and connect to postgreSQL database
docker run -it --link $OPENSTACK_DB:postgres --rm \
  --name dbclient postgres sh -c \
  'exec psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres'
