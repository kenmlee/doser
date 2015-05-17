#!/bin/sh

. ./rabbitmq-env.sh

# Remove the RabbitMQ server container 
docker rm $OPENSTACK_MQ 
