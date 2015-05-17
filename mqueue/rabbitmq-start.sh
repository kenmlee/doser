#!/bin/sh

. ./rabbitmq-env.sh

# start an exist RabbitMQ server container 
docker start $OPENSTACK_MQ 
